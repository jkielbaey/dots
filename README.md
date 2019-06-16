# Dots

Collection of dotfiles and bootstrap script to manage the environment on my laptop.

## Installation

```shell
git clone https://github.com/jkielbaey/dots
cd dots
sh ./bootstrap.sh
````

## Update

The bootstrap script also comes with a handy option to upgrade all installed tools.

```shell
cd dots
sh ./bootstrap.sh -u
```

## Supported Operation Systems

The bootstrap script only works for OSX.

## Tools

The bootstrap script installs a set of tools. Most notably:

- [brew](https://brew.sh/)
- [fish](http://fishshell.com/)
- [glances](https://nicolargo.github.io/glances/)
- [Google Chrome](https://www.google.com/chrome/)
- [iTerm2](https://www.iterm2.com/)
- [docker](https://www.docker.com/products/docker-desktop)
- [httpie](https://httpie.org/)
- [go](https://golang.org/)
- [Python 3](https://www.python.org/downloads/)
- [Pipenv](https://docs.pipenv.org/en/latest/)
- [aws-cli](https://aws.amazon.com/cli/)
- [aws-vault](https://github.com/99designs/aws-vault)
- [terraform](https://www.terraform.io/)
- [powerline-go](https://github.com/justjanne/powerline-go)

For the full list, see [bootstrap.sh](https://github.com/jkielbaey/dots/blob/master/bootstrap.sh).

## Shell environment

The bootstrap script will prepare the config of the fish shell in your home directory.

- Simple aliases that I used often to speed up my workflow (i.e. `gpl` for `git pull` and `myip` to get my public IP address).
- Define fish functions to integrate aws-vault with aws-cli and terraform.
- Initialize ssh-agent and load all ssh keys starting with `id_rsa` in the `$HOME/.ssh` directory.
- Set environment variables as instructed by brew formulas.

## Contributing

Have an amazing idea to be added? Great! Let's collaborate!

1. Fork this repo!
1. Create your feature branch: `git checkout -b my-new-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a pull request :D.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
