# VS Code Setup Script - Download from GitHub
# Run this script in any repository to get VS Code settings

param(
    [string]$GitHubUrl = "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main"
)

Write-Host "Downloading VS Code setup from GitHub..." -ForegroundColor Green
Write-Host "GitHub URL: $GitHubUrl" -ForegroundColor Cyan

# Create .vscode folder
if (!(Test-Path ".vscode")) {
    New-Item -ItemType Directory -Name ".vscode" | Out-Null
    Write-Host "Created .vscode folder" -ForegroundColor Green
}

# Function to download file with better error handling
function Download-File {
    param(
        [string]$Url,
        [string]$OutputPath,
        [string]$FileName
    )
    
    try {
        Write-Host "Downloading $FileName..." -ForegroundColor Yellow
        $response = Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
        Write-Host "Successfully downloaded $FileName" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Error downloading $FileName`: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Download settings.json
$settingsUrl = "$GitHubUrl/settings.json"
$settingsPath = ".vscode\settings.json"

if (Download-File -Url $settingsUrl -OutputPath $settingsPath -FileName "settings.json") {
    Write-Host "Downloaded settings.json" -ForegroundColor Green
} else {
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
    $defaultSettings | Out-File -FilePath $settingsPath -Encoding UTF8
    Write-Host "Created default settings.json" -ForegroundColor Green
}

# Download extensions.json
$extensionsUrl = "$GitHubUrl/extensions.json"
$extensionsPath = ".vscode\extensions.json"

if (Download-File -Url $extensionsUrl -OutputPath $extensionsPath -FileName "extensions.json") {
    Write-Host "Downloaded extensions.json" -ForegroundColor Green
} else {
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
    $defaultExtensions | Out-File -FilePath $extensionsPath -Encoding UTF8
    Write-Host "Created default extensions.json" -ForegroundColor Green
}

# Download launch.json
$launchUrl = "$GitHubUrl/launch.json"
$launchPath = ".vscode\launch.json"

# Always create local copy with correct settings
Write-Host "Creating launch.json with correct VS Code variables..." -ForegroundColor Yellow

# Create JSON string directly with proper escaping
$defaultLaunch = '{
	"version": "0.2.0",
	"configurations": [
		{
			"name": "Launch Chrome",
			"type": "chrome",
			"request": "launch",
			"url": "http://localhost:4200",
			"webRoot": "${workspaceFolder}",
			"sourceMaps": true,
			"sourceMapPathOverrides": {
				"webpack:/*": "${webRoot}/*",
				"/./*": "${webRoot}/*",
				"/src/*": "${webRoot}/src/*",
				"/*": "*",
				"/./~/*": "${webRoot}/node_modules/*"
			}
		},
		{
			"name": "Attach to Chrome",
			"type": "chrome",
			"request": "attach",
			"port": 9222,
			"webRoot": "${workspaceFolder}",
			"sourceMaps": true
		}
	]
}'

$defaultLaunch | Out-File -FilePath $launchPath -Encoding UTF8
Write-Host "Created launch.json with correct VS Code variables" -ForegroundColor Green

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
