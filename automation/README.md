# Automation

This directory is the Ansible control project for personal workstations and
the Ubuntu homelab. It is intentionally separate from the GNU Stow packages:
Stow manages user configuration files, while Ansible manages machine state.

## Layout

| Path | Purpose |
| --- | --- |
| `inventory/hosts.yml` | Managed hosts and host groups |
| `group_vars/` | Non-secret variables for each group |
| `playbooks/` | Entry points that assemble roles |
| `roles/` | Reusable, focused automation tasks |
| `requirements.yml` | Pinned list of external Ansible collections (currently none) |

The `homelab` inventory host intentionally matches the `Host homelab` alias
in the repository's stowed SSH configuration. SSH therefore supplies its
hostname, user, and identity configuration without storing those values here.
The containing group is named `homelab_servers` to keep group and host names
unambiguous.

## Bootstrap a clean controller

1. Clone this repository and stow the `ssh` package so the `homelab` SSH alias
   is available:

   ```bash
   git clone git@github.com:VictorHeDev/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   stow --target "$HOME" ssh
   ```

2. Install Ansible and linting tools on the controller.

   **macOS (Homebrew):**

   ```bash
   brew install ansible ansible-lint yamllint
   ```

   **Ubuntu/Debian:**

   ```bash
   sudo apt update
   sudo apt install -y ansible ansible-lint yamllint
   ```

   Alternatively, use `pipx` to keep Python dependencies isolated:

   ```bash
   python3 -m pip install --user pipx
   python3 -m pipx ensurepath
   pipx install --include-deps ansible
   pipx install ansible-lint
   pipx install yamllint
   ```

3. Install declared collections (this is a no-op until `requirements.yml`
   lists one):

   ```bash
   cd automation
   ansible-galaxy collection install -r requirements.yml
   ```

4. Confirm SSH first, then let Ansible exercise the same connection:

   ```bash
   ssh homelab true
   ansible homelab -m ansible.builtin.ping
   ```

## Run and validate

Run the non-mutating connectivity check:

```bash
ansible homelab -m ansible.builtin.ping
```

Preview the homelab baseline before changing it:

```bash
ansible-playbook playbooks/bootstrap-homelab.yml --check --diff
```

Apply it only after reviewing the preview:

```bash
ansible-playbook playbooks/bootstrap-homelab.yml
```

Validate the repository before committing:

```bash
yamllint .
ansible-lint
ansible-playbook playbooks/bootstrap-homelab.yml --syntax-check
```

Secrets do not belong in tracked variable files. Put encrypted values in a
`vault.yml` file (ignored by Git) and pass it explicitly with
`--ask-vault-pass` or `--vault-password-file` when a future playbook needs it.
