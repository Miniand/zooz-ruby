ZooZ Ruby library
=================

The ZooZ Ruby library provides an interface to the ZooZ API.  This library is
purely for API interaction and doesn't provide any Rails helpers.  The upcoming
Rails ZooZ library will provide Rails helpers.

Installation
------------

```
gem install zooz
```

Opening a transaction
---------------------

```
require 'zooz'

req = Zooz::Request::Open.new

# Run in sandbox mode
req.sandox = true

# Enter your details
req.unique_id = 'your-unique-id-here'
req.app_key = 'your-app-key-here'

# Set the details of the transaction
req.currency_code = 'USD'
req.amount = 99.99

# Make the request
resp = req.request
unless resp
  raise "Therre was a problem opening a transaction:\n#{req.errors.join(', ')}"
end

# Use the token and session_token to provide an interface to the customer
token = resp.token
session_token = resp.session_token
```

Verifying a transaction
-----------------------

Coming soon.
