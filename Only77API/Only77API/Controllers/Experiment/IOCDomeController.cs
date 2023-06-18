using Microsoft.AspNetCore.Mvc;
using Only77API.IService;

namespace Only77API.Controllers.Experiment;

[ApiController]
[Route("api/[controller]/[action]")]
public class IocDomeController : ControllerBase
{
    private readonly IServiceProvider _serviceProvider;

    public IocDomeController(IServiceProvider serviceProvider)
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