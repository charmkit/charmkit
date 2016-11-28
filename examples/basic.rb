require 'charmkit'

out, err = run('ls -l /tmp')

puts "#{out}"
