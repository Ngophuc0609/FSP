using System;

namespace FSP.Domain.Entities;

public enum SlaStatus
{
    OnTrack = 0,
    Warning = 1,
    Breached = 2,
    Paused = 3
}

public class WorkOrderSlaTracker
{
    public SlaStatus Status { get; private set; }
    public int AccumulatedWorkingMinutes { get; private set; }
    public DateTime? NextCheckpointUtc { get; private set; }
    public DateTime? WarningNotifiedUtc { get; private set; }
    public DateTime? BreachNotifiedUtc { get; private set; }

    private WorkOrderSlaTracker() { } // EF Core

    public WorkOrderSlaTracker(DateTime? nextCheckpointUtc)
    {
        Status = SlaStatus.OnTrack;
        AccumulatedWorkingMinutes = 0;
        NextCheckpointUtc = nextCheckpointUtc;
    }

    public void UpdateStatus(SlaStatus newStatus)
    {
        Status = newStatus;
    }

    public void MarkWarningNotified(DateTime utcNow)
    {
        WarningNotifiedUtc = utcNow;
    }

    public void MarkBreachNotified(DateTime utcNow)
    {
        BreachNotifiedUtc = utcNow;
    }

    public void AddWorkingMinutes(int minutes)
    {
        if (minutes < 0) throw new ArgumentOutOfRangeException(nameof(minutes));
        AccumulatedWorkingMinutes += minutes;
    }

    public void SetNextCheckpoint(DateTime? checkpointUtc)
    {
        NextCheckpointUtc = checkpointUtc;
    }
}
