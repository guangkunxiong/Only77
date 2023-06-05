using Microsoft.AspNetCore.Mvc;
using Only77API.IService;
using Only77API.Service;

namespace Only77API.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class IOCDomeController : ControllerBase
{
    private readonly IServiceProvider _serviceProvider;

    public IOCDomeController(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    [HttpGet(Name = "GetDemo")]
    public bool Get()
    {
        using (var scope=_serviceProvider.CreateScope())
        {
            scope.ServiceProvider.GetService<ISingletonDemo>();
            scope.ServiceProvider.GetService<ITransientDemo>();
            scope.ServiceProvider.GetService<IScopedDemo>();
        }
        _serviceProvider.GetService<IScopedDemo>();
        _serviceProvider.GetService<ITransientDemo>();

        return true;
    }
}