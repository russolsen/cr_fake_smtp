# fake_smtp

This is a completely trivial SMTP server, written in Crystal. This is a port
of the Ruby program of the same name.
See https://github.com/russolsen/fake_smtp

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


## Development

TODO: Write instructions for development

## Contributing

1. Fork it ( https://github.com/[your-github-name]/fake_smtp/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [your-github-name](https://github.com/[your-github-name]) Russ Olsen - creator, maintainer

======================
FakeSmtp
=======


Why?
----

Sometimes you just want to be sure that the mail is getting formated and
sent the way you think it is.

Usage
-----

The gem comes with a simple script `fake_smtp` that will run the server.
To run the server, just run the script:

    $ gem install fake_smtp

    $ fake_smtp
    FakeSmtp: Listening on port 2025

As you can see, by default the server runs on port 2025. You can change
the port by passing in the --port option:

    $ fake_smtp --port 3333
    FakeSmtp: Listening on port 3333

The server implements just enough of the SMTP protocol to convince
an SMTP client (well ActiveMailer anyway) that there is a *there* there.

Contributors
------------

* Russ Olsen
* Based on https://github.com/russolsen/fake_smtp.
* Which itself was partially based on `https://github.com/livinginthepast/fake_ftp.git`.

License
-------

The MIT License

Copyright (c) 2013-2015 by Russ Olsen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
