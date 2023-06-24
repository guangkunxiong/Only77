using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Only77API.EntityFrameworkCore;
using Only77API.Extensions;
using Only77API.Model;
using Serilog;
using Serilog.Events;

static string LogFilePath(string LogEvent) => $@"Logs\{LogEvent}\log.log";
var serilogOutputTemplate =
    "{NewLine}{NewLine}Date:{Timestamp:yyyy-MM-dd HH:mm:ss.fff} LogLevel：{Level}{NewLine}{Message}{NewLine}" +
    new string('-', 50) + "{NewLine}";
Log.Logger = new LoggerConfiguration()
    .Enrich.With(new DateTimeNowEnrich())
    .MinimumLevel.Debug() //最小记录级别
    .Enrich.FromLogContext() //记录相关上下文信息 
    .MinimumLevel.Override("Microsoft", LogEventLevel.Information) //对其他日志进行重写,除此之外,目前框架只有微软自带的日志组件
    .WriteTo.Logger(lg =>
        lg.Filter.ByIncludingOnly(p => p.Level == LogEventLevel.Debug).WriteTo.File(LogFilePath("Debug"),
            rollingInterval: RollingInterval.Day, outputTemplate: serilogOutputTemplate))
    .WriteTo.Logger(lg => lg.Filter.ByIncludingOnly(p => p.Level == LogEventLevel.Information).WriteTo.File(
        LogFilePath("Information"), rollingInterval: RollingInterval.Day, outputTemplate: serilogOutputTemplate))
    .WriteTo.Logger(lg =>
        lg.Filter.ByIncludingOnly(p => p.Level == LogEventLevel.Warning).WriteTo.File(LogFilePath("Warning"),
            rollingInterval: RollingInterval.Day, outputTemplate: serilogOutputTemplate))
    .WriteTo.Logger(lg =>
        lg.Filter.ByIncludingOnly(p => p.Level == LogEventLevel.Error).WriteTo.File(LogFilePath("Error"),
            rollingInterval: RollingInterval.Day, outputTemplate: serilogOutputTemplate))
    .WriteTo.Logger(lg =>
        lg.Filter.ByIncludingOnly(p => p.Level == LogEventLevel.Fatal).WriteTo.File(LogFilePath("Fatal"),
            rollingInterval: RollingInterval.Day, outputTemplate: serilogOutputTemplate))
    .CreateLogger();

var builder = WebApplication.CreateBuilder(args);

var configuration = builder.Configuration;
builder.Services.AddQueuePolicy(option =>
{
    option.MaxConcurrentRequests = 2;
    option.RequestQueueLimit = 3;
});

builder.Services.AddSerilog(dispose: true);

//跨域
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", corsPolicyBuilder =>
    {
        corsPolicyBuilder.AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});

builder.Services.AddDbContext<ApplicationIdentityDbContext>(options =>
    options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddIdentity<User, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationIdentityDbContext>()
    .AddDefaultTokenProviders();

builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 6;
    options.Password.RequiredUniqueChars = 1;
});
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = configuration["Jwt:ValidIssuer"],
            ValidAudience = configuration["Jwt:ValidAudience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Secret"]))
        };
    });

builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});;
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
// 配置 Swagger
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "77 API", Version = "v1" });

    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

app.UseCors("AllowAll"); //允许所有的跨域
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
       // c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
        c.OAuthClientId("swagger");
        c.OAuthClientSecret("swagger_secret");
        c.OAuthAppName("Swagger");
    });
}

app.UseConcurrencyLimiter();
app.UseHttpsRedirection();
app.UseRouting();
app.UseAuthorization();
app.UseAuthentication();
app.MapControllers();
app.UseSerilogRequestLogging();

app.Run();