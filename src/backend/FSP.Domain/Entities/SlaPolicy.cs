using System;
using FSP.Domain.Common;

namespace FSP.Domain.Entities;

public class SlaPolicy : BaseTenantEntity
{
    public string Name { get; private set; } = string.Empty;
    public int TargetResponseMinutes { get; private set; }
    public int TargetResolutionMinutes { get; private set; }
    public string CalendarId { get; private set; } = string.Empty;

    private SlaPolicy() : base() { }

    private SlaPolicy(Guid tenantId, Guid createdBy) : base(tenantId, createdBy) { }

    public static SlaPolicy Create(
        Guid tenantId,
        string name,
        int targetResponseMinutes,
        int targetResolutionMinutes,
        string calendarId,
        Guid createdBy)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new ArgumentException("Name cannot be empty", nameof(name));
            
        if (targetResponseMinutes <= 0)
            throw new ArgumentException("Response minutes must be greater than zero", nameof(targetResponseMinutes));
            
        if (targetResolutionMinutes <= targetResponseMinutes)
            throw new ArgumentException("Resolution minutes must be greater than response minutes", nameof(targetResolutionMinutes));

        return new SlaPolicy(tenantId, createdBy)
        {
            Name = name,
            TargetResponseMinutes = targetResponseMinutes,
            TargetResolutionMinutes = targetResolutionMinutes,
            CalendarId = calendarId
        };
    }
}
