# Functional Risk Evaluation Engine

A functional risk evaluation engine that models trade compliance decisions using typed records, pure scoring functions, and explainable rule evaluation.

---

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

---

## Architecture

The engine is structured in three layers:

1. **Domain Layer** – strongly typed trade and decision models  
2. **Scoring Layer** – pure risk evaluation logic  
3. **Execution Layer** – command-line interface and scenario runner  

This separation keeps business rules deterministic and independent from I/O.

---

## Why OCaml

I built this project in OCaml to explore how functional programming can improve correctness in decision systems.

Using immutable records, variant types, and pure functions made the risk logic easier to reason about, easier to test, and less dependent on hidden mutable state.

OCaml also encouraged a cleaner separation between typed domain modeling, deterministic rule evaluation, and command-line execution.

---

## Project Structure

- `lib/types.ml` — domain types for trades, decisions, and evaluations  
- `lib/risk.ml` — pure risk scoring and decision logic  
- `bin/main.ml` — CLI entry point with sample scenarios  
- `test/test_risk.ml` — correctness checks for core decision rules  

---

## Features

- typed domain modeling with OCaml records and variants  
- pure scoring functions with no hidden mutable state  
- explainable decisions through reason strings  
- hard-block rules for sanctioned entities  
- modular project structure using Dune  
- automated tests  

---

## How to Run

Build the project:

```bash
dune build
```

Run all sample scenarios:

```bash
dune exec risk_engine -- all
```

Run one scenario at a time:

```bash
dune exec risk_engine -- approve
dune exec risk_engine -- review
dune exec risk_engine -- block
```

Run tests:

```bash
dune runtest
```

---

## Example Output

Example run:

```bash
dune exec risk_engine -- all
```

Example output:

```text
Exporter: Shell Trading Limited UAE
Country: UAE
Amount: $1250000.00
Risk Score: 100
Decision: REVIEW
Reasons:
- elevated country risk
- high transaction amount
- moderate entity match confidence
- blurry or unclear stamp
------------------------------
Exporter: North Sea Metals
Country: Norway
Amount: $90000.00
Risk Score: 5
Decision: APPROVE
Reasons:
- low transaction amount
------------------------------
Exporter: Eastern Energy Holdings
Country: Russia
Amount: $400000.00
Risk Score: 240
Decision: BLOCK
Reasons:
- explicit sanctions flag
- sanctioned or high-risk country
- moderate transaction amount
- moderate entity match confidence
------------------------------
```

---

## Future Work

- parse trades from CSV input  
- expose thresholds through configuration  
- separate scoring and policy layers  
- extend entity matching logic  