plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"

  custom_formats = {
    extended_snake_case = {
      description = "Extended snake_case Format which allows double underscore like `a__b`."
      regex       = "^[a-z][a-z0-9]+([_]{1,2}[a-z0-9]+)*$"
    }
  }

  rule "terraform_required_version" {
    enabled = true
  }

  module {
    format = "extended_snake_case"
  }

  resource {
    format = "extended_snake_case"
  }

  data {
    format = "extended_snake_case"
  }
}

rule "terraform_unused_declarations" {
  enabled = false
}

rule "terraform_unused_required_providers" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = false
}

###################################################
# Rule Sets - AWS
###################################################

plugin "aws" {
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.21.1"

  enabled    = true
  deep_check = false
}
