require 'charmkit'
out, err = Charmkit.run('ls -l /tmp')
puts "Result: #{out}: #{err}"
