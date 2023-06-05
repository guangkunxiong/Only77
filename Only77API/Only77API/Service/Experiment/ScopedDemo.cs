using Only77API.IService;

namespace Only77API.Service;

public class ScopedDemo: DisposableBase,IScopedDemo
{
    private static int id = 0;

    public ScopedDemo()
    {
        Id=id++;
        Console.WriteLine($"服务为{GetType().Name},Id为{Id},被构造了");
    }


}