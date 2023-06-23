
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace Only77API.Model;

public class User:IdentityUser
{
    [MaxLength(450)]
    public string Lovers { get; set; }

    public Guid PictureId { get; set; }
}