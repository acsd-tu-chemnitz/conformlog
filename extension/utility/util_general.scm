(display "loading util_general.scm")(newline)


;; rational to float conversion
(define (rat-numeric-term-to-number-inexact term)
  (let* ((args (term-in-app-form-to-args term))
	 (k (numeric-term-to-number (cadr args)))
	 (i (int-numeric-term-to-number (car args))))
    (exact->inexact (/ i k))

    )
  )


(set-goal "((((((Pvar^2 -> F) ->((Pvar^1-> F))) -> ((Pvar^1 -> (Pvar^2)))))))")
(assume "cond")
(assume "cond1")
(use "Stab")
(assume "stabcond")
(use "cond")
(use "stabcond")
(use "cond1")
(save "ImplicationNegPvar")



(define (write-string-to-file string file)
(let* ((out (open-output-file file)))
(write string out)
(close-output-port out)
  )
)

(define (save-display-proof-to-file file str)
  (let ((old-port (current-output-port))
        (op (open-output-string)))
    (current-output-port op)
    (display-proof str )
    (let ((out (open-output-file file '(replace))))
      (write (get-output-string op) out)
      (close-output-port out))
    (current-output-port old-port)))

(define (save-display-proof str)
  (save-display-proof-to-file str str)
)


