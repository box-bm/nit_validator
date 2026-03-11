# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`nit_validator` is a Flutter/Dart package that validates Guatemalan NIT (Número de Identificación Tributaria) numbers using a checksum algorithm. It works offline and supports all platforms (Android, iOS, macOS, Linux, Windows, Web).

## Commands

```bash
# Install dependencies
flutter pub get

# Run tests
flutter test

# Run a single test file
flutter test test/nit_validator_test.dart

# Analyze code (lint)
flutter analyze
```

## Architecture

The package is minimal with three key files:

- `lib/nit_validator.dart` — Public library barrel file; re-exports `src/nit_validator.dart`
- `lib/src/nit_validator.dart` — Core logic: single top-level function `validateNIT(dynamic nit) → bool`
- `test/nit_validator_test.dart` — Tests for correct NITs, empty/invalid inputs, and wrong NITs

## Validation Algorithm

The `validateNIT` function:
1. Normalizes input: uppercases and inserts a dash before the last character if missing
2. Validates format via regex `^(\d+)-(\d|K)$`
3. Computes a weighted checksum (digits reversed, multiplied by index+2, summed)
4. Verifies the check digit: `(11 - (sum % 11)) % 11`, where 10 maps to `"K"`

## Publishing

The package is published to pub.dev. The `pubspec.yaml` SDK constraint is `>=2.18.6 <3.0.0`. CI runs on push/PR to `main` via GitHub Actions (`.github/workflows/ci.yml`).
