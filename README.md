# Fluent S3 Log parser plugin for Embulk

This plugin parses fluent-plugin-s3's output log file.

## Overview

* **Plugin type**: parser
* **Guess supported**: no

## Configuration

- **columns**: column name and its type. (array, required)

## Example

```yaml
in:
  type: any file input plugin type
  parser:
    type: fluent-s3-log
    columns:
      - {name: id, type: long}
      - {name: path, type: string}
```

<!-- (If guess supported) you don't have to write `parser:` section in the configuration file. After writing `in:` section, you can let embulk guess `parser:` section using this command:

```
$ embulk install embulk-parser-fluent-s3-log
$ embulk guess -g fluent-s3-log config.yml -o guessed.yml
``` -->

## Build

```
$ rake
```
