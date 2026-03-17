# Functional Risk Evaluation Engine

A small OCaml project that models trade compliance decisions using typed records, pure scoring functions, and explainable rule evaluation.

## Overview

This engine evaluates trade records and returns one of three decisions:

- `APPROVE`
- `REVIEW`
- `BLOCK`

The system combines:

- country risk
- transaction amount
- entity match confidence
- document quality
- sanctions flags

It also supports hard-block overrides for explicitly sanctioned cases.

## Project Structure

- `lib/types.ml` — domain types for trades, decisions, and evaluations
- `lib/risk.ml` — pure risk scoring and decision logic
- `bin/main.ml` — CLI entry point with sample scenarios
- `test/test_risk.ml` — correctness checks for core decision rules

## Features

- typed domain modeling with OCaml records and variants
- pure scoring functions with no hidden mutable state
- explainable decisions through reason strings
- hard-block rules for sanctioned entities
- modular project structure using Dune
- automated tests

## Run

Build the project:

```bash
dune build