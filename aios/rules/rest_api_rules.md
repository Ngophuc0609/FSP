# REST API Guidelines

**Identifier**: R-API-REST-001
**Category**: API
**Applies To**: API Designer, Backend, Frontend
**Severity**: High

## 1. Description
Ensures APIs are intuitive, consistent, and standard-compliant across the FSP system.

## 2. Rules
*   **Nouns, Not Verbs**: URIs must represent resources (nouns), not actions. Use HTTP verbs for actions.
    *   *Correct*: `POST /work-orders`
    *   *Incorrect*: `POST /createWorkOrder`
*   **Pluralization**: Resource names should be pluralized (`/users`, `/work-orders`).
*   **HTTP Methods**:
    *   `GET`: Read resource(s)
    *   `POST`: Create resource
    *   `PUT`: Replace resource entirely
    *   `PATCH`: Partially update resource
    *   `DELETE`: Remove resource
*   **Status Codes**: Use standard HTTP status codes correctly (200 OK, 201 Created, 204 No Content, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 409 Conflict).
*   **Error Responses**: Must conform to RFC 7807 Problem Details for HTTP APIs.
*   **Versioning**: All APIs must be versioned. (e.g., `/api/v1/work-orders`).

## 3. References
*   [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
