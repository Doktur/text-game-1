# Deploy the Shattered bundle to a server

This repo now contains:
- `shattered_round17_installed_bugfixes_phoenix_dashboard.zip`
- `install_bundle.sh`
- `resetem.sh`
- `server_pull_and_install.sh`

## Fast path on the server

```bash
git clone https://github.com/Doktur/text-game-1.git /opt/text-game-1
bash /opt/text-game-1/server_pull_and_install.sh
```

That will:
1. pull the repo to the server
2. extract the ZIP into `/var/www`
3. create `/var/www/shattered/resetem.sh`
4. call the reset endpoint via `resetem.sh`

## Useful environment overrides

```bash
INSTALL_ROOT=/var/www \
APP_DIR=/var/www/shattered \
APP_URL=http://127.0.0.1 \
RESET_ENDPOINT=http://127.0.0.1/public/resetem.cfm \
bash /opt/text-game-1/server_pull_and_install.sh
```

## Notes

- `install_bundle.sh` uses the local ZIP from the repo when present.
- If the ZIP is missing locally, it will download it from the GitHub repo raw URL.
- `resetem.sh` calls the reset endpoint over HTTP using `curl` or `wget`.
- If your local reset hook is a shell script instead, set `EXTRA_RESET_HOOK=/path/to/hook.sh` before running `resetem.sh`.
