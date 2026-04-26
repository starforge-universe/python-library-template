# Contributing

Thank you for contributing to the Starforge Library Template. This repository provides a centralized foundation for library implementations, including reusable workflows and a versioning model that works with git branching and labels for release and public package publishing.

## How to Contribute

Use a standard fork-based workflow:

1. **Fork the repository on GitHub**
   - Create a fork under your GitHub account.

2. **Clone your fork locally**
   ```bash
   git clone https://github.com/YOUR_USERNAME/starforge-library-template.git
   cd starforge-library-template
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/starforge-universe/starforge-library-template.git
   ```

4. **Create a feature branch from main**
   ```bash
   git checkout main
   git fetch upstream
   git merge upstream/main
   git checkout -b feature/your-change
   ```

5. **Implement your changes**
   - Keep changes aligned with the template purpose.
   - Preserve compatibility with reusable workflows.
   - Update documentation when behavior or usage changes.

6. **Run checks before pushing**
   - Ensure pull request checks pass locally where possible.
   - Validate release/versioning related changes carefully.

7. **Commit and push**
   ```bash
   git add .
   git commit -m "Describe your template change"
   git push origin feature/your-change
   ```

8. **Open a pull request**
   - Target `main` in `starforge-universe/starforge-library-template`.
   - Explain what changed and why.
   - Reference any related issues.

9. **Address review feedback**
   - All checks must pass.
   - Code owner approval is required before merge.

## Branching, Labels, and Versioning

This template is designed to support reliable releases by combining:

- A clear branching model (main + feature branches)
- Pull request labels that signal change type and release intent
- Workflow-driven release and publish automation

When contributing changes that may affect release behavior:

- Call out expected version impact in the pull request.
- Apply the appropriate labels used by your release flow.
- Confirm publish/release workflow assumptions in your PR description.

## Pull Request Checks

This repository includes automated pull request validation and reusable checks workflows.

Before requesting review:

- Ensure all CI checks are green.
- Resolve linting/test failures.
- Re-run workflows after force-pushes or conflict resolution.

## Git History Preservation

When adopting this template in a downstream project, preserve git history by cloning the repository and maintaining a `template` remote. This enables regular template merges while retaining project-specific customizations.

See [README.md](README.md) and [.github/merge-instructions.md](.github/merge-instructions.md) for the recommended update flow.

## Code of Conduct

- Be respectful and constructive.
- Keep feedback actionable.
- Prefer small, focused pull requests.

## Questions

If you need help:

- Open an issue for discussion.
- Contact code owners listed in `.github/CODEOWNERS`.
