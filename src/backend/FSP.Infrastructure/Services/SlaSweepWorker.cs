using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using FSP.Domain.Entities;
using FSP.Infrastructure.Persistence;

namespace FSP.Infrastructure.Services;

public class SlaSweepWorker : BackgroundService
{
    private readonly ILogger<SlaSweepWorker> _logger;
    private readonly IServiceProvider _serviceProvider;
    private readonly TimeSpan _sweepInterval = TimeSpan.FromSeconds(15);
    private const int ChunkSize = 500;

    public SlaSweepWorker(ILogger<SlaSweepWorker> logger, IServiceProvider serviceProvider)
    {
        _logger = logger;
        _serviceProvider = serviceProvider;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("SlaSweepWorker starting.");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await ProcessSlaCheckpointsAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred executing SLA sweep.");
            }

            await Task.Delay(_sweepInterval, stoppingToken);
        }
    }

    private async Task ProcessSlaCheckpointsAsync(CancellationToken stoppingToken)
    {
        using var scope = _serviceProvider.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<FspDbContext>();

        var nowUtc = DateTime.UtcNow;

        // Find work orders where the next checkpoint has been reached
        // Uses the IX_WorkOrders_SlaSweep composite index for performance
        var workOrdersToProcess = await dbContext.WorkOrders
            .Where(w => 
                (w.Status == WorkOrderStatus.PendingDispatch || 
                 w.Status == WorkOrderStatus.Assigned || 
                 w.Status == WorkOrderStatus.EnRoute || 
                 w.Status == WorkOrderStatus.InProgress) &&
                w.SlaTracker != null && 
                w.SlaTracker.NextCheckpointUtc != null &&
                w.SlaTracker.NextCheckpointUtc <= nowUtc)
            .OrderBy(w => w.SlaTracker!.NextCheckpointUtc)
            .Take(ChunkSize)
            .ToListAsync(stoppingToken);

        if (!workOrdersToProcess.Any())
            return;

        _logger.LogInformation("Processing SLA checkpoints for {Count} work orders.", workOrdersToProcess.Count);

        foreach (var workOrder in workOrdersToProcess)
        {
            // Business logic to re-evaluate SLA would go here.
            // For now, we clear the next checkpoint to prevent processing it again until recalculated.
            workOrder.SlaTracker?.SetNextCheckpoint(null);
        }

        await dbContext.SaveChangesAsync(stoppingToken);
    }
}
