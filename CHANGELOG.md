## Change Log
All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and this project adheres to Semantic Versioning.


## [11.2.4] - 2026-05-28
## Added
- GitHub Actions Security workflow that runs Bandit, Trivy image scan, Trivy filesystem scan and Dockle.

## Changed
- Ansible CD workflow now requires the reusable Security workflow to pass before tests, Docker image publishing and deployment can run.


## [11.2.3] - 2026-05-28
## Added
- Mozilla Modern OpenSSH `sshd_config` for the `10-first-minutes` Ansible role.

## Changed
- `10-first-minutes` now deploys a complete validated SSH daemon configuration instead of editing individual SSH settings, enforcing public-key authentication, restricted ciphers/MACs/KEX algorithms, SFTP logging, disabled root login and `AllowUsers deploy`.
- Security group task now documents that old rules are purged and that `group.port_rules` provides the firewall rules.


## [11.2.2] - 2026-05-28
## Added
- Makefile target `dockle` to scan the production Docker image for container image best-practice issues.
- Docker health check for the production image so container health can be verified automatically.

## Changed
- Production Docker image now uses `alpine:3.23` with Python installed via `apk add --no-cache`, which removes the Dockle finding about package installation without cache control in the upstream Python image layer.
- Python dependencies are installed with pip's `--no-cache-dir` option to avoid keeping package cache files in the image.
- Dockle scans the versioned local image tag `mobn23/microblog:kmom03` instead of `latest`.


## [11.2.1] - 2026-05-28
## Added
- Makefile targets `trivy-image` and `trivy-fs` to scan the production Docker image and repository filesystem with Trivy.

## Changed
- Production Docker base image upgraded from `python:3.8-alpine` to `python:3.12-alpine` to remove HIGH/CRITICAL OS package vulnerabilities reported by Trivy.
- Python production dependencies upgraded to remove HIGH vulnerabilities reported by Trivy.
- Trivy filesystem scan configured to detect the project requirements files and custom Dockerfile names.


## [11.2.0] - 2026-05-27
## Added
- bandit >= 1.7.5 to requirements/test.txt as SAST dependency
- Makefile target `bandit` to run Bandit security scan on app/ folder
## Fixed
- app/models.py: MD5 hash in avatar() marked with usedforsecurity=False since it is used only for Gravatar URL generation, not for security purposes (resolves Bandit B324)


## [11.1.9] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.8] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.7] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.6] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.5] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.4] 2026-01-01
## Changed
- cd-kmom02.yml 

## [11.1.3] 2026-01-01
## Added
- cd_deploy.yml
## Changed
- cd-kmom02.yml

## [11.1.2] 2026-01-01
## Added
- Infrastructure provisioning with Ansible for 4 VMs (load balancer, 2 app servers, database)
- CD workflow: tag-triggered deploy using Ansible (rolling update, verification)

## [11.1.1] - 2025-11-19
## Fixed
- Small fixes

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
