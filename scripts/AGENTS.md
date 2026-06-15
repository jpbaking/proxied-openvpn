# scripts/

## Purpose

Bash wrapper scripts that PM2 runs to start each container service in the foreground. PM2 manages restart and logging; scripts must not daemonize.

## Ownership

Project-wide; no subdirectory boundaries.

## Local Contracts

- `squid.sh` — starts Squid via `squid --foreground`
- `apache2.sh` — exports required Apache env vars, creates the run dir, then starts Apache via `apache2 -DFOREGROUND`
- `sshd.sh` — creates `/var/run/sshd`, starts SSHD via `sshd -D`
- `connect.sh` — ensures `/dev/net/tun` exists (creates it if absent), then delegates to `/root/ovpn/connect.sh` (which must be bind-mounted by the user)

## Work Guidance

- All scripts must run the service process in the foreground so PM2 tracks the PID
- `connect.sh` is the only script that performs pre-flight setup (TUN device); keep that logic here, not in `../ovpn/connect.sh`
- Adding a new service: create a script here and add a corresponding entry to `../config/pm2.yaml`

## Verification

No automated tests. Manual verification: run the container and confirm each PM2 process stays in `online` state.
