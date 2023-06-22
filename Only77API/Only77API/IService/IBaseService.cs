namespace Only77API.IService;

public interface IBaseService
{
    
    Task<bool> AddAsync<T>(T entity) where T : class;
    
    Task<bool> DeleteAsync<T>(T entity) where T : class;
    
    Task<bool> UpdateAsync<T>(T entity) where T : class;
    
    Task<T> GetAsync<T>(string id) where T : class;
    
    Task<List<T>> GetAllAsync<T>() where T : class;
    
    Task<bool> SaveAsync<T>(T entity) where T : class;
    
}