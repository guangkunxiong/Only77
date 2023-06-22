using System.ComponentModel.DataAnnotations.Schema;

namespace Only77API.Model;

public class VideoTable
{
    [Column("stream_id")]
    public Guid StreamId { get; set; }

    [Column("file_stream")]
    public string FileStream { get; set; } 
    
    [Column("name")]
    public string Name { get; set; } 
    
    [Column("path_locator")]
    public string PathLocator { get; set; } 
}