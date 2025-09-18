# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Basedpyright is a fork of Microsoft's Pyright type checker with additional improvements and features. It's a hybrid Python/TypeScript project that:

- Provides static type checking for Python code
- Includes a Language Server Protocol (LSP) implementation
- Packages both CLI and VS Code extension versions
- Uses Python for packaging/distribution and TypeScript for the core type checking engine

## Development Commands

### Node.js/TypeScript (Root level)
```bash
# Build and quality checks
npm run check                    # Run all checks (syncpack, eslint, prettier)
npm run check:eslint             # Run ESLint
npm run check:prettier           # Run Prettier
npm run typecheck                # Run TypeScript type checking

# Development builds
npm run build:extension:dev      # Build VS Code extension (dev)
npm run build:cli:dev            # Build CLI (dev)
npm run watch:extension          # Watch extension for changes
npm run run:cli                  # Build and run CLI
npm run run:langserver           # Build and run language server

# Testing
npm run jest                     # Run Jest tests
```

### Python (using uv)
```bash
# Type checking and linting
npm run typecheck-python         # Run basedpyright on Python code
npm run ruff-check               # Run ruff linter and formatter check
npm run ruff-fix                 # Run ruff with auto-fix
npm run pylint                   # Run pylint

# Testing
npm run test-python              # Run pytest
npm run generate-docstubs        # Generate docstubs

# Development
npm run update-python-deps       # Update Python dependencies
npm run docs                     # Serve documentation locally
```

### Build and Packaging
```bash
# Python packaging
npm run update-pyprojectx-lockfile  # Update lockfile
uv sync                           # Install Python dependencies

# LSP development
npm run lsp-inspect               # Inspect LSP traffic
npm run lsp-client                # Test LSP client
```

## Project Architecture

### Core Structure
- **`packages/pyright/`** - Main CLI package with entry points
- **`packages/pyright-internal/`** - Core type checking engine (TypeScript)
- **`packages/vscode-pyright/`** - VS Code extension
- **`packages/browser-pyright/`** - Browser-based version
- **`basedpyright/`** - Python packaging wrapper
- **`build/`** - Build tools and utilities

### Key Components
- **`packages/pyright-internal/src/analyzer/`** - Type analysis and inference
- **`packages/pyright-internal/src/languageServerBase.ts`** - LSP implementation
- **`packages/pyright-internal/src/pyright.ts`** - Main type checker logic
- **`packages/pyright-internal/src/backgroundAnalysis.ts`** - Background analysis for IDE support

### Build System
- Uses **webpack** for bundling TypeScript
- Uses **uv** for Python dependency management
- Uses **PDM** for Python packaging
- Supports both development and production builds

## Development Workflow

1. **Python changes**: Modify code in `basedpyright/` or build scripts
2. **TypeScript changes**: Modify code in `packages/*/src/`
3. **Testing**: Run both Jest (TS) and pytest (Python) tests
4. **Type checking**: Use both TypeScript and basedpyright type checkers
5. **Linting**: Use ESLint (TS) and ruff (Python)

## Important Notes

- The project uses a monorepo structure with npm workspaces
- Python scripts are used for packaging and distribution
- The core type checking logic is in TypeScript
- Entry points are wrapped in Python for PyPI distribution
- VS Code extension is built separately from the CLI tool