
# Introduction

This repository is for Terraform modules that can be used to deploy infrastructure to Azure.

## Structure

The following folders are pre-defined:

- .github
  - workflows  
  This folder contains the YAML files defining GitHub Actions workflows, including any specific templates.
- .azuredevops  
  This folder contains the YAML files defining Azure DevOps multi-stage pipelines, including any specific templates.
- ```<provider_name>```
  - ```<resource_name>```
    - ```<files>```
  Standardised directory structure for modules.

Terraform module file naming conventions:
- ```<type ie module, resource, locals etc>.<provider_name_resource_name>.tf```
  Calling secondary modules, data sources, resources etc.
- ```main.tf```
  Primary file for module.
- ```output.tf```
  Output from modules and children.
- ```variables.tf```
  File to define module variables.
  
## Branch Protection

The following branches have pre-defined branch protection rules. These rules are to be reviewed and updated as required.

- main  
  This branch is the default branch for all repositories. Merges need to be reviewed and approved.  
  Additional controls should be added around who is permitted to approve pull requests.
- release/*  
  This branch set should be used to define tagged releases of code using Semantic Versioning, eg 1.0.0 / v1.0.0.  
  As such, these branches should be controlled to ensure releases of code are of high quality, security, and the like.

## Tag Protection

Semantic version to be implemented.

## Issue templates

The following default issue templates have been added for issue management

- Feature requests
- Bug reports
