Flying is a tool for monitoring websites and apps. It was designed to be as simple as Gemfiles.

###Getting started

Install the gem:

    gem install flying

Create a Ruby file anywhere with the following content:

```ruby
# flying.rb
require "flying"

site "http://www.google.com"
site "http://www.nytimes.com"

start # starts monitoring
```

Now, just run in your terminal:

    ruby flying.rb

Whenever one of those two sites gets offline, Flying will warn you and stop monitoring.

###Goal of the project

We want to be able to use the following DSL:

```ruby
require "flying"

# Defines the interval between verifications
timer 1

# Send an email if any error occured
notify_me :email => "email@gmail.com"

# When an error happens, monitoring stops. :on_error_continue
# makes Flying ignore the error and continue monitoring.
site "http://www.google.com", :as => :google, :on_error_continue

# If :google is down (above, :as => :google), Flying will notify the related services,
# e.g. 'www.mysite.com is probably not working properly because :google is offline'
site "http://www.mysite.com", :depends_on => :google

# Besides checking site availability, makes sure the response.body is a valid XML,
# ideal for making sure 3rd-party webservices are working.
site "http://www.fedex.com/webservice", :format => :xml

# Logs to the server via SSH, goes to a Rails app directory and do the following:
#
# - Reads production.log file and checks if any error happened (e.g. Errno... )
# - Looks for config/database.yml and tries connecting to all possible DBs, except
#   'development' and 'test'
rails_app "ssh://kurko@google.com", :path => "/var/rails/google"

start
```

###License

License is MIT. If you're gonna improve this project, please collaborate and send
a pull request.