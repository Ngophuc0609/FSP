using System;
using FSP.Domain.Common;

namespace FSP.Domain.Events;

public record WorkOrderCreatedDomainEvent(Guid WorkOrderId, Guid TenantId, string Title, Guid CreatedBy) : IDomainEvent;

public record WorkOrderAssignedDomainEvent(Guid WorkOrderId, Guid TenantId, Guid TechnicianId, Guid AssignedBy) : IDomainEvent;
