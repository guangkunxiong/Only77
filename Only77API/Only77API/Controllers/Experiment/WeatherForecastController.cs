using Microsoft.AspNetCore.Mvc;
using Only77API.IService;
using Serilog;

namespace Only77API.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    private readonly ILogger<WeatherForecastController> _logger;
    private readonly ITransientDemo _transientDemo;
    private readonly IScopedDemo _scopedDemo;
    private readonly ISingletonDemo _singletonDemo;

    public WeatherForecastController(ILogger<WeatherForecastController> logger, ITransientDemo transientDemo,
        IScopedDemo scopedDemo, ISingletonDemo singletonDemo)
    {
        _logger = logger;
        _transientDemo = transientDemo;
        _scopedDemo = scopedDemo;
        _singletonDemo = singletonDemo;
    }

    [HttpGet(Name = "GetWeatherForecast")]
    public IEnumerable<WeatherForecast> Get()
    {
        _transientDemo.DoSomething();
        _scopedDemo.DoSomething();
        _singletonDemo.DoSomething();
        
        Log.Debug("Test");
        
        return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            })
            .ToArray();
    }
    
    [HttpGet(Name = "Post")]
    public bool Post()
    {
        _transientDemo.DoSomething();
        _scopedDemo.DoSomething();
        _singletonDemo.DoSomething();

        return true;
    }
}