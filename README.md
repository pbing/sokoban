# Sokoban

## Installation

```shell
git clone https://github.com/pbing/sokoban

cabal build sokoban
```

## Play

Levels are defined in XSB format. Every level must be separated with a
**blank line** (no white spaces).
Currently the floor is only encoded as <space>.

Valid levels are from 1...50.

```shell
cabal run sokoban 1
```
