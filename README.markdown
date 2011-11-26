
###Example flying.rb file

```ruby
notify_me :on => "email@gmail.com"

site "http://www.google.com", :as => :google

# If :google is down, will notify the relations,
# e.g. 'www.mysite.com is probably not working properly because :google is offline'
site "http://www.mysite.com", :depends_on => :google

# Connects through SSH into the server and checks production.log if no error happened
rails_app "ssh://kurko@google.com", :path => "/var/rails/google"
```