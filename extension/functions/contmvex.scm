
(display "loading contmvex.scm")(newline)


(add-algs
    "contmvex"
    (list "ContmvexConstr" "(ratVec=>nat=>rat)=>(ratVec=>rat=>pos=>nat)=>(ratVec=>rat=>pos=>pos)=>nat=>contmvex"))
;; Center=>radius=>approximation map => modulus of convergence => modulus of continuity




(add-totality "contmvex")

(add-var-name "hmv" (py "(ratVec=>nat=>rat)"))
(add-var-name "almvcR" (py "ratVec=>rat=>pos=>nat"))
(add-var-name "ommvcR" (py "ratVec=>rat=>pos=>pos"))
;;(add-var-name "R" (py "rat"))
(add-var-name "fmvex" (make-alg "contmvex"))

(add-program-constant "ContmvApproxex" (py "contmvex=>ratVec=>nat=>rat") t-deg-zero 'const 1)
(add-program-constant "ContmvModex" (py "contmvex=>ratVec=>rat=>pos=>nat") t-deg-zero 'const 1)
(add-program-constant "ContmvModCex" (py "contmvex=>ratVec=>rat=>pos=>pos") t-deg-zero 'const 1)
(add-program-constant "ContmvDimex" (py "contmvex=>nat") t-deg-zero)


(add-postfix-display-string "ContmvApproxex" "approxexmv")
(add-postfix-display-string "ContmvModex" "modexmv")
(add-postfix-display-string "ContmvModCex" "modcexmv")
(add-postfix-display-string "ContmvDimex" "dimexmv")


(add-computation-rules "(ContmvexConstr hmv almvcR ommvcR n)approxexmv" "hmv")

(set-goal (rename-variables (term-to-totality-formula (pt "ContmvApproxex"))))
(assume "fmvex^" "Tfmv")
(elim "Tfmv")
(ng #t)
(auto)
(save "ContmvApproxexTotal")


(add-computation-rules "(ContmvexConstr hmv almvcR ommvcR n)modexmv" "almvcR")

(set-goal (rename-variables (term-to-totality-formula (pt "ContmvModex"))))
(assume "fmvex^" "Tfmv")
(elim "Tfmv")
(ng #t)
(auto)
(save "ContmvModexTotal")


(add-computation-rules "(ContmvexConstr hmv almvcR ommvcR n)modcexmv" "ommvcR")

(set-goal (rename-variables (term-to-totality-formula (pt "ContmvModCex"))))
(assume "fmvex^" "Tfmv")
(elim "Tfmv")
(ng #t)
(auto)
(save "ContmvModCexTotal")

(add-computation-rules "(ContmvexConstr hmv almvcR ommvcR n)dimexmv" "n")

(set-goal (rename-variables (term-to-totality-formula (pt "ContmvDimex"))))
(assume "fmvex^" "Tfmv")
(elim "Tfmv")
(ng #t)
(auto)
(save "ContmvDimexTotal")



(add-ids
    (list (list "Contmvex" (make-arity (make-alg "contmvex"))))
    '("allnc hmv,almvcR,ommvcR,m(
        all e,e0,R0(RatVecDim e0=m -> RatVecDim e = RatVecDim e0 -> |_( e + ~e0) <= R0 -> Cauchy(hmv e) (almvcR e0 R0)) -->
        all e1,e2,e0,R0,p,n(
                    RatVecDim e0=m -> 
                    RatVecDim e1 = RatVecDim e0 ->
                    RatVecDim e2 = RatVecDim e0 ->
                    |_(e1 + ~e0) <= R0 -> 
                    |_( e2 + ~e0) <= R0 ->
                    almvcR e0 R0 p<=n -> 
                    |_(e1 + ~e2) <= 1/2**PosPred(ommvcR e0 R0 p) ->
                    abs(hmv e1 n - hmv e2 n)<= 1/2**p)-->
        all e0,R0,p,q(p<=q->almvcR e0 R0 p <=almvcR e0 R0 q) -->
        all e0,R0,p,q(p<=q->ommvcR e0 R0 p <= ommvcR e0 R0 q) -->
        Contmvex(ContmvexConstr hmv almvcR ommvcR m))" "ContmvexIntro"))


(set-goal "all fmvex(Contmvex fmvex -> all e,e0,R0(RatVecDim e0= fmvex dimexmv -> RatVecDim e = RatVecDim e0 -> |_( e + ~e0) <= R0 -> Cauchy(fmvex approxexmv  e) (fmvex modexmv e0 R0)))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(elim)
(auto)
(save "ContmvexElim0")




(set-goal "all fmvex(
    Contmvex fmvex -> 
        all e1,e2,e0,R0,p,n(
                    RatVecDim e0=fmvex dimexmv ->
                    RatVecDim e1 = RatVecDim e0 ->
                    RatVecDim e2 = RatVecDim e0 ->
                    |_(e1 + ~e0) <= R0 -> 
                    |_( e2 + ~e0) <= R0 ->
                    fmvex modexmv e0 R0 p<=n -> 
                    |_(e1 + ~e2) <= 1/2**PosPred(fmvex modcexmv e0 R0 p) ->
                    abs(fmvex approxexmv e1 n - fmvex approxexmv e2 n)<= 1/2**p))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(elim)
(auto)
(save "ContmvexElim1")

(set-goal "all fmvex(Contmvex fmvex ->  all e0,R0,p,q(p<=q->fmvex modexmv e0 R0 p <=fmvex modexmv e0 R0 q))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(elim)
(auto)
(save "ContmvexElim2")

(set-goal "all fmvex(Contmvex fmvex -> all e0,R0,p,q(p<=q->fmvex modcexmv e0 R0 p <= fmvex modcexmv e0 R0 q))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(elim)
(auto)
(save "ContmvexElim3")

(add-program-constant "ContmvexApplicationBounded" (py "contmvex=>ratVec=>rat=>realVec=>rea") t-deg-zero)


(set-goal "all fmvex TotalContmvex fmvex")
(cases)
(assume "hmv" "almvcR" "ommvcR" "m")
(use "TotalContmvexContmvexConstr")
(use "AllTotalElim")
(assume "e")
(use "AllTotalElim")
(assume "n")
(use "RatTotalVar")
(use "AllTotalElim")
(assume "e")
(use "AllTotalElim")
(assume "a")
(use "AllTotalElim")
(assume "p")
(use "NatTotalVar")
(use "AllTotalElim")
(assume "e")
(use "AllTotalElim")
(assume "a")
(use "AllTotalElim")
(assume "p")
(use "PosTotalVar")
(use "NatTotalVar")
(save "ContmvexTotalVar")



(add-computation-rule
    "ContmvexApplicationBounded fmvex e0 R0 xx"
    "RealConstr([n] fmvex approxexmv (RatVecConstr(xx seqs n))n)
    ([p](fmvex modexmv e0 R0 (PosS(PosS p)) max xx mods (PosPred( fmvex modcexmv e0 R0 (PosS p)))))")

(set-totality-goal "ContmvexApplicationBounded")
(use "AllTotalElim")
(cases)
(assume "hmv" "almvcR" "ommvcR" "m")
(use "AllTotalElim")
(assume "e")
(use "AllTotalElim")
(assume "a")
(use "AllTotalElim")
(cases)
(assume "vVs" "MVs")
(ng #t)
(use "TotalReaRealConstr")
(use "AllTotalElim")
(assume "n")
(use "RatTotalVar")
(use "AllTotalElim")
(assume "p")
(use "NatTotalVar")
(save-totality)

(set-goal "all vVs,MVs (RealVector(RealVecConstr vVs MVs) -> exl a all n |_ (RatVecConstr(vVs n)) <= a ) ")
(ind)
(assume "MVs")
(ng #t)
(assume "rv")
(intro 0 (pt "0#1"))
(ng #t)
(auto)
(assume "as" "vVs")
(assume "Ih")
(cases)
(ng #t)
(assume "Rv")
(intro 0 (pt "0#1"))
(use "Efq")
(use "CauchyVectorInvalid0" (pt "as::vVs"))
(auto)
(use "RealVectorConstrElim0")
(auto)
(assume "M")
(assume "MVs")
(assume "Rv")
(inst-with-to "RealBoundX" (pt "RealConstr as M") "RBoundInst")
(assert "exl a all n abs((RealConstr as M)seq n)<=a")
(use "RBoundInst")
(use "RealIntro")
(ng #t)
(use "CauchyVectorHeadElim" (pt "vVs") (pt "MVs"))
(use "RealVectorConstrElim0")
(auto)
(use "MonVectorHeadElim" (pt "MVs"))
(use "RealVectorConstrElim1" (pt "as::vVs"))
(auto)
(assume "RBoundOne")
(by-assume "RBoundOne" "a0" "RBoundOneInst")
(assert "exl a all n |_(RatVecConstr(vVs n))<=a")
(use "Ih" (pt "MVs"))
(use "RealVectorIntro")
(use "CauchyVectorElim4Elem" (pt "as" ) (pt "M"))
(use "RealVectorConstrElim0")
(auto)
(use "MonVectorElim4Elem" (pt "M"))
(use "RealVectorConstrElim1" (pt "as::vVs"))
(auto)
(assume "IhInst")
(by-assume "IhInst" "a1" "IhInstProp")
(intro 0 (pt "a0 max a1"))
(assume "n")
(ng #t)
(use "RatLeMonMax")
(use "RBoundOneInst")
(use "IhInstProp")
(save "RealVectorBound0")

(set-goal "all xx (RealVector(xx) -> exl a all n |_ (RatVecConstr(xx seqs n)) <= a )")
(cases)
(ng #t)
(use "RealVectorBound0")
(save "RealVectorXBound0")

(add-sound "RealVectorXBound0")

(set-goal "allnc xx (RealVector(xx) -> exnc a (a eqd cRealVectorXBoundZero xx andnc  all n |_ (RatVecConstr(xx seqs n)) <= a ))")
(assume "xx" "Rx")
(intro 0 (pt "cRealVectorXBoundZero xx"))
(split)
(use "InitEqD")
(use-with "ExLTMRElim" (py "rat") (make-cterm (pv "a") (pf "all n |_(RatVecConstr(xx seqs n)) <= a ")) (pt "cRealVectorXBoundZero xx") "?")
(use "RealVectorXBound0Sound")
(auto)
(save "RealVectorXBound0SoundCorr")

(set-goal "all xx (RealVector(xx) -> all n |_ (RatVecConstr(xx seqs n)) <= cRealVectorXBoundZero xx )")
(assume "xx" "Rxx")
(inst-with-to "RealVectorXBound0SoundCorr" (pt "xx") "RInst")
(cut "exnc a(a eqd cRealVectorXBoundZero xx andnc all n |_(RatVecConstr(RealVecSeqs xx n))<=a)")
(assume "CutRInst")
(by-assume "CutRInst" "a" "CutRInstProp")
(simp "<-" "CutRInstProp")
(use "CutRInstProp")
(use "RInst")
(auto)
(save "RealVectorXBound0ExFree")

;;(deanimate "RealVectorXBound0")

(pt "almvcR e0 R")

(set-goal "all hmv,almvcR,ommvcR,n,e0,R (e0 dim = n -> Contmvex(ContmvexConstr hmv almvcR ommvcR n) -> Contmv(ContmvConstr e0 R hmv (almvcR e0 R) (ommvcR e0 R)))")
(assume "hmv" "almvcR" "ommvcR" "n" "e0" "R")
(assume "dimcond")
(assume "ContexI")
(use "ContmvIntro")
(inst-with-to "ContmvexElim0" (pt "ContmvexConstr hmv almvcR ommvcR n") "Elim0Inst")
(auto)
(inst-with-to "ContmvexElim1" (pt "ContmvexConstr hmv almvcR ommvcR n") "Elim0Inst1")
(auto)
(inst-with-to "ContmvexElim2" (pt "ContmvexConstr hmv almvcR ommvcR n") "Elim0Inst2")
(auto)
(inst-with-to "ContmvexElim3" (pt "ContmvexConstr hmv almvcR ommvcR n") "Elim0Inst3")
(auto)
(save "ContmvexToContmv")

(set-goal "all fmvex,xx,e0,R( Contmvex fmvex -> RealVector(xx) -> Zero<xx dim -> xx dim = fmvex dimexmv -> xx dim = e0 dim -> all n |_(RatVecConstr(RealVecSeqs xx n)+ ~e0)<=R ->  Real(ContmvexApplicationBounded fmvex e0 R xx))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(assume "xx")
(assume "e0" "R")
(assume "Cf")
(assume "Rxx")
(assume "dimcond1" "dimcond2" "dimcond3" "IndomCond")
(simp "ContmvexApplicationBounded0CompRule")
(inst-with-to "ContMvAppRealOne" (pt "ContmvConstr e0 R hmv (almvcR e0 R) (ommvcR e0 R)") (pt "xx") "CfInst")
(use "CfInst")
(use "ContmvexToContmv" (pt "n"))
(simp "<-" "dimcond3")
(use "dimcond2")
(auto)
(use "InDomSeqIntro")
(auto)
(save "ContmvexApplicationBoundedReal")

(deanimate "RealVectorBound0")
(animate "RealVectorXBound0")

(add-program-constant "ContmvexApplication" (py "contmvex=>realVec=>rea") t-deg-zero)

(add-computation-rules "ContmvexApplication fmvex xx" "ContmvexApplicationBounded fmvex (ZerosRational xx dim) (cRealVectorXBoundZero xx) xx")

(set-totality-goal "ContmvexApplication")
(use "AllTotalElim")
(assume "fmvex")
(use "AllTotalElim")
(assume "xx")
(use "ReaTotalVar")
(save-totality)

(add-application (pt "ContmvexApplication"))

(set-goal "all n Lh (ZerosRationalAux n) = n")
(ind)
(ng #t)
(auto)
(save "LhZerosRationalAuxRew")

(define MATCH-TREE-BOUND 1000)

(set-goal "all e,n ( n= e dim -> e + (ZerosRational n ) == e)")
(cases)
(ind)
(auto)
(assume "a" "rls" "Ih")
(assume "n" "cond")
(ng "cond")
(simp "ZerosRational0CompRule")
(simp "cond")
(ng #t)
(simp "LhZerosRationalAuxRew")
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(ng "Ih")
(inst-with-to "Ih" (pt "(ListLength rat)rls") "IhInst")
(ng "IhInst")
(cut "[if ((ListLength rat)
               [if ((ListLength rat)rls=
                     (ListLength rat)(ZerosRationalAux((ListLength rat)rls)))
                 (RatVecConstr
                 (RatVecPlusAux rls(ZerosRationalAux((ListLength rat)rls))))
                 (RatVecConstr(Nil rat))]values=
               (ListLength rat)rls)
           (RatVecEqvAux      
           [if ((ListLength rat)rls=
                 (ListLength rat)(ZerosRationalAux((ListLength rat)rls)))
             (RatVecConstr    
             (RatVecPlusAux rls(ZerosRationalAux((ListLength rat)rls))))
             (RatVecConstr(Nil rat))]values
           rls)
           False]")
(simp "LhZerosRationalAuxRew")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(auto)
(simp "LhZerosRationalAuxRew")
(auto)
(simp "LhZerosRationalAuxRew")
(auto)
(save "RatVecPlusZero")

(set-goal "all n ZerosRational n == ~(ZerosRational n)" )
(ind)
(ng #t)
(auto)
(save "RatVectorZeroEqUMinusZero")

(set-goal "all e,e1,e2,e3 (e==e1 -> e2 == e3 -> e + e2 == e1 + e3)")
(cases)
(ind)
(ng #t)
(assume "e" "e0" "e1")
(assume "LhCond")
(simp "<-" "LhCond")
(ng #t)
(cases (pt "(Zero=(ListLength rat)e1 values)"))
(assume "case")
(simp "<-" "case")
(ng #t)
(cases (pt "(ListLength rat)e0 values=Zero"))
(assume "case2")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(assume "1")
(use "LhCond")
(ng #t)
(simp "<-" "case")
(simp "<-" "LhCond")
(auto)
(ng #t)
(assume "1")
(use "Efq")
(ng #t)
(auto)
(assume "a" "rls")
(assume "Ih")
(cases)
(cases)
(ng #t)
(assume "e" "e0")
(use "Efq")
(assume "a0" "rls0")
(cases)
(cases)
(ng #t)
(cases)
(ng #t)
(cases)
(ng #t)
(auto)
(assume "a1" "rls1")
(ng #t)
(assume "1")
(use "Efq")
(assume "a1" "rls1")
(cases)
(cases)
(ng #t)
(assume "1")
(use "Efq")
(assume "a2" "rls2")
(ng #t)
(cases (pt "(ListLength rat)rls=(ListLength rat)rls0"))
(assume "case1")
(simp "case1")
(ng #t)
(cases (pt "a==a0"))
(assume "case2")
(ng #t)
(cases (pt "(ListLength rat)rls1=(ListLength rat)rls2"))
(ng #t)
(assume "case3")
(cases (pt "a1==a2"))
(assume "case4")
(ng #t)
(cases (pt "(ListLength rat)rls0=(ListLength rat)rls1"))
(assume "case5")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(simp "case5")
(ng #t)
(simp "case3")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(simp "case1")
(ng #t)
(assume "eq1" "eq2")
(assert "a+a1==a0+a2")
(use "RatPlusCompat")
(auto)
(assume "compatcase")
(ng #t)
(simp "compatcase")
(ng #t)
(inst-with-to "Ih" (pt "RatVecConstr rls0") (pt "RatVecConstr rls1") (pt "RatVecConstr rls2") "InInst")
(cut "[if ((ListLength rat)rls=(ListLength rat)rls0)(RatVecEqvAux rls rls0) False] ->[if ((ListLength rat)rls1=(ListLength rat)rls2)(RatVecEqvAux rls1 rls2) False] -> [if ((ListLength rat)[if ((ListLength rat)rls=(ListLength rat)rls1)(RatVecConstr(RatVecPlusAux rls rls1))(RatVecConstr(Nil rat))]values=(ListLength rat)[if ((ListLength rat)rls0=(ListLength rat)rls2)(RatVecConstr(RatVecPlusAux rls0 rls2))(RatVecConstr(Nil rat))]values)(RatVecEqvAux[if ((ListLength rat)rls=(ListLength rat)rls1)(RatVecConstr(RatVecPlusAux rls rls1))(RatVecConstr(Nil rat))]values[if ((ListLength rat)rls0=(ListLength rat)rls2)(RatVecConstr(RatVecPlusAux rls0 rls2))(RatVecConstr(Nil rat))]values)False]")
(simp "case1")
(ng #t)
(simp "case3")
(ng #t)
(simp "case1")
(ng #t)
(simp "case5")
(ng #t)
(simp "case5")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(simp "case1")
(ng #t)
(simp "case3")
(ng #t)
(simp "RatVecPlusAuxLhEqVecLh")
(ng #t)
(auto)
(simp "case5")
(auto)
(simp "case1")
(auto)
(simp "case5")
(auto)
(simp "case1")
(auto)
(ng #t)
(assume "F")
(cases (pt "(ListLength rat)rls0=(ListLength rat)rls2"))
(assume "case5")
(ng #t)
(assume "1" "2")
(use "F")
(simp "case5")
(simp "case3")
(auto)
(assume "F")
(assume "1")
(assume "Falsity")
(ng #t)
(strip)
(use "Efq")
(use "Falsity")
(ng #t)
(assume "1" "2")
(use "Efq")
(ng #t)
(assume "1")
(use "Efq")
(ng #t)
(assume "1")
(use "Efq")
(save "RatVecPlusCompat")

(set-goal "all n (ZerosRational n) dim = n")
(ind)
(auto)
(save "ZerosRationalDim")


(set-goal "all e,n(n = e dim -> |_(e+ ~(ZerosRational n))== |_(e))")
(cases)
(ind)
(ng #t)
(auto)
(assume "a" "eV" "Ih")
(cases)
(ng #t)
(use "Efq")
(assume "n" "cond")
(ng #t)
(ng "cond")
(simp "RatVecUMinusAuxLhId")
(simp "ZerosRationalDim")
(simp "cond")
(ng #t)
(use "RatMaxCompat")
(auto)
(ng "Ih")
(cut "ratListAbsMax
     [if ((ListLength rat)eV=
           (ListLength rat)(RatVecUMinusAux(ZerosRationalAux n)))
       (RatVecConstr(RatVecPlusAux eV(RatVecUMinusAux(ZerosRationalAux n))))
       (RatVecConstr(Nil rat))]values==
     ratListAbsMax eV
  ")
(simp "RatVecUMinusAuxLhId")
(simp "ZerosRationalDim")
(ng #t)
(simp "cond")
(ng #t)
(auto)
(save "RatVectorPlusZerosRational")


(set-goal "all xx (ZerosRational xx dim)dim = xx dim")
(cases)
(ind)
(assume "MVs")
(ng #t)
(auto)
(assume "as" "vVs")
(ng #t)
(assume "Ih")
(cases)
(ng #t)
(use "Truth")
(assume "M" "MVs")
(ng #t)
(ng "Ih")
(cut "(ListLength rat)
     (ZerosRationalAux
      [if ((ListLength nat=>rat)vVs=(ListLength pos=>nat)MVs)
        ((ListLength nat=>rat)vVs)
        Zero])=
     [if ((ListLength nat=>rat)vVs=(ListLength pos=>nat)MVs)
       ((ListLength nat=>rat)vVs)
       Zero]")
(cases (pt "(ListLength nat=>rat)vVs=(ListLength pos=>nat)MVs"))
(ng #t)
(auto)
(save "Zerosdimrew")
(add-rewrite-rule "(ZerosRational xx dim)dim" "xx dim")

(set-goal "all fmvex,xx (Contmvex fmvex -> RealVector xx -> Zero<xx dim -> xx dim=fmvex dimexmv-> Real(fmvex xx))")
(assume "fmvex" "xx" "Cf" "Rxx" "dimcond" "dimcond2")
(use "ContmvexApplicationBoundedReal")
(auto)
(assert "all n Lh (ZerosRationalAux n) = n")
(ind)
(ng #t)
(auto)
(assume "Assertion")
(ng #t)
(simp "Assertion")
(ng #t)
(use "Truth")
(assume "n")
(use "RatLeTrans" (pt "|_(RatVecConstr(RealVecSeqs xx n))"))
(simp "<-" "ZerosRational0CompRule")
(simp "<-" "RealVectorDim0CompRule")
(cut "(ListLength nat=>rat)(RealVecSeqs xx)=(ListLength pos=>nat)(RealVecMods xx)")
(assume "lhcond")
(simp "lhcond")
(use "RatEqvToLe")
(use "RatVectorMaxNormCompat")
(assert "all e,n ( n= e dim -> e + ~(ZerosRational (n)) == e)")
(assume "e" "n0" "cond")
(use "RatVecEqvTrans" (pt "e + (ZerosRational (n0))"))
(use "RatVecPlusCompat")
(use "RatVecEqvRefl")
(use "RatVecEqvSym")
(use "RatVectorZeroEqUMinusZero")
(use "RatVecPlusZero")
(use "cond")
(assume "assertion")
(use "assertion")
(ng #t)
(assert "all xx,n((ListLength nat=>rat)(RealVecSeqs xx)=(ListLength rat)(RealVecSeqs xx n)) ")
(cases)
(assume "vVs" "MVs")
(ng #t)
(assume "n1")
(simp "LhAppRew1")
(auto)
(use "RealVectorElim2")
(use "RealVectorIntro")
(ng #t)
(use "RealVectorElim0")
(auto)
(ng #t)
(use "RealVectorElim1")
(auto)
(use "RealVectorXBound0ExFree")
(auto)
(save "ContmvexApplicationReal")

(set-goal "all xx,yy,fmvex(Zero<xx dim -> xx dim=fmvex dimexmv -> Contmvex fmvex -> xx===yy -> fmvex xx === fmvex yy)")
; (cases)
; (assume "vVs" "MVs")
; (cases)
; (assume "vVs0" "MVs0")
(assume "xx" "yy")
(assume "fmvex")
;(assume "hmv" "almvcR" "ommvcR" "n")
(assume "dim1" "dim2")
(assume "Cf")
(assume "xx=yy")
(use "RealEqChar2")
(use "ContmvexApplicationReal")
(auto)
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "ContmvexApplicationReal")
(auto)
(use "RealVectorEqElim1" (pt "xx"))
(auto)
(simp "RealVectorCompatibleElim2" (pt "xx"))
(auto)
(use "RealVectorEqComponentsElim0")
(use "RealVectorEqSym")
(auto)
(simp "RealVectorCompatibleElim2" (pt "xx"))
(auto)
(use "RealVectorEqComponentsElim0")
(use "RealVectorEqSym")
(auto)
(assume "p")
(inst-with-to "RealVectorXBound0" "RXB")
(inst-with-to "RXB" (pt "xx") "RXBIntermx")
(assert "exl a all n |_(RatVecConstr(RealVecSeqs xx n))<=a")
(use "RXBIntermx")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(assume "RXBIntermxEx")
(by-assume "RXBIntermxEx" "R1" "RXBIntermxExProp")
(inst-with-to "RXB" (pt "yy") "RXBIntermy")
(assert "exl a all n |_(RatVecConstr(RealVecSeqs yy n))<=a")
(use "RXBIntermy")
(use "RealVectorEqElim1" (pt "xx"))
(auto)
(assume "RXBIntermyEx")
(by-assume "RXBIntermyEx" "R2" "RXBIntermyExProp")
(intro 0 (pt "cRealVectorEqCharOne xx yy (PosPred(fmvex modcexmv(RatVecConstr(ZerosRationalAux [if ((ListLength nat=>rat)(RealVecSeqs xx)=(ListLength pos=>nat)(RealVecMods xx))((ListLength nat=>rat)(RealVecSeqs xx))Zero]))(R1 max R2)p)) max fmvex modexmv(ZerosRational xx dim)(R1 max R2)p "))
(assume "n" "n0<=n")
(use "ContmvexElim1" (pt "(ZerosRational xx dim)") (pt "(R1) max (R2)"))
(auto)
(simp "Zerosdimrew")
(use "dim2")
(simp "Zerosdimrew")
(simp "CauchyVectorElim2")
(ng #t)
(assert "all xx (ListLength rat)(RealVecSeqs xx n)=(ListLength nat=>rat)(RealVecSeqs xx)")
(cases)
(assume "vVs" "MVs")
(ng #t)
(use "LhAppRew1")
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(simp "Zerosdimrew")
(simp "CauchyVectorElim2")
(ng #t)
(simp (pf "(ListLength rat)(RealVecSeqs yy n)=(ListLength rat)(RealVecSeqs xx n)"))
(assert "all xx (ListLength rat)(RealVecSeqs xx n)=(ListLength nat=>rat)(RealVecSeqs xx)")
(cases)
(assume "vVs" "MVs")
(ng #t)
(use "LhAppRew1")
(auto)
(assert "xx dim = yy dim")
(ng #t)
(use "RealVectorCompatibleElim2")
(use "RealVectorEqComponentsElim0")
(auto)
(simp "CauchyVectorElim2")
(ng #t)
(simp "CauchyVectorElim2")
(ng #t)
(assert "all xx (ListLength rat)(RealVecSeqs xx n)=(ListLength nat=>rat)(RealVecSeqs xx)")
(cases)
(assume "vVs" "MVs")
(ng #t)
(use "LhAppRew1")
(assume "Assertion")
(assume "dimeqv")
(simp "Assertion")
(simp "Assertion")
(simp "dimeqv")
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim1" (pt "xx"))
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "RatLeTrans" (pt "R1"))
(simprat "RatVectorPlusZerosRational")
(use "RXBIntermxExProp")
(simp "CauchyVectorElim2")
(ng #t)
(simp "LhAppRew1")
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "RatMaxUB1")
(simprat "RatVectorPlusZerosRational")
(use "RatLeTrans" (pt "R2"))
(use "RXBIntermyExProp")
(use "RatMaxUB2")
(simp "CauchyVectorElim2")
(ng #t)
(simp "LhAppRew1")
(inst-with-to "RealVectorCompatibleElim2" (pt "xx") (pt "yy") "RCompatInst")
(ng "RCompatInst")
(cut "[if ((ListLength nat=>rat)(RealVecSeqs xx)=(ListLength pos=>nat)(RealVecMods xx))((ListLength nat=>rat)(RealVecSeqs xx))Zero]=[if ((ListLength nat=>rat)(RealVecSeqs yy)=(ListLength pos=>nat)(RealVecMods yy))((ListLength nat=>rat)(RealVecSeqs yy))Zero]")
(simp "CauchyVectorElim2")
(simp "CauchyVectorElim2")
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim1" (pt "xx"))
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "RCompatInst")
(use "RealVectorEqComponentsElim0")
(auto)
(use "RealVectorElim0")
(use "RealVectorEqElim0" (pt "yy"))
(auto)
(use "NatLeTrans" (pt "cRealVectorEqCharOne xx yy(PosPred(fmvex modcexmv(RatVecConstr(ZerosRationalAux[if ((ListLength nat=>rat)(RealVecSeqs xx)=(ListLength pos=>nat)(RealVecMods xx))((ListLength nat=>rat)(RealVecSeqs xx))Zero]))(R1 max R2)p)) max fmvex modexmv(ZerosRational xx dim)(R1 max R2)p"))
(use "NatMaxUB2")
(auto)
(use "RealVectorEqChar1ExFree")
(use "xx=yy")
(use "NatLeTrans" (pt "cRealVectorEqCharOne xx yy(PosPred(fmvex modcexmv(RatVecConstr(ZerosRationalAux[if ((ListLength nat=>rat)(RealVecSeqs xx)=(ListLength pos=>nat)(RealVecMods xx))((ListLength nat=>rat)(RealVecSeqs xx))Zero]))(R1 max R2)p)) max fmvex modexmv(ZerosRational xx dim)(R1 max R2)p"))
(use "NatMaxUB1")
(auto)
(save "ContmvexCompat")

(add-var-name "Cmapmv" (py "realVec=>rea"))

;;(remove-idpc-name "CmapContmv")

(add-ids
 (list (list "CmapContmv" (make-arity (py "realVec=>rea") (py "nat"))))
 '("all Cmapmv,n(
    all xx ( Zero<xx dim -> xx dim=n -> RealVector xx -> Real(Cmapmv xx)) ->
    all xx,yy( Zero<xx dim -> xx dim=n -> xx===yy -> Cmapmv xx === Cmapmv yy) ->CmapContmv Cmapmv n)" "CmapContmvIntro"))

(set-goal "all Cmapmv,n(CmapContmv Cmapmv n -> all xx ( Zero<xx dim -> xx dim=n -> RealVector xx -> Real(Cmapmv xx)) ) ")
(assume "Cmapmv" "n")
(elim)
(auto)
(save "CmapContmvElim0")


(set-goal "all Cmapmv,n(CmapContmv Cmapmv n -> all xx,yy( Zero<xx dim -> xx dim=n -> xx===yy -> Cmapmv xx === Cmapmv yy) ) ")
(assume "Cmapmv" "n")
(elim)
(auto)
(save "CmapContmvElim1")



(set-goal "all fmvex ( Contmvex fmvex -> CmapContmv (ContmvexApplication fmvex) (fmvex dimexmv))")
(cases)
(assume "hmv" "almvcR" "ommvcR" "n")
(assume "Cf")
(use "CmapContmvIntro")
(assume "xx" "cond1" "cond2" "cond3")
(use "ContmvexApplicationReal")
(auto)
(assume "xx" "yy" "cond1" "cond2" "cond3") 
(use "ContmvexCompat")
(auto)
(save "CmapContmvContex")
