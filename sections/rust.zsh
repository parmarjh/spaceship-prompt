#
# Rust
#
# Rust is a systems programming language sponsored by Mozilla Research.
# Link: https://www.rust-lang.org

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_RUST_SHOW="${SPACESHIP_RUST_SHOW=true}"
SPACESHIP_RUST_SHOW_VERSION="${SPACESHIP_RUST_SHOW_VERSION=true}"
SPACESHIP_RUST_SHOW_TOOLCHAIN="${SPACESHIP_RUST_SHOW_TOOLCHAIN=true}"
SPACESHIP_RUST_PREFIX="${SPACESHIP_RUST_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_RUST_SUFFIX="${SPACESHIP_RUST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_RUST_SYMBOL="${SPACESHIP_RUST_SYMBOL="𝗥 "}"
SPACESHIP_RUST_COLOR="${SPACESHIP_RUST_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Rust
spaceship_rust() {
  [[ $SPACESHIP_RUST_SHOW == false ]] && return

  # If there are Rust-specific files in current directory
  [[ -f Cargo.toml || -n *.rs(#qN^/) ]] || return

  spaceship::exists rustc || return

  local -a 'rust_version'

  # Get the version, prepending with 'v' only if we retrieved it properly
  [[ $SPACESHIP_RUST_SHOW_VERSION == false ]] || rust_version+="$(rustc --version | grep --color=never -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]')"
  [[ -z ${rust_version[1]} ]] || rust_version[1]="v${rust_version[1]}"

  # Get the toolchain, defaulting to stable because stable rustc doesn't print stable in its version
  [[ $SPACESHIP_RUST_SHOW_TOOLCHAIN == false ]] || rust_version+=$(rustc --version | grep --colour=never -oE '(stable|beta|nightly)' || echo stable)

  # Return if both the version and toolchain are empty
  [[ -z ${rust_version[1]} && -z ${rust_version[2]} ]] && return

  spaceship::section \
    "$SPACESHIP_RUST_COLOR" \
    "$SPACESHIP_RUST_PREFIX" \
    "${SPACESHIP_RUST_SYMBOL}${rust_version}" \
    "$SPACESHIP_RUST_SUFFIX"
}
