using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using MediatR;
using FSP.Domain.Common;

namespace FSP.Application.Common.Behaviors;

/// <summary>
/// MediatR Pipeline Behavior that runs all registered FluentValidation rules before executing the handler.
/// Returns Result<T>.ValidationFailure on invalid input per DEC-WO-001.
/// </summary>
public class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidationBehavior(IEnumerable<IValidator<TRequest>> validators)
    {
        _validators = validators;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        if (!_validators.Any())
            return await next();

        var context = new ValidationContext<TRequest>(request);
        var validationResults = await Task.WhenAll(_validators.Select(v => v.ValidateAsync(context, cancellationToken)));
        var failures = validationResults
            .Where(r => r.Errors.Count != 0)
            .SelectMany(r => r.Errors)
            .ToList();

        if (failures.Count != 0)
        {
            var errorsDict = failures
                .GroupBy(e => e.PropertyName, e => e.ErrorMessage)
                .ToDictionary(failureGroup => failureGroup.Key, failureGroup => failureGroup.ToArray());

            if (typeof(TResponse).IsGenericType && typeof(TResponse).GetGenericTypeDefinition() == typeof(Result<>))
            {
                var resultType = typeof(TResponse).GetGenericArguments()[0];
                var failureMethod = typeof(Result<>).MakeGenericType(resultType)
                    .GetMethod(nameof(Result<object>.ValidationFailure));
                if (failureMethod != null)
                {
                    return (TResponse)failureMethod.Invoke(null, new object[] { errorsDict })!;
                }
            }
            
            throw new ValidationException(failures);
        }

        return await next();
    }
}
