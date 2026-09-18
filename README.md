# Multiplatform s-nail builds with local patches

This repository builds s-nail (neè Heirloom mailx) for amd64 and arm64 platforms. The build includes the following patches:

- `0001-Allow-OPT_COLOUR-no-to-build-successfully.patch`

  This is necessary to build successfully with `OPT_COLOUR=no`

- `0002-Fix-mis-detection-of-arc4randon-on-alpine.patch`

  The configuration tooling mis-detects the availability of the `arc4random` function on Alpine. This patches corrects that behavior.

- `0003-Move-su_RANDOM_SEED_-constants.patch`

  Code relies on constants that were only defined in a `.c` file. This patch moves the constants into a `.h` file where they can be included as necessary.
