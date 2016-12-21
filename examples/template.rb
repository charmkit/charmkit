require 'charmkit'

template 'templates/user_auth.txt', '/tmp/user_auth.txt',
         firstname: "joe", lastname: "bob"

file "/tmp/another-test.txt", "owned"
