# Universal Project Setup Specification

## Essential Documentation

### README
- **Purpose**: Project overview and quick start
- **Contents**:
  - Project description and goals
  - Installation instructions
  - Basic usage examples
  - Configuration requirements
  - Contribution guidelines (if applicable)
  - License information

### API Documentation
- Document **all public interfaces**
- Include parameters, return values, exceptions
- Provide usage examples
- Keep documentation in sync with code

### Configuration Documentation
- **Document all configuration options**
- Specify required vs optional settings
- Include default values
- Explain environment-specific settings

## Code Quality Tools

### Automatic Formatting
- Use **language-specific formatters**:
  - **Prettier** (JavaScript/TypeScript)
  - **Black/Ruff** (Python)
  - **gofmt** (Go)
  - **rustfmt** (Rust)
  - **clang-format** (C/C++)

### Formatting Standards
- Maintain **reasonable line length** (80-120 characters)
- Consistent indentation (language-dependent)
- Automated formatting in CI/CD pipeline

## Configuration Management

### Externalize Configuration
- **Never hardcode** environment-specific values
- Use:
  - Environment variables
  - Configuration files (YAML, JSON, TOML)
  - Secret management systems

### Configuration Hierarchy
1. **Defaults** - Sensible built-in defaults
2. **Config files** - Deployment-specific settings
3. **Environment variables** - Override mechanism
4. **Command-line arguments** - Highest precedence

### Sensitive Data
- **Never commit secrets** to version control
- Use `.gitignore` for sensitive files
- Use secret management tools:
  - Environment variables
  - Vault systems
  - Cloud secret managers

## Dependency Management

### Dependency Declaration
- Use **language-specific package managers**:
  - `package.json` (Node.js)
  - `pyproject.toml` or `requirements.txt` (Python)
  - `go.mod` (Go)
  - `Cargo.toml` (Rust)
  - `composer.json` (PHP)

### Version Pinning
- **Pin major versions** for stability
- Document compatibility requirements
- Regular dependency updates

### Dependency Security
- Regularly audit dependencies
- Use security scanning tools
- Keep dependencies updated

## Project Structure

### Standard Directories
- **`src/`** or **`lib/`**: Source code
- **`tests/`**: Test files
- **`docs/`**: Documentation
- **`config/`** or **`.config/`**: Configuration files
- **`scripts/`**: Build and utility scripts

### File Organization
- Group by **domain/feature**, not by type
- Keep related files together
- Avoid deep nesting (3-4 levels max)

## Version Control

### .gitignore
- Ignore build artifacts
- Ignore dependency directories
- Ignore environment-specific files
- Ignore sensitive data files

### Essential Files
- `README.md`
- `LICENSE`
- `.gitignore`
- Package/dependency manifest
- Build configuration

## Testing Infrastructure

### Test Framework
- Use **established test frameworks**
- Organize tests by type:
  - Unit tests
  - Integration tests
  - End-to-end tests

### Test Coverage
- Track code coverage metrics
- Set minimum coverage thresholds
- Include coverage in CI/CD

## Continuous Integration

### CI/CD Pipeline
- Automated testing on commits
- Code quality checks
- Build verification
- Deployment automation (when applicable)

### Pre-commit Hooks
- Format checking
- Lint checking
- Test execution
- Commit message validation

## License and Legal

### License File
- Include appropriate LICENSE file
- Choose license based on project goals
- Document third-party licenses

## Language-Agnostic Application

These setup standards apply across all projects:

1. **Clear documentation**
2. **Automated formatting**
3. **Configuration externalization**
4. **Dependency management**
5. **Version control best practices**
6. **Testing infrastructure**
7. **CI/CD integration**
