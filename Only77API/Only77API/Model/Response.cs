namespace Only77API;

public class Response<T>
{
    private string Messge { get; init; }
    private int Status { get; init; }
    private T Data { get; init; }


    public static Response<T> Success(T data, string message)
    {
        return new Response<T>()
        {
            Messge = message,
            Status = 1,
            Data = data
        };
    }

    public static Response<T> Success(T data) => Success(data, "Success");

    public static Response<bool> Success(string message) => new()
    {
        Messge = message,
        Status = 1,
        Data = true
    };

    public static Response<T> Error(T data, string message)
    {
        return new Response<T>()
        {
            Messge = message,
            Status = 1,
            Data = data
        };
    }

    public static Response<T> Error(T data) => Error(data, "Error");

    public static Response<bool> Error(string message) => new()
    {
        Messge = message,
        Status = 0,
        Data = false
    };
}