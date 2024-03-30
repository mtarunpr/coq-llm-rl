



Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From Coq Require Import Arith List.
From LF Require Import IndProp.



Fixpoint re_opt_e {T:Type} (re: reg_exp T) : reg_exp T :=
  match re with
  | App EmptyStr re2 => re_opt_e re2
  | App re1 re2 => App (re_opt_e re1) (re_opt_e re2)
  | Union re1 re2 => Union (re_opt_e re1) (re_opt_e re2)
  | Star re => Star (re_opt_e re)
  | _ => re
  end.



Lemma re_opt_e_match : forall T (re: reg_exp T) s,
  s =~ re -> s =~ re_opt_e re.
Proof.
  intros T re s M.
  induction M
    as [| x'
        | s1 re1 s2 re2 Hmatch1 IH1 Hmatch2 IH2
        | s1 re1 re2 Hmatch IH | re1 s2 re2 Hmatch IH
        | re | s1 s2 re Hmatch1 IH1 Hmatch2 IH2].
  -  simpl. apply MEmpty.
  -  simpl. apply MChar.
  -  simpl.
    destruct re1.
    + apply MApp.
      * apply IH1.
      * apply IH2.
    + inversion Hmatch1. simpl. apply IH2.
    + apply MApp.
      * apply IH1.
      * apply IH2.
    + apply MApp.
      * apply IH1.
      * apply IH2.
    + apply MApp.
      * apply IH1.
      * apply IH2.
    + apply MApp.
      * apply IH1.
      * apply IH2.
  -  simpl. apply MUnionL. apply IH.
  -  simpl. apply MUnionR. apply IH.
  -  simpl. apply MStar0.
  -  simpl. apply MStarApp.
    * apply IH1.
    * apply IH2.
Qed.













Theorem silly1 : forall n, 1 + n = S n.
Proof. try reflexivity.  Qed.

Theorem silly2 : forall (P : Prop), P -> P.
Proof.
  intros P HP.
  Fail reflexivity.
  try reflexivity. 
  apply HP.
Qed.










Lemma simple_semi : forall n, (n + 1 =? 0) = false.
Proof.
  intros n.
  destruct n eqn:E.
    
    -  simpl. reflexivity.
    -  simpl. reflexivity.
Qed.



Lemma simple_semi' : forall n, (n + 1 =? 0) = false.
Proof.
  intros n.
  
  destruct n;
  
  simpl;
  
  reflexivity.
Qed.



Lemma simple_semi'' : forall n, (n + 1 =? 0) = false.
Proof.
  destruct n; reflexivity.
Qed.





Theorem andb_eq_orb :
  forall (b c : bool),
  (andb b c = orb b c) ->
  b = c.
Proof. destruct b; destruct c; try reflexivity; try discriminate. Qed.

Theorem add_assoc : forall n m p : nat,
    n + (m + p) = (n + m) + p.
Proof. intros n m p; induction n as [| n' IHn']; try (simpl; rewrite IHn'); reflexivity. Qed.

Fixpoint nonzeros (lst : list nat) :=
  match lst with
  | [] => []
  | 0 :: t => nonzeros t
  | h :: t => h :: nonzeros t
  end.



Lemma nonzeros_app : forall lst1 lst2 : list nat,
  nonzeros (lst1 ++ lst2) = (nonzeros lst1) ++ (nonzeros lst2).

Proof.
(*
    We will proceed by induction on lst1.
Base case: lst1 = []
    In this case, we have nonzeros ([] ++ lst2) = nonzeros lst2.
By reflexivity of equality, this is true.
*)
  intros lst1 lst2.
induction lst1 as [|n1 lst1'].
- simpl.
reflexivity.
(*
    Inductive case: nonzeros (n1 :: lst1' ++ lst2) = nonzeros (n1 :: lst1') ++ nonzeros lst2
    We will split this into two goals:
    1.
n1 :: nonzeros (lst1' ++ lst2) = nonzeros (n1 :: lst1') ++ nonzeros lst2
    2.
nonzeros lst1' ++ nonzeros lst2 = nonzeros (n1 :: lst1') ++ nonzeros lst2
  *)
  - simpl.
split.
(*
      For the first goal, we will proceed by cases on n1.
If n1 = 0, then we have nonzeros (0 :: lst1' ++ lst2) = nonzeros lst1' ++ nonzeros lst2.
By the IH, this is true.
If n1 <> 0, then we have nonzeros (n1 :: lst1' ++ lst2) = n1 :: nonzeros (lst1' ++ lst2).
By the IH, this is true.
*)
    - destruct n1.
+ simpl.
rewrite IHlst1'.
reflexivity.
+ simpl.
rewrite IHlst1'.
reflexivity.
(*
      For the second goal, we will proceed by cases on lst1'.
If lst1' = [], then we have nonzeros lst2 = nonzeros [] ++ nonzeros lst2.
By reflexivity of equality, this is true.
If lst1' <> [], then we have nonzeros lst2 = nonzeros lst1' ++ nonzeros lst2.
By the IH, this is true.
*)
    - destruct lst1' as [|n
Qed.