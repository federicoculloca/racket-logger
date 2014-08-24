racket-logger
===

This is a little experiment I made in racket before noticing there already is a logger in the standard library.

This logger is a very simplified one, nothing fancy :)

How to use it
===

First, instanciate a log passing a port and logging level as (optional) arguments

    (define logger (make-logger #:port (open-output-file "app.log") #:level *warning*)

Then go crazy with logging

    (warning logger "Variable declared but never used")
    (error logger "Connection refused by remote host")
    (info logger "I won't be logged because I'm just an info, and this log is setup for anything above 'warning' level)
    (debug logger "I won't be logged either")

There are four levels of logging: debug, info, warning and error. When you declare a logging level, anything below that won't be logged (see example above).

Also, `make-logger` defaults to `current-error-port` and `*info*` for the port and the logging level respectively.

