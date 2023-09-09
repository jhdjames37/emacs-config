# Emacs Configuration File

The configuration I'm currently using for Emacs, including:

+ Basic developing environment settings.
+ Language supports with `lsp`:
  - C++ with ccls
  - Python with jedi
  - Rust with rust-analyzer
  - [Under development] LaTeX
  - [Under development] Javascript/Typescript

## External packages

Some packages (e.g. lsp backends) should be installed via external package manager. Some commands should also be executed for the first time to setup some settings.

NOTE: The configuration has not been tested to build from scratch. So there might be some issues.

In order to save your ssh/gpg passphrases, `keychain` should be installed.

### Treesitter Configuration

Since Emacs 29.1, treesitter has been itergrated into emacs.

you can install language grammars following the guidelines [here](https://www.masteringemacs.org/article/how-to-get-started-tree-sitter).

## External Settings

This configuration trys to be compatible with deamon mode.

To do this, use `systemd`:

``` bash
systemctl enable --user emacs
systemctl start --user emacs
```

Update: I found there may be a display issue when using X server. Now I use `Emacs (Client)`, which starts a server on the first run.

## reference

[rememberYou's](https://github.com/rememberYou/.emacs.d) config has excellent remarks on usages of the packages. Also, [awesome-emacs](https://github.com/emacs-tw/awesome-emacs) lists different choices of packages in categories, which is a good place to explore.
