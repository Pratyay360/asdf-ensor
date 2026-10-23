# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test ensor https://github.com/Pratyay360/asdf-ensor.git "ensor -h"
```

Tests are automatically run in GitHub Actions on push and PR.
