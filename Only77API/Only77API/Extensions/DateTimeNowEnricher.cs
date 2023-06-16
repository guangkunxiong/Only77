using System;
using Serilog.Core;
using Serilog.Events;

namespace Namespace;
public class DateTimeNowEnricher : ILogEventEnricher
{
    public void Enrich(LogEvent logEvent, ILogEventPropertyFactory propertyFactory)
    {
        logEvent.AddPropertyIfAbsent(propertyFactory.CreateProperty(
            "DateTimeNow", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
    }
}
