#lang racket/base

(require rackunit
         rackunit/text-ui
         "main.rkt")

(define logger-tests
    (test-suite 
        "Tests for the logging module"
        (test-case
            "Check constants"
            (check-eq? *debug*   0)
            (check-eq? *info*    1)
            (check-eq? *warning* 2)
            (check-eq? *error*   3))
        (test-case
            "Generic log message to a port"
            (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port)])
                (log logger "test" *info*)
                (check-not-false (regexp-match "info: test" (get-output-string str-port)))))
        (test-case
            "Test debug function"
             (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port #:level *debug*)])
                (debug logger "test")
                (check-not-false (regexp-match "debug: test" (get-output-string str-port)))))
        (test-case
            "Test info function"
             (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port #:level *info*)])
                (info logger "test")
                (check-not-false (regexp-match "info: test" (get-output-string str-port)))))
        (test-case
            "Test warning function"
             (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port #:level *warning*)])
                (warning logger "test")
                (check-not-false (regexp-match "warning: test" (get-output-string str-port)))))
        (test-case
            "Test error function"
             (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port #:level *error*)])
                (error logger "test")
                (check-not-false (regexp-match "error: test" (get-output-string str-port)))))
        (test-case
            "Test that nothing is logged if below treshold level"
             (let* ([str-port (open-output-string)]
                   [logger (make-logger #:port str-port #:level *error*)])
                (info logger "test")
                (check-false (regexp-match "info: test" (get-output-string str-port)))
                (check-true (string=? "" (get-output-string str-port)))))))  

(run-tests logger-tests)
