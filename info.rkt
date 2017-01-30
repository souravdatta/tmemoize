#lang info
(define collection "tmemoize")
(define deps '("base"
               "typed-racket-lib"
               "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/tmemoize.scrbl" ())))
(define pkg-desc "This package provides basic support for memoization in typed racket")
(define version "0.1")
(define pkg-authors '(soura.jagat@gmail.com))
