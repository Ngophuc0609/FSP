using System;
using FSP.Domain.Entities;

namespace FSP.Application.WorkOrders.Queries.GetWorkOrders;

public record WorkOrderSummaryDto(
    Guid Id,
    string Title,
    string Description,
    WorkOrderStatus Status,
    WorkOrderPriority Priority,
    Guid? AssignedTechnicianId,
    DateTime CreatedAtUtc,
    Guid ClientReferenceId,
    byte[] RowVersion
);

public record KeysetPaginationResult<T>(
    System.Collections.Generic.IReadOnlyList<T> Items,
    DateTime? NextCursorCreatedAt,
    Guid? NextCursorId,
    bool HasMore
);
