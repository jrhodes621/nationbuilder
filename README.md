# NationBuilder

Work in progress gem for NationBuilder

## Usage
First Get an access token and configure the gem to your nation
```
require './lib/nationbuilder'
NationBuilder.configure(
	:nation_name => "actionsprout", 
	:client_id => "YOUR_CLIENT_ID",
	:client_secret => "YOUR_CLIENT_SECRET",
	:access_token => "USERS_ACCESS_TOKEN"
)
```
Then you can grab the resources you need:

```
NationBuilder::People.all
# => [...]

NationBuilder::People.match :email => 'jon.doe@example.com'
# => #<NationBuilder::People:0x007fda192be968>

NationBuilder::People.create :first_name => "Jane", :last_name => "Doe", :email => "jane.doe@example.com"


```
## Contributing to nationbuilder
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

#### Copyright

Copyright (c) 2013 Tim White. See LICENSE.txt for
further details.

