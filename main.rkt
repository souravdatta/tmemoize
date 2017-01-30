#lang typed/racket

(require (for-syntax syntax/parse))

(: memoize (All (r a ...)
                (-> (-> a ... a r)
                    (-> a ... a r))))
(define (memoize fn)
  (let ([store : (HashTable Any r) (make-hash)])
    (define (memfn . [args : a ... a])
      (hash-ref store args
                (lambda ()
                  (let ([result : r (apply fn args)])
                    (hash-set! store args result)
                    result))))
    memfn))


(define-syntax (memoized stx)
  (syntax-parse stx
    ((_ type-decl (define (fn-name:id arg:id ...+) body ...+))
     (let ([type-decl-v (syntax->datum #'type-decl)])
       (if (not (and (list? type-decl-v)
                     (eqv? (car type-decl-v) ':)))
           (error "Bad type declaration!")
           (let* ([new-fn-name (gensym)]
                  [old-fn-name (syntax->datum #'fn-name)]
                  [new-type-decl-v (map (lambda (s) (if (equal? s old-fn-name) new-fn-name s)) type-decl-v)])
             (with-syntax ([fn-temp-name (datum->syntax stx new-fn-name)]
                           [new-type-decl (datum->syntax stx new-type-decl-v)])
               #'(begin
                   new-type-decl
                   (define (fn-temp-name arg ...) body ...)
                   type-decl
                   (define fn-name (memoize fn-temp-name))))))))
    ((_ (define (fn-name:id arg:id ...+) body ...+))
     #'(define fn-name (memoize (lambda (arg ...) body ...))))))


#|
Example of Fibo :-
(memoized 
 (: fibo (-> Integer Integer)) 
 (define (fibo n) 
   (if (<= n 1) 
       n 
       (+ (fibo (- n 1)) 
          (fibo (- n 2)))))) 
|#

(provide memoize memoized)
