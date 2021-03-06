# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   limits::limit { 'namevar': }
define limits::limit (
  Limits::Item $item,
  Limits::Value $value,
  Integer $order = 50,
  Optional[Limits::Domain] $domain = undef,
  Optional[Limits::Type] $type = undef,
  Optional[Stdlib::Absolutepath] $target = undef,
  Optional[String] $comment = undef,
) {
  include 'limits'

  $_target = $target ? {
    Undef   => $limits::config_file,
    default => $target,
  }

  if !defined(Concat[$_target]) {
    concat { $_target:
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      warn   => epp('limits/header.epp'),
      #      ensure_newline => true,
    }
  }

  $_domain = $domain ? {
    Undef   => '*',
    default => $domain,
  }

  $_type = $type ? {
    Undef   => '-',
    default => $type,
  }

  concat::fragment {"${_target}-${title}":
    target  => $_target,
    content => epp('limits/limit.epp', {
      domain  => $_domain,
      type    => $_type,
      item    => $item,
      value   => $value,
      comment => $comment,
    }),
    order   => $order,
  }
}
