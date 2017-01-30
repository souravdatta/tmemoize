#lang scribble/manual

@(require (for-label tmemoize))
@require[@for-label[tmemoize
                    racket/base]]

@title{tmemoize}
@author{Sourav Datta (soura.jagat@gmail.com)}

@defmodule[tmemoize]


Typed memoize (tmemoize) is a simple library that creates a memoized definition of a function written in typed racket language.
This is not very optimized and given the limitations of typed racket, it may not work correctly with all functions.

A typical example is computing the Fibonacci sequence. Here is a typed racket version of the function:

(memoized 
 (: fibo (-> Integer Integer)) 
 (define (fibo n) 
   (if (<= n 1) 
       n 
       (+ (fibo (- n 1)) 
          (fibo (- n 2)))))) 

Here, the type signature of the function should be the first thing after memoized, otherwise the macro will not work.
