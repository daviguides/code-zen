# Universal Error Handling Specification

## Fundamental Principles

### Errors Must Never Pass Silently
- **Problems must be visible** and reported
- **Failures must be obvious** so they can be fixed
- Use language-appropriate exception/error systems

### Unless Explicitly Silenced
- Error suppression must be **deliberate and conscious**
- Document **why** errors are being suppressed
- Use specific exception types, never catch-all

## Error Reporting

### Include Sufficient Context
- **Error messages must be informative**
- Include relevant values, states, and conditions
- Facilitate **debugging** with contextual information

### Structured Error Information
- Error type/class
- Human-readable message
- Relevant data (sanitized if sensitive)
- Stack trace/call chain when available
- Timestamp and source location

## Error Handling Strategies

### Fail Fast
- Validate inputs **before** processing
- Check preconditions **at function entry**
- Don't continue with invalid state

### Explicit Error Types
- Use specific error/exception types
- Create custom error types for domain-specific errors
- Never use generic catch-all exceptions

### Error Propagation
- Propagate errors to appropriate handling level
- Don't catch errors you can't handle
- Add context when re-throwing

## Logging Requirements

### Log Errors with Severity
- **CRITICAL**: System failures requiring immediate attention
- **ERROR**: Operational errors affecting functionality
- **WARNING**: Potential issues not blocking execution
- **INFO**: Significant operational events
- **DEBUG**: Detailed diagnostic information

### Log Context, Not Secrets
- Include relevant error context
- **Never log sensitive information**: passwords, tokens, PII
- Sanitize data before logging

## Validation Requirements

### Input Validation
- Validate **all external inputs**
- Check data types, ranges, formats
- Fail with clear validation errors

### Precondition Checks
- Validate function preconditions
- Check required dependencies exist
- Verify system state before operations

### Postcondition Validation
- Verify expected results after operations
- Check invariants are maintained
- Validate state transitions

## Error Recovery

### Graceful Degradation
- System should degrade gracefully on errors
- Provide fallback functionality when possible
- Maintain system stability

### Retry Logic (When Appropriate)
- Implement retries for transient failures
- Use exponential backoff
- Set maximum retry limits
- Log retry attempts

## Documentation Requirements

### Document Error Conditions
- List possible exceptions/errors in function documentation
- Describe when each error occurs
- Specify expected caller handling

### Error Message Standards
- Write clear, actionable error messages
- Use consistent error message format
- Include "what went wrong" and "what to do"

## Language-Agnostic Application

These principles apply across all programming languages:

1. **Explicit error handling** (never silent failures)
2. **Meaningful error messages**
3. **Appropriate error types**
4. **Context preservation**
5. **Security-conscious logging**
