(display "loading nat.scm extension")(newline)

;; Appendix
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;_____APPENDIX_____;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-goal "all n,m(Zero < n oru Zero <m -> (n+m=Zero -> F))")
(ind)
(ind)
(ng)
(assume "F or F")
(assume "T")
(elim "F or F")
(auto)
(save "NatPlusEqZeroFalse")

(set-goal "all n((n=Zero -> F) -> (Zero<n))")
(ind)
(auto)
(save "NatEqZeroNegtoNatIneq")

(set-goal "all n (0<n-> 1<=n)")
(ind)
(ng #t)
(auto)
(save "NatZeroLtEqOneLe")

(set-goal "all n,m,l(n max m max l = n max (m max l))")
(ind)
(assume "m" "l")
(ng #t)
(auto)
(save "NatMaxAssoc")

(set-goal "all n ((Zero<n -> F)-> Zero=n)")
(ind)
(auto)
(save "NatZeroNotLtEqZero")

(set-goal "all n(Zero<n -> Succ(Pred(n))=n)")
(ind)
(ng #t)
(auto)
(save "SuccPredN")

(set-goal "all n,m(n<=m->((m=n)->F) -> n<m)")
(ind)
(assume "m")
(ng #t)
(assume "T")
(assume "m=Zero -> F")
(cases (pt "Zero<m"))
(auto)
(assume "Falsity")
(use "m=Zero -> F")
(use "NatEqSym")
(use "NatZeroNotLtEqZero")
(auto)
(assume "n")
(assume "Ih")
(ind)
(ng #t)
(auto)
(save "NatLeNotEqToLt")

(set-goal "all n,m( (m<n -> F) -> (m<Succ n) -> n=m ) ")
(ind)
(ind)
(ng #t)
(auto)
(assume "n" "Ih")
(ind)
(ng #t)
(auto)
(save "NatEqCases")

(set-goal "all n(Zero<n)=(Succ Zero<=n)")
(ind)
(auto)
(save "(Zero<n)=(Succ Zero<=n)")

(set-goal "all n(((n=Zero)->F)->Succ Zero<=n)")
(ind)
(ng #t)
(assume "T->F")
(use "T->F")
(use "Truth")
(assume "n" "Ih")
(ng)
(assume "F->F")
(use "Truth")
(save "NatEqZeroFalseToOne")

(set-goal "m<n -> n<m -> F")
(ind)
(ng #t)
(auto)
(assume "n" "Ih")
(cases)
(ng #t)
(auto)
(save "NatLtLtFalse")

(set-goal "all n,m (n=m -> n<=m)")
(assume "n")
(ind)
(ng #t)
(auto)
(assume "m" "Ih")
(assume "n=Succ m")
(ng #t)
(simp "n=Succ m")
(ng #t)
(auto)
(save "NatLeRefl")

(set-goal "all n (0<n->Pred n < n)")
(ind)
(ng #t)
(auto)
(save "NatLtPred")

(set-goal "all n,m( m<=n->(n<m -> F) )")
(ind)
(cases)
(assume "Useless")
(ng #t)
(use "Efq")
(assume "m" "H1")
(assume "Useless")
(ng "H1")
(use "H1")
(assume "n" "IH")
(cases)
(assume "Useless")
(ng #t)
(use "Efq")
(ng #t)
(use "IH")
;; Proof finished.
(save "NatLeToNotLt")

(set-goal "all n( Zero<n->(n=Zero -> F) )")
(ind)
(ng #t)
(auto)
(save "NatZeroLtToNotEq")

(set-goal "all n,m( m<n->(n<=m -> F) )")
(ind)
(cases)
(ng #t)
(use "Efq")
(assume "m" "H1")
(ng #t)
(assume "Useless")
(ng "H1")
(use "H1")
(assume "n" "IH")
(cases)
(assume "Useless")
(ng #t)
(use "Efq")
(ng #t)
(use "IH")
(save "NatLtToNotLe")

(set-goal "all n ((n<Succ Zero)=(n=Zero))")
(ind)
(ng #t)
(auto)
(add-rewrite-rule "(n<Succ Zero)" "(n=Zero)")

(set-goal "all n,m( (n < Succ m) = (n <= m))")
(ind)
(cases)
(ng #t)
(use "Truth")
(assume "m")
(ng #t)
(use "Truth")
(assume "n" "IH")
(cases)
(ng #t)
(use "Truth")
(assume "m")
(ng #t)
(use "IH")
(save "NatSuccLtToLe")
(add-rewrite-rule "n < Succ m" "n <= m")

(set-goal "all n1,n2(n1 max n2 <= n1 max Succ(n2))")
(ind)
(cases)
(use "Truth")
(assume "n")
(use "Truth")
(ng #t)
(assume "n")
(assume "IH")
(cases)
(use "Truth")
(assume "n1" )
(ng #t)
(use "IH")
(save "NatMaxLeSuccMax")

(set-goal "all n,m,l(Zero<l -> (n*l = m*l) = (n=m))")
(assume "n" "m" "l")
(assume 1)
(use "BooleAeqToEq")
(use "NatTimesCancelR")
(use 1)
(assume 1)
(simp 2)
(use "Truth")
(save "NatTimeCancelR")

(set-goal "all l,n,m ( n +l <= m+l -> n <= m)")
(ind)
(assume "n" "m")
(ng #t)
(assume 1)
(use 1)
(assume "n1")
(assume "IH")
(assume "n" "m")
(ng #t)
(assume 1)
(use 2)
(save "NatLePlusSumToLe")

(set-goal "all l,n,m(n<=m->n+l<=m+l)")
(ind)
(assume "n" "m")
(ng #t)
(assume 1)
(use 1)
(assume "l")
(assume "IH" "n" "m")
(ng #t)
(assume 1)
(use 2)
(save "NatLeToPlusSumLe")

(set-goal "all l,n,m( (n+l<=m+l)=(n<=m))")
(assume "l" "n" "m")
(use "BooleAeqToEq")
(use "NatLePlusSumToLe")
(use "NatLeToPlusSumLe")
(save "NatLePlusCancelLSw")

(set-goal "all n (n*1 = n)")
(ng #t)
(assume "n")
(use "Truth")
(save "NatTimesOne")
(add-rewrite-rule "n*1" "n")

(add-program-constant "NatDiv" (py "nat=>nat=>nat=>nat"))
(add-computation-rules
  "NatDiv (Succ n) m l" "[if  (m < Succ n * l) (NatDiv n m l) (Succ (NatDiv n m l))]"
  "NatDiv (Zero) m l" "Zero")

(set-totality-goal "NatDiv")
(use "AllTotalElim")
(ind)
(assume "m^1" "Tm1" "l^1" "Tl1")
(ng #t)
(use "NatTotalVar")
(assume "n")
(assume "IH")
(assume "n^2" "Tn2" "l^2" "Tl2")
(ng #t)
(use "BooleIfTotal")
(use "NatLtTotal")
(use "Tn2")
(use "NatTimesTotal")
(use "NatTotalVar")
(use "Tl2")
(use "IH")
(use "Tn2")
(use "Tl2")
(use "TotalNatSucc")
(use "IH")
(use "Tn2")
(use "Tl2")
(save-totality)

(set-goal "all n (n+n = NatDouble n)")
(ind)
(ng #t)
(use "Truth")
(assume "n")
(assume "IH")
(ng #t)
(use "IH")
(save "NatPlusEqDouble")

(set-goal "all n,m(n <= Succ m -> Pred n <= m)")
(cases)
(assume "m")
(ng #t)
(assume 1)
(use 1)
(assume "n")
(assume "m")
(ng #t)
(assume 1)
(use 1)
(save "NatLeSuccToPredLe")

(set-goal "all n,m(Pred n <= m -> n <= Succ m)")
(cases)
(assume "m")
(ng #t)
(assume 1)
(use 1)
(assume "n" "m")
(ng #t)
(assume 1)
(use 1)
(save "NatPredLeToLeSucc")

(set-goal "all n,m((n <= Succ m) = (Pred n <= m))")
(cases)
(assume "m")
(ng #t)
(use "Truth")
(assume "n" "m")
(ng #t)
(use "Truth")
(save "NatPredLeEqLeSucc")

(set-goal "all n,m(Succ n <= Succ m -> n<=m)")
(cases)
(ng #t)
(assume "m" 1)
(use 1)
(ng #t)
(assume "n" "m" 1)
(use 1)
(save "NatLeToSuccLe")

(set-goal "all m,n(Pred(m--n) = Pred m --n)")
(cases)
(assume "n")
(use "Truth")
(assume "n" "m")
(use "Truth")
(save "NatPredMinusDistL")

(set-goal "all n( n <= NatDouble n)")
(ind)
(use "Truth")
(assume "n" "IH")
(ng #t)
(use "NatLeTrans" (pt "NatDouble n"))
(use "IH")
(use "Truth")
(add-rewrite-rule "n <= NatDouble n" "T")
(save "NatLeDoubleTaut")

(set-goal "all n(Zero<n -> Succ(Pred n) = n)")
(cases)
(ng #t)
(use "Efq")
(assume "n")
(ng #t)
(assume 1)
(use 1)
(save "NatSuccPredEqId")

(set-goal "all m,n((Succ m <= n) = (m < n))")
(ind)
(cases)
(ng #t)
(use "Truth")
(assume "n")
(ng #t)
(use "Truth")
(assume "n" "IH")
(cases)
(ng #t)
(use "Truth")
(assume "n1")
(ng #t)
(use "IH")
(save "NatSuccLeEqLt")
;(add-rewrite-rule "Succ m <= n" "m < n")

(set-goal "all n((n = Zero -> F) -> Zero<n)")
(cases)
(assume 1)
(use 1)
(use "Truth")
(assume "n")
(ng #t)
(assume 1)
(use "Truth")
(save "NatNotEqZeroToLt")

(set-goal "all n (NatDouble(Succ n) = Succ(Succ (NatDouble n)))")
(cases)
(ng #t)
(use "Truth")
(assume "n")
(ng #t)
(use "Truth")
(save "NatDoubleSucc")

(set-goal "all n,m (m<=n -> Succ n -- m = Succ (n--m))")
(ind)
(cases)
(ng #t)
(assume 1)
(use "Truth")
(ng #t)
(assume "n" 1)
(use 1)
(assume "n" "IH")
(cases)
(ng #t)
(assume 1)
(use 2)
(ng #t)
(assume "m" "Lim")
(ng #t)
(use "IH")
(use "Lim")
(save "NatMinusSucc")

(set-goal "all n(NatDouble n--n = n)")
(ind)
(ng #t)
(use "Truth")
(assume "n" "IH")
(simp "NatDoubleSucc")
(ng #t)
(simp "NatMinusSucc")
(ng #t)
(use "IH")
(use "NatLeDouble")
(save "NatDoubleMinusNat")

(set-goal "all n,m,l(n <= m+l -> (n <= l ->F) -> n--l <= m)")
(ind)
(cases)
(cases)
(ng #t)
(assume 1 1)
(use 1)
(assume "l")
(ng #t)
(assume 1 1)
(use 1)
(assume "m" "l")
(ng #t)
(assume 1 1)
(use 1)
(assume "n" "IH")
(cases)
(cases)
(ng #t)
(assume 1 1)
(use 2)
(assume "l")
(ng #t)
(assume 1 1)
(inst-with "IH" (pt "Zero") (pt "l"))
(use 4)
(use 2)
(use 3)
(assume "m")
(cases)
(ng #t)
(assume 1 1)
(use 2)
(assume "l")
(assume 1 1)
(ng #t)
(use "IH")
(ng 2)
(ng #t)
(use 2)
(ng 3)
(use 3)
(save "NatLePlusToMinus")

(set-goal "all n,m,l(n < m+l -> (n < l ->F) -> n--l < m)")
(ind)
(cases)
(cases)
(ng #t)
(assume 1 1)
(use 1)
(assume "l")
(ng #t)
(assume 1 1)
(use 2)
(use 1)
(assume "m" "l")
(ng #t)
(assume 1 1)
(use 1)
(assume "n" "IH")
(cases)
(cases)
(ng #t)
(assume 1 1)
(use 2)
(assume "l")
(ng #t)
(assume 1 1)
(use 3)
(use 2)
(assume "m")
(cases)
(ng #t)
(assume 1 1)
(use 2)
(assume "l")
(cases (pt "n = l"))
(assume "c1")
(simp "c1")
(ng #t)
(assume 1 1)
(use 3)
(assume "nc1")
(ng #t)
(assume 1 1)
(use "NatLePlusToMinus")
(use 3)
(assert "all n,l((n=l -> F) -> (n<l -> F) -> (n<=l -> F))")
(ind)
(cases)
(ng #t)
(assume 1 1 1)
(use 5)
(use 7)
(assume "l1")
(ng #t)
(assume 1 1 1)
(use 6)
(use 7)
(assume "n1" "IH1")
(cases)
(ng #t)
(assume 1 1 1)
(use 8)
(assume "l1")
(ng #t)
(use "IH1")
(assume "Ass1")
(use "Ass1")
(use "nc1")
(use 4)
(save "NatLtPlusToMinus")

(set-goal "all n,m(n <= m ->Zero<=m--n)")
(ind)
(cases)
(ng #t)
(assume 1)
(use 1)
(ng #t)
(assume "n" 1)
(use 1)
(assume "n" "IH")
(cases)
(ng #t)
(assume 1)
(use "Truth")
(assume "m")
(ng #t)
(assume 1)
(use "Truth")
(save "NatLeZeroToLe")

(set-goal "all m,n(m+n--m = n)")
(cases)
(assume "n")
(use "Truth")
(assume "n")
(ng #t)
(assume "m")
(use "Truth")
(save "NatMinusElimRule0")

(set-goal "all m,n(m<=n->m+(n--m) = n)")
(ind)
(assume "n")
(ng #t)
(assume 1)
(use 1)
(assume "n" "IH")
(cases)
(ng #t)
(assume 1)
(use 2)
(assume "m")
(ng #t)
(use "IH")
(save "NatMinusElimRule1")

(set-goal "all n,m,l((n+m<=n+l) = (m<=l))")
(ind)
(ng #t)
(assume "m" "l")
(use "Truth")
(ng #t)
(strip)
(use "Truth")
(save "NatLePlusCancelL")

(set-goal "all n,m(Zero < n -> n < m -> Pred n < m)")
(ind)
(cases)
(ng #t)
(use "Efq")
(assume "m")
(ng #t)
(assume 1 1)
(use "Truth")
(assume "n" "IH")
(cases)
(ng #t)
(assume 1)
(use "Efq")
(assume "m")
(ng #t)
(assume 1 1)
(use "NatLtToLe")
(use 3)
(save "NatLtToLtPred")

(set-goal "all n,m,l( n+l < m+l -> n<m)")
(search)
(save "NatLtPlusCancelR")

(set-goal "all n,m,l( (n+l < m+l) = (n<m))")
  (assert "all l,n,m( (n+l < m+l) = (n<m))")
  (ind)
  (assume "n" "m")
  (use "Truth")
  (assume "l" "IHl")
  (assume "n" "m")
  (use "Truth")
  (assume "A1")
  (assume "n" "m" "l")
  (use "A1")
(save "NatLtPlusCancelRSw")

(set-goal "all n,m( (n<Pred m) = (Succ n < m))")
(cases)
(cases)
(ng #t)
(use "Truth")
(assume "n")
(ng #t)
(use "Truth")
(assume "n")
(cases)
(ng #t)
(use "Truth")
(assume "m")
(ng #t)
(use "Truth")
(save "NatLtSuccToPred")

(set-goal "all n,m(Zero < n -> (Pred n < m)=(n < Succ m))")
(cases)
(cases)
(ng #t)
(assume 1)
(use 1)
(assume "m")
(ng #t)
(assume 1)
(use "Truth")
(assume "n")
(ng #t)
(assume "m")
(assume 1)
(use 1)
(save "NatSuccLtEqPredLt")

(set-goal "all n((Pred n < n) = (Zero < n))")
(cases)
(ng #t)
(use "Truth")
(assume "n")
(ng #t)
(use "Truth")
(save "NatPredLtIdCase")
(add-rewrite-rule "Pred n < n" "Zero < n")

(set-goal "all n,m,n0,m0(n<=n0 -> m<=m0 -> n max m <= n0 max m0)")
(assume "n" "m" "n0" "m0")
(assume "eq0" "eq1")
(use "NatMaxLUB")
(use "NatLeTrans" (pt "n0"))
(use "eq0")
(use "NatMaxUB1")
(use "NatLeTrans" (pt "m0"))
(use "eq1")
(use "NatMaxUB2")
(save "NatMaxLeLeCompat")

;__________________________ Transform Lib Ext_________________________
(set-goal "all n1,n2,m1,m2(n1<=m1 -> n2 <= m2 -> n1+n2<=m1+m2)")
  (ind)
  (cases)
  (ng #t)
  (assume "m1" "m2" 1 1)
  (use "Truth")
  (assume "n2")
  (ng #t)
  (assume "m1" "m2" 1 "rel")
  (use "NatLeTrans" (pt "m2"))
  (use "rel")
  (ng #t)
  (use "Truth")
  (assume "n1" "IH")
  (cases)
  (ng #t)
  (assume "m1" "m2" "rel" 1)
  (use "NatLeTrans" (pt "m1"))
  (use "rel")
  (use "Truth")
  (assume "n2")
  (cases)
  (assume "m1")
  (ng #t)
  (use "Efq")
  (assume "m1")
  (cases)
  (ng #t)
  (assume 1)
  (use "Efq")
  (assume "m2")
  (assume "rel1" "rel2")
  (use "IH")
  (use "rel1")
  (use "rel2")
(save "NatLePlusCases")

(set-goal "all l,n,m(n<=m -> l*n<=l*m)")
  (ind)
  (ng #t)
  (assume "n" "m" "1")
  (use "Truth")
  (assume "l" "IH")
  (cases)
  (ng #t)
  (assume "m")
  (auto)
  (assume "n")
  (cases)
  (ng #t)
  (assume 1)
  (use 2)
  (assume "m")
  (ng #t)
  (assume "rel")
  (use "NatLePlusCases")
  (use "IH")
  (use "rel")
  (use "rel")
(save "NatLeTimesCancelLInv")

(set-goal "all n (1*n = n)")
  (ng #t)
  (strip)
  (use "Truth")
(save "NatTimesOne1")
(add-rewrite-rule "1*n" "n")

(set-goal "all n,m((n max m) eqd (m max n))")
  (ind)
  (ng #t)
  (assume "m")
  (use "InitEqD")
  (assume "n" "IH")
  (cases)
  (ng #t)
  (use "InitEqD")
  (assume "m")
  (ng #t)
  (simp "IH")
  (use "InitEqD")
(save "NatMaxCommEqD")

(add-program-constant "DivInt" (py "nat=>nat=>nat=>nat"))
(add-computation-rules
  "DivInt (Succ n) m l" "[if  (m < Succ n * l) (DivInt n m l) (Succ (DivInt n m l))]"
  "DivInt (Zero) m l" "Zero")

(set-totality-goal "DivInt")
  (use "AllTotalElim")
  (ind)
  (assume "m^1" "Tm1" "l^1" "Tl1")
  (ng #t)
  (use "NatTotalVar")
  (assume "n")
  (assume "IH")
  (assume "n^2" "Tn2" "l^2" "Tl2")
  (ng #t)
  (use "BooleIfTotal")
  (use "NatLtTotal")
  (use "Tn2")
  (use "NatTimesTotal")
  (use "NatTotalVar")
  (use "Tl2")
  (use "IH")
  (use "Tn2")
  (use "Tl2")
  (use "TotalNatSucc")
  (use "IH")
  (use "Tn2")
  (use "Tl2")
(save-totality)

(set-goal "all n,m(Zero < n -> n<=m -> Pred n < m)")
  (cases)
  (assume "m")
  (ng #t)
  (use "Efq")
  (assume "n")
  (cases)
  (ng #t)
  (assume 1)
  (use "Efq")
  (assume "m")
  (ng #t)
  (assume 1 1)
  (use 2)
(save "NatLeToPredLt")

(set-goal "all n,m(Succ n <= m -> n <= Pred m)")
  (cases)
  (assume "m")
  (ng #t)
  (assume 1)
  (use "Truth")
  (assume "n")
  (cases)
  (ng #t)
  (use "Efq")
  (assume "m")
  (ng #t)
  (assume 1)
  (use 1)
(save "NatSuccLeToLePred")

(set-goal "all n,m(n <= Pred m -> Zero < m -> Succ n <= m)")
  (cases)
  (cases)
  (ng #t)
  (assume 1)
  (use "Efq")
  (assume "n")
  (ng #t)
  (assume 1 1)
  (use "Truth")
  (assume "n")
  (cases)
  (ng #t)
  (use "Efq")
  (assume "m")
  (ng #t)
  (assume 1 1)
  (use 1)
(save "NatLePredToSuccLe")

(set-goal "all n,m(Succ n <= Succ m -> n<=m)")
  (cases)
  (ng #t)
  (assume "m" 1)
  (use 1)
  (ng #t)
  (assume "n" "m" 1)
  (use 1)
(save "NatSuccLeExt")

(set-goal "all n,m((n <= Succ m) = (Pred n <= m))")
  (cases)
  (assume "m")
  (ng #t)
  (use "Truth")
  (assume "n" "m")
  (ng #t)
  (use "Truth")
(save "NatLeSuccEqPredLe")

(set-goal "all n((n = Zero -> F) -> Zero<n)")
  (cases)
  (assume 1)
  (use 1)
  (use "Truth")
  (assume "n")
  (ng #t)
  (assume 1)
  (use "Truth")
(save "NatLtCases")

(set-goal "all n (NatDouble(Succ n) = Succ(Succ (NatDouble n)))")
  (cases)
  (ng #t)
  (use "Truth")
  (assume "n")
  (ng #t)
  (use "Truth")
(save "NatDoubleSuccDist")

(set-goal "all n,m (m<=n -> Succ n -- m = Succ (n--m))")
  (ind)
  (cases)
  (ng #t)
  (assume 1)
  (use "Truth")
  (ng #t)
  (assume "n" 1)
  (use 1)
  (assume "n" "IH")
  (cases)
  (ng #t)
  (assume 1)
  (use 2)
  (ng #t)
  (assume "m" "Lim")
  (ng #t)
  (use "IH")
  (use "Lim")
(save "NatMinusSuccDist")

(set-goal "all n(NatDouble n--n = n)")
  (ind)
  (ng #t)
  (use "Truth")
  (assume "n" "IH")
  (simp "NatDoubleSuccDist")
  (ng #t)
  (simp "NatMinusSuccDist")
  (ng #t)
  (use "IH")
  (use "Truth")
(save "NatDoubleMinusId")

(set-goal "all n,m,l(n+l <= m -> l <= m -> n <= m--l)")
    (assert "all l,m,n(n+l <= m -> l <= m -> n <= m--l)")
      (ind)
      (ng #t)
      (assume "m" "n" "Rel" "Ta")
      (use "Rel")
      (assume "l" "IH" "n" "m" "Rel")
      (ng)
      (assume "Cond")
      (simp "NatPredMinusDistL")
      (use "IH")
      (use "NatSuccLeToLePred")
      (use "Rel")
      (use "NatSuccLeToLePred")
      (use "Cond")
    (assume "A1")
  (assume "n" "m" "l")
  (use "A1")
(save "NatLeMinusToPlus")

(set-goal "all n,m,l(n <= m--l -> l <= m -> n+l<=m)")
    (assert "all l,n,m(n <= m--l -> l <= m -> n+l<=m)")
      (ind)
      (ng #t)
      (auto)
      (assume "l" "IH")
      (ng #t)
      (assume "n" "m" "Rel" "Cond")
      (cases (pt "m = Zero"))
      (assume "C1")
      (simp "C1")
      (ng #t)
      (simphyp-with-to "Cond" "C1" "Contra")
      (ng "Contra")
      (use "Contra")
      (assume "nC1")
      (use "NatLePredToSuccLe")
      (use "IH")
      (simp "<-" "NatPredMinusDistL")
      (use "Rel")
      (use "NatSuccLeToLePred")
      (use "Cond")
      (use "NatNotLeToLt")
      (use "nC1")
    (assume "A1")
  (assume "n" "m" "l")
  (use "A1")
(save "NatLeMinusToPlusLe")

(set-goal "all n,m((NatDouble n <= NatDouble m) = (n<=m))")
  (ind)
  (ng #t)
  (assume "l2")
  (use "Truth")
  (assume "n" "IH")
  (cases)
  (ng #t)
  (use "Truth")
  (assume "l2")
  (use "IH")
(add-rewrite-rule "NatDouble n <= NatDouble m" "n<=m")
(save "NatDoubleLeElimRWRule")

(set-goal "all n((NatDouble n = Zero) = (n=Zero))")
  (cases)
  (ng #t)
  (use "Truth")
  (ng #t)
  (assume "n")
  (use "Truth")
(save "NatDoubleZeroRWRule")

(set-goal "all n(Zero < n -> NatDouble(n)=Zero -> F)")
  (cases)
  (ng #t)
  (use "Efq")
  (assume "n")
  (ng #t)
  (assume 1)
  (use "Efq")
(save "NatDoubleEqZeroRule")

(set-goal "all n,m,l(l <= n-> l <= m -> l <= n min m)")
  (assert "all l,n,m(l <= n-> l <= m -> l <= n min m)")
    (ind)
    (assume "n" "m")
    (ng #t)
    (strip)
    (use "Truth")
    (assume "l" "IHl")
    (cases)
    (assume "m")
    (ng #t)
    (use "Efq")
    (assume "n")
    (cases)
    (ng #t)
    (assume "Cond1")
    (use "Efq")
    (assume "m")
    (ng #t)
    (use "IHl")
  (assume "A1")
(assume "n" "m" "l")
(use "A1")
(save "NatMinLLB")


(set-goal "all l,n,m( (l+n<=l+m) -> (n<=m))")
(assume "l" "n" "m")
(assume "cond")
(simp "<-" "NatLePlusCancelLSw" (pt "l"))
(simp "NatPlusComm")
(simp "NatPlusComm")
(use "cond")
(save "NatLePlusCancelRSw")


(set-goal "all n ex m n=m")
(assume "n")
(ex-intro (pt "n"))
(auto)
(save "NatSubVar")


(set-goal "all n,m ((Succ n) max m =Zero -> F)")
(assume "n")
(ind)
(ng #t)
(auto)
(save "NatMaxSuccProp")

(set-goal "all n,m( n eqd m -> n=m)")
(ind)
(ng #t)
(assume "m")
(assume "cond")
(simp "<-" "cond")
(auto)
(assume "n" "Ih")
(assume "m")
(assume "Succm")
(simp "<-" "Succm")
(auto)
(save "EqDToNatEq")


(set-goal "all m,n(m<=n -> Succ(n--m)=Succ(n)--m)")
(ind)
(ng)
(strip)
(use "Truth")
(assume "m" "IH")
(cases)
(ng)
(assume "Absurd")
(use "Absurd")
(assume "n")
(use "IH")
;; Proof finished.
;; (cdp)
(save "SuccNatMinusLe")



(set-goal "all n,n0 ( n0<=n -> exl m n=m+n0)")
(ind)
(ng #t)
(assume "n" "n=Zero")
(intro 0 (pt "Zero"))
(simp "n=Zero")
(use "Truth")
(assume "n" "Ih")
(cases)
(assume "T")
(ng #t)
(intro 0 (pt "Succ n"))
(use "Truth")
(assume "n0" "n0len")
(ng #t)
(assert " exl m n=m+n0")
(use "Ih")
(use "n0len")
(assume "ExInst")
(by-assume "ExInst" "m0" "ExInstProp")
(intro 0 (pt "m0"))
(use "ExInstProp")
(save "NatLeExShift")

(add-var-name "ps" (py "nat=>boole"))



;; PropNatLeast (from minlog HEAD)
(set-goal "all n,m,ps(m<=n -> ps m -> ps(NatLeast n ps))")
(ind)
;; 2,3
(ng #t)
(assume "m" "ps" "m=0")
(simp "m=0")
(assume "ps0")
(use "ps0")
;; 3
(assume "n" "IH")
(ng #t)
(cases)
;; Zero
(assume "ps" "Useless" "g0")
(simp "g0")
(use "g0")
;; Succ
(assume "m" "ps" "m<=n" "gSm")
(inst-with-to "IH" (pt "m") (pt "[n0]ps(Succ n0)") "m<=n" "gSm" "Inst")
(ng)
(cases (pt "ps Zero"))
(assume "g0")
(use "g0")
(assume "Useless")
(ng #t)
(use "Inst")
;; Proof finished.
;; (cp)
(save "PropNatLeast")
