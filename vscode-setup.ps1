# VS Code Setup Script - Download from GitLab
# Run this script in any repository to get VS Code settings

param(
    [string]$GitLabUrl = "https://gitlab.com/your-username/vscode-scripts/-/raw/main"
)

Write-Host "Downloading VS Code setup from GitLab..." -ForegroundColor Green

# Create .vscode folder
if (!(Test-Path ".vscode")) {
    New-Item -ItemType Directory -Name ".vscode" | Out-Null
    Write-Host "Created .vscode folder" -ForegroundColor Green
}

# Download settings.json
try {
    $settingsUrl = "$GitLabUrl/settings.json"
    Invoke-WebRequest -Uri $settingsUrl -OutFile ".vscode\settings.json"
    Write-Host "Downloaded settings.json" -ForegroundColor Green
} catch {
    Write-Host "Failed to download settings.json, creating default..." -ForegroundColor Yellow
    # Fallback to default settings
    $defaultSettings = @"
{
	"editor.formatOnSave": true,
	"editor.formatOnPaste": true,
	"editor.formatOnType": false,
	"editor.defaultFormatter": "esbenp.prettier-vscode",
	"editor.codeActionsOnSave": {
		"source.fixAll.eslint": true,
		"source.organizeImports": true
	},
	"typescript.preferences.importModuleSpecifier": "relative",
	"typescript.suggest.autoImports": true,
	"typescript.updateImportsOnFileMove.enabled": "always",
	"typescript.preferences.includePackageJsonAutoImports": "auto",
	"files.exclude": {
		"**/node_modules": true,
		"**/dist": true,
		"**/.git": true,
		"**/coverage": true
	},
	"search.exclude": {
		"**/node_modules": true,
		"**/dist": true,
		"**/coverage": true
	},
	"files.watcherExclude": {
		"**/node_modules/**": true,
		"**/dist/**": true
	},
	"[typescript]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"[javascript]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"[json]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"[html]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"[scss]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"[css]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	},
	"emmet.includeLanguages": {
		"typescript": "html"
	},
	"emmet.triggerExpansionOnTab": true
}
"@
    $defaultSettings | Out-File -FilePath ".vscode\settings.json" -Encoding UTF8
}

# Download extensions.json
try {
    $extensionsUrl = "$GitLabUrl/extensions.json"
    Invoke-WebRequest -Uri $extensionsUrl -OutFile ".vscode\extensions.json"
    Write-Host "Downloaded extensions.json" -ForegroundColor Green
} catch {
    Write-Host "Failed to download extensions.json, creating default..." -ForegroundColor Yellow
    $defaultExtensions = @"
{
	"recommendations": [
		"esbenp.prettier-vscode",
		"ms-vscode.vscode-typescript-next",
		"angular.ng-template",
		"ms-vscode.vscode-json",
		"bradlc.vscode-tailwindcss",
		"ms-vscode.vscode-css-peek",
		"formulahendry.auto-rename-tag",
		"christian-kohler.path-intellisense",
		"ms-vscode.vscode-eslint"
	]
}
"@
    $defaultExtensions | Out-File -FilePath ".vscode\extensions.json" -Encoding UTF8
}

# Download launch.json
try {
    $launchUrl = "$GitLabUrl/launch.json"
    Invoke-WebRequest -Uri $launchUrl -OutFile ".vscode\launch.json"
    Write-Host "Downloaded launch.json" -ForegroundColor Green
} catch {
    Write-Host "Failed to download launch.json, creating default..." -ForegroundColor Yellow
    $defaultLaunch = @"
{
	"version": "0.2.0",
	"configurations": [
		{
			"name": "Launch Chrome",
			"type": "chrome",
			"request": "launch",
			"url": "http://localhost:4200",
			"webRoot": "\${workspaceFolder}",
			"sourceMaps": true,
			"sourceMapPathOverrides": {
				"webpack:/*": "\${webRoot}/*",
				"/./*": "\${webRoot}/*",
				"/src/*": "\${webRoot}/src/*",
				"/*": "*",
				"/./~/*": "\${webRoot}/node_modules/*"
			}
		},
		{
			"name": "Attach to Chrome",
			"type": "chrome",
			"request": "attach",
			"port": 9222,
			"webRoot": "\${workspaceFolder}",
			"sourceMaps": true
		}
	]
}
"@
    $defaultLaunch | Out-File -FilePath ".vscode\launch.json" -Encoding UTF8
}

# Add .vscode to .gitignore if it doesn't exist
if (Test-Path ".gitignore") {
    $gitignore = Get-Content ".gitignore"
    if ($gitignore -notcontains ".vscode/") {
        Add-Content ".gitignore" "`n# VS Code settings`n.vscode/"
        Write-Host "Added .vscode/ to .gitignore" -ForegroundColor Green
    } else {
        Write-Host ".vscode/ already exists in .gitignore" -ForegroundColor Yellow
    }
} else {
    Write-Host "Warning: .gitignore not found, create it manually" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "VS Code setup completed!" -ForegroundColor Green
Write-Host "Now you have:" -ForegroundColor Cyan
Write-Host "   - Auto-formatting on save" -ForegroundColor White
Write-Host "   - ESLint auto-fixes" -ForegroundColor White
Write-Host "   - Import sorting" -ForegroundColor White
Write-Host "   - Recommended extensions" -ForegroundColor White
Write-Host "   - Debug configuration" -ForegroundColor White
Write-Host ""
Write-Host "Usage: .\get-vscode-setup.ps1 [GitLabUrl]" -ForegroundColor Cyan
Write-Host "Example: .\get-vscode-setup.ps1 https://gitlab.com/username/vscode-scripts/-/raw/main" -ForegroundColor Cyan
