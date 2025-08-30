# Contributing to MatrixOS Layer 0

Thank you for your interest in contributing to MatrixOS Layer 0! We appreciate your time and effort in making this project better.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Reporting Issues](#reporting-issues)
- [License](#license)

## Code of Conduct

This project and everyone participating in it is governed by our [Covenant](./COVENANT.md). By participating, you are expected to uphold this code. Please report any unacceptable behavior.

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** the project to your own machine
3. **Install** dependencies: `pnpm install`
4. **Create a branch** for your changes: `git checkout -b feature/amazing-feature`
5. **Commit** your changes: `git commit -m 'Add some amazing feature'`
6. **Push** to your fork: `git push origin feature/amazing-feature`
7. Open a **Pull Request**

## Development Workflow

### Prerequisites

- Node.js 20.x
- PNPM 9.x
- Git

### Setup

```bash
# Install dependencies
pnpm install

# Run development server
pnpm dev

# Run tests
pnpm test

# Build for production
pnpm build
```

## Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a build.
2. Update the README.md with details of changes to the interface, this includes new environment variables, exposed ports, useful file locations, and container parameters.
3. Increase the version numbers in any example files and the README.md to the new version that this Pull Request would represent. The versioning scheme we use is [SemVer](http://semver.org/).
4. You may merge the Pull Request in once you have the sign-off of two other developers, or if you do not have permission to do that, you may request the second reviewer to merge it for you.

## Code Style

- Use 2 spaces for indentation
- Use single quotes for strings
- Follow the existing code style in the project
- Always add JSDoc/TSDoc comments for public APIs
- Write meaningful commit messages following the [Conventional Commits](https://www.conventionalcommits.org/) specification

## Reporting Issues

When creating an issue, please include:

- A clear, descriptive title
- A description of the issue
- Steps to reproduce the issue
- Expected vs actual behavior
- Any relevant error messages or logs
- Your environment (OS, Node.js version, etc.)

## License

By contributing, you agree that your contributions will be licensed under its MIT License.

---

Thank you for your contribution! 🌟
