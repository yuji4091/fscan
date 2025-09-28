Claude GitHub Actions 设置指南

Manual Setup (Direct API)

Requirements: You must be a repository admin to complete these steps.

1. Install the Claude GitHub app
   - Go to: <https://github.com/apps/claude>
   - Install it to this repository (or org) with appropriate permissions.

2. Add authentication to repository secrets
   - Go to this repository → Settings → Secrets and variables → Actions → New repository secret
   - Add one of the following secrets:
     - `ANTHROPIC_API_KEY` : Your Anthropic API key (recommended)
     - `CLAUDE_CODE_OAUTH_TOKEN` : OAuth token for Claude Code (Pro/Max users)
   - Do NOT commit keys into the repo.

3. Workflow file
   - A template `claude.yml` has been added to `.github/workflows/claude.yml`.
   - It uses `anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}` by default. Edit the workflow if you want to use OAuth or a custom GitHub App.

Using a Custom GitHub App

If you prefer to use a custom GitHub App instead of the official Claude app, follow the standard GitHub App creation flow and then add these secrets to your repository:

- `APP_ID` : the App ID
- `APP_PRIVATE_KEY` : contents of the generated `.pem` private key

Update the workflow to generate an app token and pass it to the action (see examples in the original instructions).

Security Best Practices

- Never commit API keys or private keys into the repository.
- Use repository or organization secrets and limit access.
- Rotate credentials periodically.
- Avoid logging secrets in workflow runs.

If you want, I can:

- Update `.github/workflows/claude.yml` to use a custom app token flow (template available), or
- Create a PR with these changes and self-contained docs.
