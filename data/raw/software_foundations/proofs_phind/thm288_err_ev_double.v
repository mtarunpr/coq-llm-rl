

Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From LF Require Export Logic.
From Coq Require Import Lia.











Fixpoint div2 (n : nat) :=
  match n with
    0 => 0
  | 1 => 0
  | S (S n) => S (div2 n)
  end.

Definition f (n : nat) :=
  if even n then div2 n
  else (3 * n) + 1.





Fail Fixpoint reaches_1_in (n : nat) :=
  if n =? 1 then 0
  else 1 + reaches_1_in (f n).





Inductive reaches_1 : nat -> Prop :=
  | term_done : reaches_1 1
  | term_more (n : nat) : reaches_1 (f n) -> reaches_1 n.





Conjecture collatz : forall n, reaches_1 n.










Module LePlayground.



Inductive le : nat -> nat -> Prop :=
  | le_n (n : nat)   : le n n
  | le_S (n m : nat) : le n m -> le n (S m).

End LePlayground.



Inductive clos_trans {X: Type} (R: X->X->Prop) : X->X->Prop :=
  | t_step (x y : X) :
      R x y ->
      clos_trans R x y
  | t_trans (x y z : X) :
      clos_trans R x y ->
      clos_trans R y z ->
      clos_trans R x z.



Inductive clos_refl_trans {X: Type} (R: X->X->Prop) : X->X->Prop :=
  | t_step' (x y : X) :
      R x y ->
      clos_refl_trans R x y
  | t_refl (x : X) :
      clos_refl_trans R x x
  | t_symm (x y : X):
      clos_refl_trans R x y ->
      clos_refl_trans R y x
  | t_trans' (x y z : X) :
      clos_refl_trans R x y ->
      clos_refl_trans R y z ->
      clos_refl_trans R x z.







Inductive Perm3 {X : Type} : list X -> list X -> Prop :=
  | perm3_swap12 (a b c : X) :
      Perm3 [a;b;c] [b;a;c]
  | perm3_swap23 (a b c : X) :
      Perm3 [a;b;c] [a;c;b]
  | perm3_trans (l1 l2 l3 : list X) :
      Perm3 l1 l2 -> Perm3 l2 l3 -> Perm3 l1 l3.


















Inductive ev : nat -> Prop :=
  | ev_0                       : ev 0
  | ev_SS (n : nat) (H : ev n) : ev (S (S n)).



Fail Inductive wrong_ev (n : nat) : Prop :=
  | wrong_ev_0 : wrong_ev 0
  | wrong_ev_SS (H: wrong_ev n) : wrong_ev (S (S n)).








Theorem ev_4 : ev 4.
Proof. apply ev_SS. apply ev_SS. apply ev_0. Qed.



Theorem ev_4' : ev 4.
Proof. apply (ev_SS 2 (ev_SS 0 ev_0)). Qed.



Theorem ev_plus4 : forall n, ev n -> ev (4 + n).
Proof.
  intros n. simpl. intros Hn.  apply ev_SS. apply ev_SS. apply Hn.
Qed.




Theorem ev_double : forall n,
  ev (double n).

Proof.
(* We will proceed by induction on n.
*)
  intros n.
(* We will need to use the definition of double.
*)
  unfold double.
(* Now we will proceed by induction on n.
*)
  induction n as [|n' IHn'].
(* The base case is when n is 0.
In this case, double 0 is 0, and we need to prove ev 0.
*)
  - simpl.
apply ev_0.
(* The inductive case is when n is S n'.
In this case, double (S n') is S (S (double n')).
*)
  - simpl.
(* We will need to use the induction hypothesis on n'.
*)
    apply IHn'.
(* We also need to prove that ev (S (S (double n'))).
*)
    apply ev_SS.
(* This is where we use the induction hypothesis.
*)
    assumption.
Qed.