using System.ComponentModel.DataAnnotations;

namespace Only77API.Model;

public class Rule
{
    [MaxLength(450)]
    public Guid Id { get; set; }

    [MaxLength(450)]
    public string UserId { get; set; }
    
    

    //public  Type { get; set; }
}