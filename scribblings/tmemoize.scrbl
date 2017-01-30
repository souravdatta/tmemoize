#lang scribble/manual

@(require (for-label tmemoize))
@require[@for-label[tmemoize
                    typed/racket/base]]

@title{Typed Memoize - the final frontier!}

A pair of basic utlities for typed racket (TR) to created memoized definitions of functions. The macro requires a specific way of defining your functions which is
very close to a TR function definition.

@table-of-contents[]

@section{The memoized macro}

This macro wraps a typical function definition of TR and generates a memoized version of that function. What is mandatory however is that the first expression inside memoized needs to be
the type declaration of the function. This is copied verbatim in the generated function so you get the same name as well as same type.

A typical example with Fibonacci numbers is:

@racketblock[
 (memoized 
  (: fibo (-> Integer Integer)) 
  (define (fibo n) 
    (if (<= n 1) 
        n 
        (+ (fibo (- n 1)) 
           (fibo (- n 2)))))) 
 ]

The type declaration and the corresponding definition should be in this order or the conversion fails. This will create a memoized fib function with same signature.

@section{The memoize function}

The memoize function gives you more freedom as how to define the input function, but you have to be careful while defining a recursive function. Memoize does not assume about the type
of the function but just converts it to a memoized version and returns the new function. The type declaration of the new function is left to the user.

The above example with memoize function would be like:

@racketblock[
 (: fibo (-> Integer Integer))
 (define fibo (memoize (lambda ([n : Integer])
                         (if (<= n 1)
                             1
                             (+ (fibo (- n 1))
                                (fibo (- n 2)))))))

]

