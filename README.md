<div align="center">

# asdf-ensor [![Build](https://github.com/Pratyay360/asdf-ensor/actions/workflows/build.yml/badge.svg)](https://github.com/Pratyay360/asdf-ensor/actions/workflows/build.yml) [![Lint](https://github.com/Pratyay360/asdf-ensor/actions/workflows/lint.yml/badge.svg)](https://github.com/Pratyay360/asdf-ensor/actions/workflows/lint.yml)

[ensor](https://github.com/Pratyay360/ensor) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add ensor
# or
asdf plugin add ensor https://github.com/Pratyay360/asdf-ensor.git
```

ensor:

```shell
# Show all installable versions
asdf list-all ensor

# Install specific version
asdf install ensor latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ensor latest

# Now ensor commands are available
ensor -h
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/Pratyay360/asdf-ensor/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Pratyay Mustafi](https://github.com/Pratyay360/)
