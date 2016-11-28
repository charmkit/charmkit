require 'charmkit'

run 'ls -l /tmp'
status :active, "running application status..."
pkg ['znc', 'znc-perl', 'znc-python'], :update_cache
