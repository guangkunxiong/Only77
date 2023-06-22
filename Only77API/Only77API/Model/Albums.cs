using System.ComponentModel.DataAnnotations;
using System.Reflection.Metadata.Ecma335;

namespace Only77API.Model;

public class Albums
{
    public Guid Id { get; set; }
    
    [MaxLength(450)]
    public string CreateUser { get; set; }
    
    public DateTime CreateTime { get; set; }
    
    public DateTime UpdateTime { get; set; }
    
    [MaxLength(450)]
    public string UpdateUser { get; set; }

    [MaxLength(200)]
    public string  Title { get; set; }

    public string Context { get; set; }
    
    public DateTime Date { get; set; }
    
    public bool IsDelete { get; set; } = false;
}