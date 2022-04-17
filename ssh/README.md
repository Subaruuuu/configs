# Instructions for multiple github and gitlab settings

## Problem
I have two Github / Gitlab accounts: (personal), and (for work).
I want to use both accounts on same computer (without typing password everytime, when doing git push or pull).

## Solution
Use ssh keys and define host aliases in ssh config file (each alias for an account).

## How to?
1. [Generate ssh key pairs for accounts](https://help.github.com/articles/generating-a-new-ssh-key/) and [add them to GitHub accounts](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

```bash
ssh-keygen -t rsa -C "work@mail.com" -f ~/.ssh/id_rsa
ssh-keygen -t rsa -C "personal@mail.com" -f ~/.ssh/id_rsa_github_subaruuuu
ssh-keygen -t rsa -C "personal@mail.com" -f ~/.ssh/id_rsa_gitlab
```

2. Edit/Create ssh config file (`~/.ssh/config`):

```conf
   # Work github account: oscaribears (work)
	Host github.com
	HostName github.com
	IdentityFile ~/.ssh/id_rsa
	IdentitiesOnly yes

	# Personal github account: subaruuuu (personal)
	Host github-subaruuuu
	HostName github.com
	IdentityFile ~/.ssh/id_rsa_github_subaruuuu
	IdentitiesOnly yes

	# Personal gitlab account: subaruuuu (personal)
	Host gitlab.com
	HostName gitlab.com
	IdentityFile ~/.ssh/id_rsa_gitlab
	IdentitiesOnly yes
```

3. [Add ssh private keys to your agent](https://help.github.com/articles/adding-a-new-ssh-key-to-the-ssh-agent/):

```shell
	$ ssh-add ~/.ssh/id_rsa_github_subaruuuu
	$ ssh-add ~/.ssh/id_rsa_gitlab
```

4. Test your connection

```shell
	$ ssh -T git@github.com
	$ ssh -T git@github-subaruuuu
	$ ssh -T git@gitlab.com
```

With each command, you may see this kind of warning, type `yes`:

```shell
	The authenticity of host 'github.com (192.30.252.1)' can't be established.
	RSA key fingerprint is xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:
	Are you sure you want to continue connecting (yes/no)?
```

If everything is OK, you will see these messages:

```shell
	Hi xxxxx! You've successfully authenticated, but GitHub does not provide shell access.
```

```shell
	Hi subaruuuu! You've successfully authenticated, but GitHub does not provide shell access.
```

```shell
	Welcome to GitLab, @Subaruuuu!
```

5. Now all are set, just clone your repositories, if is for personal repository, don't forget to setup `user.email` and `user.name` for each repository

```shell
	$ git clone git@github-subaruuuu:org2/project2.git /path/to/project2
	$ cd /path/to/project2
	$ git config user.email "personal@mail.com"
	$ git config user.name  "subaruuuu"
```

Done! Goodluck!
