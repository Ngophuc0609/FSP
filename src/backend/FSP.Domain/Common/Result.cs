using System;
using System.Collections.Generic;

namespace FSP.Domain.Common;

/// <summary>
/// Lightweight Result Monad for CQRS Command/Query handlers per DEC-WO-001.
/// Eliminates expensive exception-throwing across control flows while mapping cleanly to ProblemDetails (RFC 7807).
/// </summary>
public class Result<T>
{
    public bool IsSuccess { get; }
    public T? Value { get; }
    public string? ErrorMessage { get; }
    public string? ErrorCode { get; }
    public Dictionary<string, string[]> ValidationErrors { get; } = new();

    private Result(T value)
    {
        IsSuccess = true;
        Value = value;
    }

    private Result(string errorCode, string errorMessage, Dictionary<string, string[]>? validationErrors = null)
    {
        IsSuccess = false;
        ErrorCode = errorCode;
        ErrorMessage = errorMessage;
        if (validationErrors != null)
            ValidationErrors = validationErrors;
    }

    public static Result<T> Success(T value) => new(value);
    public static Result<T> Failure(string errorCode, string errorMessage) => new(errorCode, errorMessage);
    public static Result<T> ValidationFailure(Dictionary<string, string[]> validationErrors) => 
        new("VALIDATION_ERROR", "One or more validation errors occurred.", validationErrors);
    public static Result<T> NotFound(string errorMessage) => new("NOT_FOUND", errorMessage);
    public static Result<T> Conflict(string errorMessage) => new("CONFLICT", errorMessage);
}
