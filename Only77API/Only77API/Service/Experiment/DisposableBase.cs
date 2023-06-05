namespace Only77API.Service;

public class DisposableBase:IDisposable
{
    protected int Id { get; init; }

    public void Dispose()
    {
        Console.WriteLine($"服务为{GetType().Name},Id为{Id},被回收了");
    }
    
    public void DoSomething()
    {
        Console.WriteLine($"服务为{GetType().Name},Id为{Id},正在做一些事情");
    }
}