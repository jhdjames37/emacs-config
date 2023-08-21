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

## External Settings

This configuration trys to be compatible with deamon mode.

To do this, use `systemd`:

``` bash
systemctl enable --user emacs
systemctl start --user emacs
```

## reference

[rememberYou's](https://github.com/rememberYou/.emacs.d) config has excellent remarks on usages of the packages. Also, [awesome-emacs](https://github.com/emacs-tw/awesome-emacs) lists different choices of packages in categories, which is a good place to explore.
