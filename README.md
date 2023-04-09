# bw-ssh-add

This script adds SSH keys to the SSH agent by obtaining their passphrases from a Bitwarden password manager vault. The script requires `rbw`, `jq` and `expect` to be installed.

The default name for the Bitwarden folder where the SSH keys are stored is "SSHAgent". If your folder has a different name, modify the value of the FOLDER_NAME variable at the top of the script.

The Bitwarden folder where the SSH keys are stored must meet the following requirements:

- The folder must contain entries with two fields: "name", which specifies the path to the SSH key, and "passphrase", which contains the passphrase for the key.
- Each "name" field must be set to the path of an SSH key file on your local machine.
- Each "passphrase" field must contain the passphrase for the corresponding SSH key.

To use the script:

- Download or clone the script from the repository.
- Install the `rbw`, `jq` and `expect` command-line tools if they are not already installed.
- Set up a valid `rbw` environment: `rbw register`
- Make sure that your Bitwarden folder meets the above requirements.
- Run the script using the following command: `./bw-ssh-add.sh`
- The script will prompt you for the master password of your Bitwarden account if `rbw` is locked.
- The script will then add each SSH key to the SSH agent.
