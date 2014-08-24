#lang racket/base

(require racket/date)

(provide *debug* *info* *warning* *error*)

(provide make-logger log debug info warning error)

(define-values
    (*debug* *info* *warning* *error*) (apply values (build-list 4 values)))

(define level-names
    (list->vector
        '(debug info warning error)))

(define (make-logger #:port (port (current-error-port)) #:level (global-level *info*))
    (define (log message level)
        (when (>= level global-level)
            (parameterize 
                ([current-output-port port])
                (display (date->string (current-date)))
                (display " - ")
                (display (vector-ref level-names level))
                (display ": ")
                (display message)
                (display "\n")
                (flush-output))))
    
    (define (debug message)
        (log message *debug*))

    (define (info message)
        (log message *info*))

    (define (warning message)
        (log message *warning*))

    (define (error message)
        (log message *error*))

    (lambda (message . args)
        (apply (case message
            ([log] log)
            ([debug] debug)
            ([info] info)
            ([warning] warning)
            ([error] error)
            (else error "Unknown method!")
            ) args)))

(define (log logger message level)
    (logger 'log message level))

(define (debug logger message)
    (logger 'debug message))

(define (info logger message)
    (logger 'info message))

(define (warning logger message)
    (logger 'warning message))

(define (error logger message)
    (logger 'error message))
