Set-Location -Path C:\Users\Nathy\.gemini\antigravity\scratch\portfolyo
Remove-Item -Recurse -Force .git
git init
git branch -M main

# Relying completely on the machine's global Git user credentials
git add .gitignore package.json package-lock.json astro.config.mjs
if (Test-Path tsconfig.json) { git add tsconfig.json }
if (Test-Path public) { git add public }
git commit -m "chore: scaffold base Astro environment and dependencies"

git add src/styles/
git commit -m "feat(design): define bespoke premium Tailwind palette and zero-default theme"

git add src/layouts/ src/components/
git commit -m "feat(core): construct global shell, dark mode toggle, and i18n abstractions"

git add src/pages/
git commit -m "feat(content): wire 7 structural sections with english, french, and turkish routing"

git add Dockerfile nginx.conf docker-compose.yml
git commit -m "feat(infra): engineer multi-stage Nginx-slim Docker architecture with graceful shutdown"

git add .github/
git commit -m "ci: enforce strict DevSecOps pipeline (Trivy, Gitleaks, Semgrep) and GHCR push"

git add README.md scripts/
git commit -m "docs: author architectural diagrams, AI usage declaration, and observability bash runner"

git add .
$diff = git diff --staged
if ($diff) { git commit -m "chore: format final repo tracking structure" }

git remote remove origin 2>$null
git remote add origin https://github.com/Nathanaelle25/-USER-portfolyo.git
