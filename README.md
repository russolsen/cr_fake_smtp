# fake_smtp

This is a completely trivial SMTP server, written in Crystal. This is a port
of the Ruby program of the same name.
See https://github.com/russolsen/fake_smtp

Why?
----

Sometimes you just want to be sure that the mail is getting formated and
sent the way you think it is.


The server implements just enough of the SMTP protocol to convince
an SMTP client (well ActiveMailer anyway) that there is a *there* there.

## Installation

Add it to `Projectfile`

```crystal
deps do
  github "russolsen/fake_smtp"
end
```

## Usage

There are a number of ways to use fake_smtp. You can either just run the application
from the command line with crystal:

```
crystal src/application.cr
```

Or you can build it and run the resulting executable:

```
$ make
crystal build --release -o fake_smtp src/application.cr
$ ./fake_smtp
Listening on localhost 2025.
```

Either way you can specify the host and port:

```
$ crystal src/application.cr -- -p 9999 --host 127.0.0.1
Listening on 127.0.0.1 9999.

$ ./fake_smtp -p 9999 --host 127.0.0.1
Listening on 127.0.0.1 9999.
```
Or you can use the API from a program:

```crystal
require "fake_smtp"

FakeSmtp::Server.new(host: "localhost", port: 9999).run
```
## Contributing

1. Fork it ( https://github.com/[your-github-name]/fake_smtp/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

Contributors
------------

* russolsen (https://github.com/russolsen) Russ Olsen - creator, maintainer
* Based on https://github.com/russolsen/fake_smtp.
* Which itself was partially based on `https://github.com/livinginthepast/fake_ftp.git`.
