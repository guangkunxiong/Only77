using Only77API.IService;

namespace Only77API.Service;

public class BaseService:IBaseService
{
    public Task<bool> AddAsync<T>(T entity) where T : class
    {
        throw new NotImplementedException();
    }

    public Task<bool> DeleteAsync<T>(T entity) where T : class
    {
        throw new NotImplementedException();
    }

    public Task<bool> UpdateAsync<T>(T entity) where T : class
    {
        throw new NotImplementedException();
    }

    public Task<T> GetAsync<T>(string id) where T : class
    {
        throw new NotImplementedException();
    }

    public Task<List<T>> GetAllAsync<T>() where T : class
    {
        throw new NotImplementedException();
    }

    public Task<bool> SaveAsync<T>(T entity) where T : class
    {
        throw new NotImplementedException();
    }
}