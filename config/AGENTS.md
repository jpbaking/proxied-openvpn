# config/

## Purpose

Runtime configuration files copied into the Docker image at build time. Changes here affect service behavior inside the running container.

## Ownership

Project-wide; no subdirectory boundaries.

## Local Contracts

- `pm2.yaml` — defines the four PM2-managed processes (`squid`, `apache`, `sshd`, `openvpn`); each process maps to a script in `../scripts/` with autorestart enabled and a 3-second restart delay
- `squid.conf` — configures Squid to listen on port 3128, use Google DNS (8.8.8.8 / 8.8.4.4), and allow all sources; intentionally permissive (not for production)

## Work Guidance

- Adding a new managed process requires both a new entry in `pm2.yaml` and a corresponding launch script in `../scripts/`
- Squid ACL changes must keep `http_access deny all` as the last rule

## Verification

No automated tests. Manual verification: start the container and confirm all four PM2 processes are running (`pm2 list`).
