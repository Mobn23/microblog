## Change Log
All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and this project adheres to Semantic Versioning.

## [11.1.1] - 2026-01-01
## Added
- Ansible automated env for 4 VMs
- CD workflow 


## [11.1.0] - 2025-11-17
## Added
- migrations/versions/6ddcba87a7dc_followers.py
- tests/unit/models/test_followers.py
## Changed
- app/main/routes.py
- app/models.py
- app/templates/user.html


## [11.0.0] - 2025-11-17
## Added
- Production Dockerfile (docker/Dockerfile_prod).
- CHANGELOG.md, commit-conventions.txt
- docker-compose.yml
- Dockerfile_test
- .github/workflows/ci.yml
- .github/workflows/cd.yml
## Changed
- docker-compose.yml
- README.md
## Fixed
- docker/Dockerfile_prod
- .github/workflows/ci.yml
- secrets(variables used in cd.yml) added in github repo
