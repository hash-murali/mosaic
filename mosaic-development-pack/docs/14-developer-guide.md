# Developer onboarding and workflow

## Existing Mac baseline

History reports /Volumes/MacSSD/Developer/Projects/mosaic, main branch, external Xcode and relocated build data. Those facts are not currently inspected. Do not reinstall tools, reinitialize Git, change global identity, erase SSD, or overwrite project files based on this document.

Start with read-only inventory in the actual code workspace: pwd, git status, git log, current Xcode path/version, Swift version, target list and applicable AGENTS.md. Commands on the Mac:

```bash
git status --short --branch
git log -5 --oneline
xcode-select -p
xcodebuild -version
swift --version
```

Use xcodebuild -list only after discovering the actual project/workspace filename. No scheme/signing/team ID is assumed. Store report in docs/evidence/repository-inventory.md with no private account tokens or screenshots.

## Suggested repository shape

Apps/ for actual platform targets, Packages/MosaicCore/ for shared modules, docs/, contracts/, database/, Tests/Fixtures/Synthetic/, scripts/. Adapt to existing Xcode layout; avoid duplicate project skeletons. External directories for vault/model assets/recovery are not repository folders. iPhone/iPad use app containers.

Minimum supported OS and model capability are decided in MOS-002 after actual hardware inventory. v0.1 needs existing Xcode and Git; no Docker, backend cloud account or large downloaded LLM is required. SQLCipher integration/license and embedding library are pending spikes, not locked package versions.

## Git and agent workflow

Task branch per bounded change; review diff for private data, unrelated edits and contract changes. Main stays buildable. Commit messages describe outcome and reference MOS/R IDs. Preserve Package.resolved once dependencies chosen. No keys, signing material, databases, extracted real content or diagnostics in Git. gitignore is insufficient against differently named files; manual/private artifact checks still needed.

Merge root AGENTS.md/.gitignore from pack deliberately rather than overwrite existing files. Assign a coding task its requirement, relevant docs, permitted scope and acceptance test. Agents operate on synthetic inputs. Do not grant access to the personal vault solely because the code task touches storage. Separate macOS account/filesystem permissions offer a stronger boundary.

## Definition of ready

Task has user/technical outcome, R/NF linkage, owned interfaces, explicit data/privacy impact, known dependencies, synthetic fixture and observable acceptance criteria. Unknown mechanism may be a time-bounded spike. Do not require every late-version screen to be final before starting v0.1.

## Definition of done

Outcome demonstrated; meaningful tests passed; affected contracts/ADRs/docs updated; authorization and error/accessibility states covered; migration/recovery consequence checked; no blocking defect. Record actual command/build/device and outcome. Do not equate synthetic SQL checks with encryption evidence.

## Initial work order

MOS-001 inventory -> MOS-002 capability matrix -> MOS-003/004 storage/key/recovery spikes. MOS-005 extension can follow after staging decision; MOS-006 domain contracts can progress with synthetic data. Build the Mac slice after foundational risks pass, then mobile capture, then AI/review, then beta hardening.
