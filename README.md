#### Configuration format

This is a group of NixOS modules that control user and system configuration for
a single-user machine. In order to avoid confusion with other modules, all
user-facing options that I provide will be under the namespace `minion.` and all
internal options that I provide will be under the namespace `internal.`

#### Directory usages

| Directory   | Description                                                                                                                                                                          |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `modules`   | modules, used to provide user-facing options and configuration                                                                                                                       |
| `internal`  | internal modules, used to provide configuration-agnostic options to user-facing modules. These should do nothing unless they are triggered by a user-facing module setting an option |
| `utils`     | internal utilities for writing these modules; intended to be imported by nix files in here, and probably nothing else. These may be refactored into another repo at some point       |
| `overlays`  | package overlays, each in files named with the package they are intended to overlay                                                                                                  |
| `patches`   | patch files, each in a directory named with the package that they are intended to patch                                                                                              |
| `packages`  | package expressions, each named with the package they wish to occupy                                                                                                                 |
| `switching` | a program for switching on and off options, as well as rebuilding the configuration. Currently A WIP                                                                                 |

##### Modules

All files directly under `/modules/` will be `.nix` modules, and related files
(such as assets) may be contained in `/modules/name/` (where `name` is the name
of the module with the `.nix` extension omitted). Similarly, any options the
module provides should be under `minion.name.`. It is expected that related file
directories will sometimes contain `.nix` files; this is acceptable and no
particular standard is required of any `.nix` file outside of the main `/modules/`
directory. Some modules with stricter layouts may decide to keep a README in
their assets directory to ensure a standard is kept.

These are _not_ standard NixOS modules, in that they can have some extra
properties outside of the traditional `imports`, `options`, and `config`, and
these properties _will not be_ treated as config. These properties are described
below.

###### Additional properties

| Options | Type                       | Description                                                                                                           |
| ------- | -------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `home`  | home-manager configuration | configuration that will be used for the home-manager user; will also be passed as the variable `home` to your modules |

#### Licensing
Unless otherwise specified, all files in this repo while this message is in the
readme were written or otherwise created by me, Skyler Grey, and are released
under [GNUAGPLv3](https://www.gnu.org/licenses/agpl-3.0.html). A full copy of
this license may be found at the provided URL or in [the license
file](./LICENSE).

Despite the licensing, only the files in this repo are licensed. This config
installs unfree software, and software that is not compatible with the AGPL
license. The license only pertains to files inside this repo, and I do not
pretend to own or have created any external files that may end up in your nix
store by building this config.
