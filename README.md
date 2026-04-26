# Starforge Library Template

A centralized template for library implementations across the Starforge Universe ecosystem. This repository provides reusable GitHub Actions workflows, a release pipeline tied to **release branches** and **git tags**, and GitHub **Environments** for test and production publishing so you can version and ship public packages in a consistent way.

**Canonical repository:** [github.com/starforge-universe/starforge-library-template](https://github.com/starforge-universe/starforge-library-template)

## Overview

This project is a **reusable source template**, not a published library on its own. It gives you shared automation and conventions for building, checking, and releasing libraries, while you keep **project-specific** code, package metadata, and policy in a fork or downstream repo.

The template is designed to be adopted **with git history preserved** (clone and retarget `origin`, not the “Use this template” flow without history) so you can still merge updates from a **`template` remote** when you need new automation from upstream Starforge template repos.

**Current automation at a glance**

| Area | What you get |
|------|----------------|
| **CI on PRs** | `pull-request-check.yaml` runs reusable checks on pull requests to `main`. |
| **Reusable jobs** | `__call__checks`, `__call__build`, `__call__publish` are called from your orchestrating workflows. |
| **Releases** | `release.yaml` runs on pushes to `release/*.*.x` branches, bumps patch from existing `v*` tags, runs test and production build/publish, then tags `v<version>`. |
| **Repo hygiene** | Dependabot for Actions, auto-merge for Dependabot PRs when policy allows, `CODEOWNERS` for review routing. |

## Versioning, branches, and releases

Releases are driven by **branch name** and **existing release tags**, not by manual `workflow_dispatch` in this template.

1. **Release line branch**  
   Use branches named `release/<major>.<minor>.x` (example: `release/1.4.x`). Pushing to such a branch triggers [`.github/workflows/release.yaml`](.github/workflows/release.yaml).

2. **Next version**  
   The workflow reads `<major>.<minor>` from the branch name, then sets **patch** to one higher than the latest matching tag `v<major>.<minor>.*` in the repo. The release version is `major.minor.patch` and the workflow creates an annotated tag `v<version>` on success.

3. **Test vs production**  
   A **test** package build uses a `.dev<run-based-suffix>` version for separation from release numbers. Publish jobs use GitHub **Environments** `test` and `production` (see `__call__publish.yaml`); configure secrets, protection rules, and approvers on those environments in the repo settings.

4. **Forks and labels**  
   Your team can still use **PR labels and branch policies** in addition to the release branch model; wire any label-driven automation in your own workflows on top of this template.

## Features

### Reusable workflows

Callable workflows (used via `workflow_call`):

- **`__call__checks.yaml`** – validation / tests (no inputs in the template; extend the job in your copy as needed).
- **`__call__build.yaml`** – build step; **inputs:** `version`, `artifact-name`.
- **`__call__publish.yaml`** – publish step; **inputs:** `environment`, `artifact-name`. The job uses `environment: ${{ inputs.environment }}` so GitHub Environment rules apply.

### Top-level orchestration

- **`pull-request-check.yaml`** – on pull requests targeting `main`, calls `__call__checks.yaml`.
- **`release.yaml`** – on `push` to `release/*.*.x`, runs version extraction, checks, test build + publish, production build + publish, then creates `v*.*.*` tag.

The older standalone `publish` dispatch workflow and the `__call__release` split have been **removed** in favor of the integrated release branch pipeline above.

### Automation

- **Auto-merge Dependabot PRs** (when checks pass) – see `auto-merge.yaml`
- **Dependabot** – GitHub Actions updates, see `.github/dependabot.yaml`
- **CODEOWNERS** – see `.github/CODEOWNERS`

## Repository structure

```
.
├── .github/
│   ├── workflows/
│   │   ├── __call__build.yaml       # Reusable build (version, artifact)
│   │   ├── __call__checks.yaml      # Reusable checks
│   │   ├── __call__publish.yaml     # Reusable publish (environment, artifact)
│   │   ├── auto-merge.yaml          # Auto-merge Dependabot PRs
│   │   ├── pull-request-check.yaml  # PR checks to main
│   │   └── release.yaml              # Release branch → test/prod + tag
│   ├── CODEOWNERS
│   ├── dependabot.yaml
│   └── merge-instructions.md
├── CONTRIBUTING.md
└── README.md
```

Optional: `.cursor/rules/` may contain maintainer rules for local git and template merges; they are not required for library consumers.

## Usage

### Adopting this template (keep history)

1. **Clone** this repository (preserves full history):
   ```bash
   git clone https://github.com/starforge-universe/starforge-library-template.git <your-project-name>
   cd <your-project-name>
   ```

2. **Point `origin` at your library repo:**
   ```bash
   git remote set-url origin <your-new-repository-url>
   ```

3. **Add a `template` remote** for upstream automation you want to merge from (example: devops or future Starforge template repos):
   ```bash
   git remote add template <template-repo-url>
   git fetch template
   ```

4. **Merge template updates** when you want them: follow [merge-instructions.md](.github/merge-instructions.md) and your own dependency/version conflict policy.

5. **Customize** the `__call__*.yaml` jobs to invoke your build tool, test runner, and package registry; keep `workflow_call` `inputs` compatible with `release.yaml` unless you change the orchestration.

**Note:** Avoid only using “Use this template” if you need mergeable history from this repo; cloning keeps that option open.

### Calling reusable workflows

`__call__build` and `__call__publish` require `with` when used from a caller workflow, for example:

```yaml
jobs:
  build:
    uses: ./.github/workflows/__call__build.yaml
    with:
      version: '1.2.3'
      artifact-name: 'package-production'
```

## Auto-merge workflow

The auto-merge workflow merges eligible Dependabot PRs when checks pass, with mergeability retry logic. See [`.github/workflows/auto-merge.yaml`](.github/workflows/auto-merge.yaml) for details.

## Template merging process

High level:

1. Update local `main` and fetch all remotes (including `template`)
2. Create a branch for the template merge
3. Merge or integrate from `template/main` (or the branch your process uses)
4. Resolve conflicts: keep your project’s dependencies and adopt template file versions where your merge instructions say to
5. Run checks, open a PR, merge when green

Details: [merge-instructions.md](.github/merge-instructions.md)

## Dependabot

- Daily checks (configurable) for GitHub Actions
- PRs for updates; optional auto-merge when checks pass and policy allows

## Code ownership

Changes are routed through `.github/CODEOWNERS` per repository settings.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This template is part of the StarForge Universe project.

## Support

For issues or questions, open an issue in this repository or contact the code owners in `CODEOWNERS`.
