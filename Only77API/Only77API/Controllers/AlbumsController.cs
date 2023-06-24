using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Only77API.IService;
using Only77API.Model;

namespace Only77API.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class AlbumsController:BaseController
{
    private readonly IAlbumsService _albumsService;
    
    public AlbumsController(IAlbumsService albumsService)
    {
        _albumsService= albumsService;
    }

    [HttpPut]
    [Route("PutAlbums")]
    public async Task<IActionResult> PutAlbums([FromBody] AlbumsDto albumsDto)
    {
        var albums = new Albums()
        {
            Id = Guid.NewGuid(),
            Title = albumsDto.Title,
            Context = albumsDto.Context,
            Date = albumsDto.Date,
            CreateTime = DateTime.Now,
            CreateUser = User.Identity.Name,
            UpdateTime = DateTime.Now,
            UpdateUser = User.Identity.Name
        };
       
       return  await _albumsService.AddAsync(albums)?Ok():Fail(StatusCodes.Status500InternalServerError,"添加失败");
    }
    
    [HttpPost]
    [Route("UpdateAlbums")]
    public async Task<IActionResult> UpdateAlbums([FromBody] AlbumsDto albumsDto)
    {
        var albums=await _albumsService.GetAsync<Albums>(albumsDto.Id.ToString());
        
        if (albums == null) return Fail(StatusCodes.Status500InternalServerError,"未找到该相册");

        albums.Title = albumsDto.Title;
        albums.Context = albumsDto.Context;
        albums.Date = albumsDto.Date;
        albums.UpdateTime = DateTime.Now;
        albums.UpdateUser = User.Identity.Name;
        
        return  await _albumsService.AddAsync(albums)?Ok():Fail(StatusCodes.Status500InternalServerError,"修改失败");
    }
    
    [HttpDelete]
    [Route("UpdateAlbums")]
    public async Task<IActionResult> DeleteAlbums(Guid id)
    {
        var albums=await _albumsService.GetAsync<Albums>(id.ToString());
        
        if (albums == null) return Fail(StatusCodes.Status500InternalServerError,"未找到该相册");
        
        return  await _albumsService.DeleteAsync(albums)?Ok():Fail(StatusCodes.Status500InternalServerError,"删除失败");
    }
}