# ovpn/

## Purpose

Bind-mount point for user-provided OpenVPN credentials and connection logic. The repo ships only a placeholder `connect.sh`; real contents are never committed.

## Ownership

User-supplied at runtime; repo owns only the placeholder stub.

## Local Contracts

- `connect.sh` (repo stub) — loops indefinitely printing a message; exists so PM2 does not error when no volume is mounted
- At runtime the user must bind-mount a directory here containing:
  - `connect.sh` (executable) — runs `openvpn --config <path>.ovpn`; may include pre-connect logic
  - `<name>.ovpn` — OpenVPN profile; if password-based, `auth-user-pass` must use an absolute path (e.g. `/root/ovpn/<name>.pass`)
  - `<name>.pass` (optional) — plaintext credentials file for `auth-user-pass`

## Work Guidance

- Do not add real `.ovpn` or `.pass` files to the repo
- The placeholder `connect.sh` must remain executable and loop-safe so it never exits (PM2 would restart it repeatedly otherwise)

## Verification

Functional test: `curl --proxy http://127.0.0.1:53128 https://api6.ipify.org` should return the VPN exit IP, not the host IP.
