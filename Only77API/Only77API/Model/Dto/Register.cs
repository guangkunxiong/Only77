using System.ComponentModel.DataAnnotations;

namespace Only77API;

public class Register
{
    [Required(ErrorMessage = "用户名不能为空")] public string? Username { get; set; }
 
    [EmailAddress]
    [Required(ErrorMessage = "邮件不能为空")]
    public string? Email { get; set; }
 
    [Required(ErrorMessage = "密码不能为空")] public string? Password { get; set; }
}