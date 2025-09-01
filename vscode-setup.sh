#!/bin/bash

# VS Code Setup Script - Download from GitLab
# Run this script in any repository to get VS Code settings

GITLAB_URL=${1:-"https://gitlab.com/your-username/vscode-scripts/-/raw/main"}

echo "Downloading VS Code setup from GitLab..."

# Create .vscode folder
if [ ! -d ".vscode" ]; then
    mkdir .vscode
    echo "Created .vscode folder"
fi

# Download settings.json
if curl -f -s "$GITLAB_URL/settings.json" -o ".vscode/settings.json"; then
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
fi

# Download extensions.json
if curl -f -s "$GITLAB_URL/extensions.json" -o ".vscode/extensions.json"; then
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
fi

# Download launch.json
if curl -f -s "$GITLAB_URL/launch.json" -o ".vscode/launch.json"; then
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
echo "Usage: ./get-vscode-setup.sh [GitLabUrl]"
echo "Example: ./get-vscode-setup.sh https://gitlab.com/username/vscode-scripts/-/raw/main"
