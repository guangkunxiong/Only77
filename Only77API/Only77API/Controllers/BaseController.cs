using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;

namespace Only77API.Controllers;

public class BaseController: ControllerBase
{

    [NonAction]
    protected OkObjectResult Success(string msg="success")
    {
        return Ok(new Response<bool>()
        {
            Data = true,
            Messge = msg
        });
    }
    
    [NonAction]
    protected ObjectResult Fail(int statusCode=500,string msg="fail")
    {
        return StatusCode(statusCode,new Response<bool>()
        {
            Data = false,
            Messge = msg
        });
    }

}