# Hardened Linux Server & Automated Deploy

A hands-on DevOps project that demonstrates Linux server administration,
basic security hardening, web-server configuration, service management,
health checks, and Git-based deployment automation.

## Architecture

Browser / Client
       |
       | HTTP :80
       v
    Nginx
       |
       | Reverse proxy
       v
Python HTTP server :8081
(127.0.0.1 — localhost only)

systemd manages the Python application.
Bash scripts perform health checks and deployment.
Git and GitHub maintain the version history.

## Technologies

- Linux (Kali Linux)
- Bash
- Git and GitHub
- Python 3 HTTP server
- Nginx reverse proxy
- systemd
- UFW firewall
- curl

## Project Structure

```text
devops-server/
├── app/
│   └── index.html
├── config/
│   ├── nginx/
│   │   └── devops-server.conf
│   └── systemd/
│       └── devops-server.service
├── scripts/
│   ├── deploy.sh
│   └── health-check.sh
├── backup/
├── logs/
└── README.md
```

## Features

- Serves a website through Nginx on TCP port 80.
- Runs the Python application as the non-root `devops` user.
- Binds the Python application to `127.0.0.1:8081`.
- Uses systemd to manage the application lifecycle.
- Configures automatic restart after application failure.
- Uses UFW to deny incoming traffic by default and allow HTTP.
- Provides a Bash health-check script.
- Automates Git-based deployment and verifies HTTP availability.
- Stores application and infrastructure configuration in Git.

## Requirements

- Linux with systemd
- Python 3
- Nginx
- Git
- curl
- UFW
- An account named `devops`
- Sudo privileges for system-level configuration

## Service Management

Check application status:

```bash
sudo systemctl status devops-server.service
```

Restart the application:

```bash
sudo systemctl restart devops-server.service
```

View application logs:

```bash
sudo journalctl -u devops-server.service -n 50 --no-pager
```

## Verification

Check the website through Nginx:

```bash
curl -I http://127.0.0.1/
```

Check the Python application directly from the local machine:

```bash
curl http://127.0.0.1:8081/
```

Run the health check:

```bash
./scripts/health-check.sh
```

Check firewall rules:

```bash
sudo ufw status verbose
```

## Deployment

Commit and push your intended changes to the `main` branch.
Ensure the local working tree is clean, then run:

```bash
./scripts/deploy.sh
```

The deployment script checks the Git working tree, pulls the latest
commit from GitHub, restarts the application, and retries the HTTP
health check.

## Security Notes

- The Python application listens on localhost rather than all network
  interfaces.
- Nginx provides the HTTP entry point on port 80.
- The application runs under a non-root account.
- UFW is configured to deny incoming traffic by default.

## Limitations

This is an educational project, not a production-ready deployment
platform. Python's built-in HTTP server is intended for development
and learning, not production workloads.

The project currently uses HTTP rather than HTTPS and does not yet
implement automatic rollback after an unsuccessful deployment.

## Author

Jayaprakash

## Repository

https://github.com/Jayaprakash0918/devops-server
