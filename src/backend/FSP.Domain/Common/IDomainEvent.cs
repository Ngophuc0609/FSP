using MediatR;

namespace FSP.Domain.Common;

/// <summary>
/// Marker interface for pure domain events raised by Aggregate Roots.
/// Inherits from MediatR INotification to enable decoupled event handlers across the Application layer.
/// </summary>
public interface IDomainEvent : INotification
{
}
