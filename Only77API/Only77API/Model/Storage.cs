using System.ComponentModel.DataAnnotations;

namespace Only77API.Model;

public class Storage
{
    public Guid Id { get; set; }

    [MaxLength(450)]
    public string CreateUser { get; set; }

    public DateTime CreateTime { get; set; }

    [MaxLength(450)]
    public string UpdateUser { get; set; }

    public DateTime UpdateTime { get; set; }

    public bool IsDelete { get; set; } = false;
    
    public Guid FileId { get; set; }
    
    public Guid AlbumsId { get; set; }
}