using Serilog.Core;
using Serilog.Events;

namespace Only77API.Extensions;

public class DateTimeNowEnrich : ILogEventEnricher
{
    public void Enrich(LogEvent logEvent, ILogEventPropertyFactory propertyFactory)
    {
        logEvent.AddPropertyIfAbsent(propertyFactory.CreateProperty(
            "DateTimeNow", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
    }
}
