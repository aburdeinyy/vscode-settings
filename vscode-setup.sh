#!/bin/bash

# VS Code Setup Script - Download from GitHub
# Run this script in any repository to get VS Code settings

GITHUB_URL=${1:-"https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main"}

echo "Downloading VS Code setup from GitHub..."
echo "GitHub URL: $GITHUB_URL"

# Function to download file with better error handling
download_file() {
    local url="$1"
    local output="$2"
    local filename="$3"
    
    echo "Downloading $filename..."
    if curl -f -s "$url" -o "$output"; then
        echo "Successfully downloaded $filename"
        return 0
    else
        echo "Failed to download $filename"
        return 1
    fi
}

# Create .vscode folder
if [ ! -d ".vscode" ]; then
    mkdir .vscode
    echo "Created .vscode folder"
fi

# Download settings.json
if download_file "$GITHUB_URL/settings.json" ".vscode/settings.json" "settings.json"; then
    echo "Downloaded settings.json"
else
    echo "Failed to download settings.json, creating default..."
    cat > .vscode/settings.json << 'EOF'
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
EOF
    echo "Created default settings.json"
fi

# Download extensions.json
if download_file "$GITHUB_URL/extensions.json" ".vscode/extensions.json" "extensions.json"; then
    echo "Downloaded extensions.json"
else
    echo "Failed to download extensions.json, creating default..."
    cat > .vscode/extensions.json << 'EOF'
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
EOF
    echo "Created default extensions.json"
fi

# Download launch.json
if download_file "$GITHUB_URL/launch.json" ".vscode/launch.json" "launch.json"; then
    echo "Downloaded launch.json"
else
    echo "Failed to download launch.json, creating default..."
    cat > .vscode/launch.json << 'EOF'
{
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
}
EOF
    echo "Created default launch.json"
fi

# Add .vscode to .gitignore if it doesn't exist
if [ -f ".gitignore" ]; then
    if ! grep -q "\.vscode/" .gitignore; then
        echo "" >> .gitignore
        echo "# VS Code settings" >> .gitignore
        echo ".vscode/" >> .gitignore
        echo "Added .vscode/ to .gitignore"
    else
        echo ".vscode/ already exists in .gitignore"
    fi
else
    echo "Warning: .gitignore not found, create it manually"
fi

echo ""
echo "VS Code setup completed!"
echo "Now you have:"
echo "   - Auto-formatting on save"
echo "   - ESLint auto-fixes"
echo "   - Import sorting"
echo "   - Recommended extensions"
echo "   - Debug configuration"
echo ""
