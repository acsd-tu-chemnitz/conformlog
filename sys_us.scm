(define (extload path)
  (minlog-load "extension/" path))
(set! COMMENT-FLAG #f)
(libload "nat.scm")
(libload "list.scm")
;;(libload "str.scm")
(libload "pos.scm")
(libload "int.scm")
(libload "rat.scm")
(libload "rea.scm")
(libload "simpreal.scm")
(extload "utility/util_general.scm")
(extload "numbers/nat_appendix.scm")
(extload "list_appendix.scm")
(extload "numbers/pos_appendix.scm")
(extload "numbers/int_appendix.scm")
(extload "numbers/rat_appendix.scm")
(extload "numbers/rea_appendix.scm")
(extload "functions/cont.scm")
(extload "functions/ucf.scm")
(extload "functions/sqrt2.scm")
(extload "vectors/ratVec.scm")
(extload "vectors/realVec.scm")
(extload "vectors/realVecDTimes.scm")
(extload "vectors/vectornorm.scm")
(extload "functions/contmvex.scm")
(extload "functions/contvex.scm")
(extload "dyn_sys/uniformstability.scm")
;(extload "examples/dyn_sys_examples.scm")
(set! COMMENT-FLAG #t)


(display-global-assumptions)
;; Stab    ((Pvar -> F) -> F) -> Pvar
;; Efq     F -> Pvar
;; StabLog ((Pvar -> bot) -> bot) -> Pvar
;; EfqLog  bot -> Pvar