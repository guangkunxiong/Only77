using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Only77API.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class FileController:BaseController
{
    
    [HttpGet]
    [Route("GetCompressionImg")]
    public async Task<IActionResult> GetCompressionImg(Guid id)
    {
        return Ok();
    }
    
    [HttpGet]
    [Route("GetImg")]
    public async Task<IActionResult> GetImg(Guid id)
    {
        return Ok();
    }
    
    [HttpPut]
    [Route("PutAlbumsImg")]
    public async Task<IActionResult> PutAlbumsImg(IFormFile file,string albumsId)
    {
        return Ok();
    }
    
}