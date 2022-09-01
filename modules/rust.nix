{username, ...}: {
  # Rust should be installed via direnv *not* here, however we still need to persist the cache
  # as we don't want installing crates to be slower than it has to be
  config.environment.persistence."/nix/persist".users.${username}.directories = [".cargo"];
}
