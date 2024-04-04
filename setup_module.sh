echo "1.pre commit install"
echo "[MAC]"
echo "brew install pre-commit"
echo "2 node yarn install"
echo "[MAC]"
echo "brew install node yarn"
echo "3. terraform-docs install"
echo "[MAC]"
echo "brew install terraform-docs"


echo "4.standard version && conventional commit setting"
echo "brew install jq"
yarn init -y
npx husky-init && yarn
rm -rf .husky/*
cat <<EOF > .husky/commit-msg
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx --no-install commitlint --edit $1
EOF

yarn add -D @commitlint/cli @commitlint/config-conventional
echo "module.exports = { extends: ['@commitlint/config-conventional'] };" > commit.config.js
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit $1'
cat <<EOF > .versionrc
{
    "types": [
        {
            "type": "feat",
            "section": "Features",
            "hidden": false
        },
        {
            "type": "fix",
            "section": "Bug Fixes",
            "hidden": false
        },
        {
            "type": "test",
            "section": "Tests",
            "hidden": true
        },
        {
            "type": "build",
            "section": "Build System",
            "hidden": true
        },
        {
            "type": "chore",
            "section": "Others",
            "hidden": false
        },
        {
            "type": "docs",
            "section": "Docs",
            "hidden": true
        },
        {
            "type": "style",
            "section": "Styling",
            "hidden": false
        },
        {
            "type": "refactor",
            "section": "Code Refactoring",
            "hidden": false
        }
    ]
}
EOF

yarn add -D standard-version
json=$(cat package.json)
new_json=$(echo "$json" | jq '.scripts = {"prepare": "husky install", "release": "standard-version"}')
echo "$new_json" > package.json
echo "Scripts added to package.json."

yarn release -- --first-release