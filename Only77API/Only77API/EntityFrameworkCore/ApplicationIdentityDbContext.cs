using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Only77API.Model;

namespace Only77API.EntityFrameworkCore;


public class ApplicationIdentityDbContext: IdentityDbContext<User>
{

    public DbSet<Rule> Rules { get; set; }
    public DbSet<PhotoStorage> PhotoStorages { get; set; }
    public DbSet<VideoStorage> VideoStorages { get; set; }
    public DbSet<Albums> Albums { get; set; }
    // public DbSet<VideoTable> VideoTables { get; set; }
    // public DbSet<ImageTable> ImageTables  { get; set; }


    public ApplicationIdentityDbContext(DbContextOptions<ApplicationIdentityDbContext> options) : base(options)
    {
        
    }
}