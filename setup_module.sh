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

yarn add -D standard-version
json=$(cat package.json)
new_json=$(echo "$json" | jq '.scripts = {"prepare": "husky install", "release": "standard-version"}')
echo "$new_json" > package.json
echo "Scripts added to package.json."

yarn release -- --first-release
git config --unset-all core.hooksPath
pre-commit install
pre-commit install --hook-type commit-msg