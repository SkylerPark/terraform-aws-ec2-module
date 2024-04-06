### MAC Install
echo "Package Install"
echo "Package pre-commit, tfenv, terraform-docs, jq, tflinut, tfsec"
package_list="pre-commit tfenv terraform-docs jq tflint tfsec"

for package in $package_list; do
    check_package=`brew list | grep $package`
    if [ -z "check_package)" ]; then
        echo "brew install $package"
        brew install $package
    fi
done

### pre-commit config setup
echo "pre-commit conmfig setting"
cat <<EOF > .pre-commit-config.yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.88.0
    hooks:
      - id: terraform_fmt
      - id: terraform_tfsec
      - id: terraform_docs
        args:
          - "--args=--lockfile=false"
      - id: terraform_tflint
        args:
          - "--args=--only=terraform_deprecated_interpolation"
          - "--args=--only=terraform_deprecated_index"
          - "--args=--only=terraform_unused_declarations"
          - "--args=--only=terraform_comment_syntax"
          - "--args=--only=terraform_documented_outputs"
          - "--args=--only=terraform_documented_variables"
          - "--args=--only=terraform_typed_variables"
          - "--args=--only=terraform_module_pinned_source"
          - "--args=--only=terraform_naming_convention"
          - "--args=--only=terraform_required_version"
          - "--args=--only=terraform_required_providers"
          - "--args=--only=terraform_standard_module_structure"
          - "--args=--only=terraform_workspace_remote"
          - "--args=--only=terraform_unused_required_providers"
      - id: terraform_validate
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-merge-conflict
      - id: end-of-file-fixer
      - id: trailing-whitespace
  - repo: https://github.com/compilerla/conventional-pre-commit
    rev: v3.2.0
    hooks:
      - id: conventional-pre-commit
        stages: [commit-msg]
EOF

### pre-commit install
echo "pre-commit install"
pre-commit install
pre-commit install --hook-type commit-msg
