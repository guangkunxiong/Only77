using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Only77API.Model;

namespace Only77API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthenticateController : BaseController
{
    private readonly UserManager<User> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;
    private readonly IConfiguration _configuration;

    public AuthenticateController(
        UserManager<User> userManager,
        RoleManager<IdentityRole> roleManager,
        IConfiguration configuration)
    {
        _userManager = userManager;
        _roleManager = roleManager;
        _configuration = configuration;
    }

    [HttpPost]
    [Route("login")]
    public async Task<IActionResult> Login([FromBody] Login model)
    {
        var user = await _userManager.FindByNameAsync(model.Username);
        if (user == null || !await _userManager.CheckPasswordAsync(user, model.Password)) return Unauthorized();
        //var userRoles = await _userManager.GetRolesAsync(user);

        // var authClaims = new List<Claim>
        // {
        //     new(ClaimTypes.Name, user.UserName),
        //     new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
        // };
       // authClaims.AddRange(userRoles.Select(userRole => new Claim(ClaimTypes.Role, userRole)));

        var token = GenerateToken(user.Id, user.UserName);

        return Ok(new
        {
            token
            //expiration = token.ValidTo
        });
    }

    [HttpPost]
    [Route("register")]
    public async Task<IActionResult> Register([FromBody] Register model)
    {
        var userExists = await _userManager.FindByNameAsync(model.Username);
        if (userExists != null)
            return Fail(StatusCodes.Status500InternalServerError, "已经存在该用户");

        var user = new User ()
        {
            Email = model.Email,
            SecurityStamp = Guid.NewGuid().ToString(),
            UserName = model.Username,
            Lovers = ""
        };
        var result = await _userManager.CreateAsync(user, model.Password);
        return !result.Succeeded ? Fail(StatusCodes.Status500InternalServerError, result.Errors.First().Description) : Success("Success");
    }

    private string GenerateToken(string userId, string username)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Secret"]));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, userId),
            new Claim(ClaimTypes.Name, username)
        };

        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:ValidIssuer"],
            audience: _configuration["Jwt:ValidAudience"],
            claims: claims,
            expires: DateTime.Now.AddDays(Convert.ToDouble(_configuration["Jwt:ExpiresInDays"])),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}