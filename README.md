# What this is

This is a collection of configurations and scripts that make my life easier.
It's whatever goes in my `.config`, `.local`, and other "dot" directories.

# How it works

It uses [Stow](https://www.gnu.org/software/stow/) to maintain what goes where:

Each directory under `stow` and `personal` in this repo is a "package" containing various
configurations, helper scripts, etc.

Stow will "install" those in the `$HOME` directory through symlinks.

## Note about `personal`

This is a git submodule containing packages relevant to myself and only myself.
If you could use one of your own, edit the submodule URL in your fork, if not, just
remove it, you're smart.

## Getting started

After cloning, the first step is to make sure `stow` is installed.

The second step is to run the `install` script.

## Adding and removing configs

When you need to change stuff, add packages, or remove ones, the only thing to
do after the changes is to run the `install` script again.

