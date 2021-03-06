# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include limits
class limits (
  Stdlib::Absolutepath $config_file = '/etc/security/limits.conf',
  Stdlib::Absolutepath $directory = '/etc/security/limits.d',
  Hash $default_limits = {},
  Boolean $purge = false,
) {
  if $purge {
    $recurse = true
  } else {
    $recurse = false
  }

  file {$directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => $purge,
    recurse => $recurse,
  }

  ensure_resources('limits::limit', $default_limits)
}
