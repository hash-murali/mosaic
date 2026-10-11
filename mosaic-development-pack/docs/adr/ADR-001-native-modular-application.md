# ADR 001 Native modular application

Status accepted direction; implementation evidence pending. Date 2026-10-02.

Context: target Apple platforms, Photos/Vision integration and local ownership. Decision: SwiftUI clients, shared Swift domain/application contracts, platform-specific adapters, modular app through v0.4.0. No backend/microservices required.

Alternatives: cross-platform UI reduces language duplication but adds native extension and permission integration work; server-first architecture adds operations and content-egress risk before user value. Consequences: Apple toolchain/signing/device tests required; remote environment cannot establish build success. Validation MOS-001/002 and native Mac slice. Affects R01–R20.
