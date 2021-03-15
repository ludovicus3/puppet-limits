# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   limits::config { 'namevar': }
define limits::config (
  Enum['present','absent'] $ensure = present,
  Hash $limits = {},
  Integer[0,99] $priority = 50,
  Optional[Stdlib::Absolutepath] $path = undef,
) {
  include 'limits'

  $_priority = sprintf('%<prio>02i', { 'prio' => $priority })

  $_path = $path ? {
    Undef   => "${limits::directory}/${_priority}-${title}.conf",
    default => $path,
  }

  concat {$_path:
    ensure         => $ensure,
    owner          => 'root',
    group          => 'root',
    mode           => '0644',
    ensure_newline => true,
  }

  if $ensure == 'present' {
    ensure_resources('limits::limit', $limits, { target => $_path })
  }
}
