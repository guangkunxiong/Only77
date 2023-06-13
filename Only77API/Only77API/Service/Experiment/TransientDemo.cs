using System;
using Only77API.IService;

namespace Only77API.Service;

public class TransientDemo: DisposableBase,ITransientDemo
{
    private static int id = 0;

    public TransientDemo()
    {
        Id=id++;
        Console.WriteLine($"服务为{GetType().Name},Id为{Id},被构造了");
    }
}