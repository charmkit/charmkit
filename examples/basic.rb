require 'charmkit'

run 'ls -l /tmp'
status :active, "running application status..."
package ['znc', 'znc-perl', 'znc-python'], :update_cache
is_installed? 'znc'
