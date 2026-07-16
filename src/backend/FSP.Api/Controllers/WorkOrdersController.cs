using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FSP.Application.WorkOrders.Commands.CreateWorkOrder;
using FSP.Application.WorkOrders.Commands.AssignWorkOrder;
using FSP.Application.WorkOrders.Queries.GetWorkOrders;
using FSP.Application.WorkOrders.Queries.GetWorkOrderById;
using FSP.Application.WorkOrders.Commands.GenerateAttachmentUploadUrl;
using FSP.Application.WorkOrders.Commands.ConfirmAttachmentUpload;
using FSP.Application.Common.Interfaces;

namespace FSP.Api.Controllers;

[ApiController]
[Route("api/v1/work-orders")]
public class WorkOrdersController : ControllerBase
{
    private readonly IMediator _mediator;

    public WorkOrdersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    [ProducesResponseType(typeof(Guid), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Create([FromBody] CreateWorkOrderCommand command, CancellationToken cancellationToken)
    {
        var result = await _mediator.Send(command, cancellationToken);
        if (!result.IsSuccess)
        {
            if (result.ErrorCode == "VALIDATION_ERROR")
                return ValidationProblem(new ValidationProblemDetails(result.ValidationErrors));
            return BadRequest(new ProblemDetails { Title = result.ErrorCode, Detail = result.ErrorMessage });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Value }, result.Value);
    }

    [HttpGet]
    [ProducesResponseType(typeof(KeysetPaginationResult<WorkOrderSummaryDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetList([FromQuery] GetWorkOrdersQuery query, CancellationToken cancellationToken)
    {
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result.Value);
    }

    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(WorkOrderDetailsDto), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(Guid id, CancellationToken cancellationToken)
    {
        var result = await _mediator.Send(new GetWorkOrderByIdQuery(id), cancellationToken);
        if (!result.IsSuccess)
        {
            return NotFound(new ProblemDetails { Title = result.ErrorCode, Detail = result.ErrorMessage });
        }
        return Ok(result.Value);
    }

    [HttpPost("{id:guid}/assign")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status409Conflict)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status404NotFound)]
    public async Task<IActionResult> Assign(Guid id, [FromBody] AssignTechnicianRequest request, CancellationToken cancellationToken)
    {
        var command = new AssignWorkOrderCommand(id, request.TechnicianId, request.RowVersion);
        var result = await _mediator.Send(command, cancellationToken);
        
        if (!result.IsSuccess)
        {
            if (result.ErrorCode == "CONFLICT")
                return Conflict(new ProblemDetails { Title = "Concurrency Conflict", Detail = result.ErrorMessage });
            if (result.ErrorCode == "NOT_FOUND")
                return NotFound(new ProblemDetails { Title = "Not Found", Detail = result.ErrorMessage });
            if (result.ErrorCode == "VALIDATION_ERROR")
                return ValidationProblem(new ValidationProblemDetails(result.ValidationErrors));
                
            return BadRequest(new ProblemDetails { Title = result.ErrorCode, Detail = result.ErrorMessage });
        }

        return Ok(new { success = true });
    }

    [HttpPost("{id:guid}/attachments/pre-signed-url")]
    [ProducesResponseType(typeof(PreSignedUploadInfo), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> GeneratePreSignedUrl(Guid id, [FromBody] GeneratePreSignedUrlRequest request, CancellationToken cancellationToken)
    {
        var command = new GenerateAttachmentUploadUrlCommand(id, request.FileName, request.FileSizeBytes, request.FileHashSha256);
        var result = await _mediator.Send(command, cancellationToken);

        if (!result.IsSuccess)
        {
            if (result.ErrorCode == "NOT_FOUND")
                return NotFound(new ProblemDetails { Title = "Not Found", Detail = result.ErrorMessage });
            if (result.ErrorCode == "VALIDATION_ERROR")
                return ValidationProblem(new ValidationProblemDetails(result.ValidationErrors));

            return BadRequest(new ProblemDetails { Title = result.ErrorCode, Detail = result.ErrorMessage });
        }

        return Ok(result.Value);
    }

    [HttpPost("{id:guid}/attachments/confirm")]
    [ProducesResponseType(typeof(Guid), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> ConfirmAttachment(Guid id, [FromBody] ConfirmAttachmentRequest request, CancellationToken cancellationToken)
    {
        var command = new ConfirmAttachmentUploadCommand(id, request.FileName, request.BlobUrl, request.FileHashSha256, request.FileSizeBytes);
        var result = await _mediator.Send(command, cancellationToken);

        if (!result.IsSuccess)
        {
            if (result.ErrorCode == "NOT_FOUND")
                return NotFound(new ProblemDetails { Title = "Not Found", Detail = result.ErrorMessage });
            if (result.ErrorCode == "VALIDATION_ERROR")
                return ValidationProblem(new ValidationProblemDetails(result.ValidationErrors));

            return BadRequest(new ProblemDetails { Title = result.ErrorCode, Detail = result.ErrorMessage });
        }

        return Ok(result.Value);
    }
}

public record AssignTechnicianRequest(Guid TechnicianId, byte[] RowVersion);
public record GeneratePreSignedUrlRequest(string FileName, long FileSizeBytes, string FileHashSha256);
public record ConfirmAttachmentRequest(string FileName, string BlobUrl, string FileHashSha256, long FileSizeBytes);
