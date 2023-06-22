using System.ComponentModel.DataAnnotations;

namespace Only77API;

public class AlbumsDto
{

    public Guid Id { get; set; }
    
    [MaxLength(200,ErrorMessage = "标题不可以超过100个字")]
    public string  Title { get; set; }

    public string Context { get; set; }
    
    public DateTime Date { get; set; }
}