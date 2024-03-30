






From LF Require Export Basics.








Theorem add_0_r_firsttry : forall n:nat,
  n + 0 = n.



Proof.
  intros n.
  simpl. 
Abort.



Theorem add_0_r_secondtry : forall n:nat,
  n + 0 = n.
Proof.
  intros n. destruct n as [| n'] eqn:E.
  - 
    reflexivity. 
  - 
    simpl.       
Abort.





Theorem add_0_r : forall n:nat, n + 0 = n.
Proof.
  intros n. induction n as [| n' IHn'].
  -     reflexivity.
  -  simpl. rewrite -> IHn'. reflexivity.  Qed.



Theorem minus_n_n : forall n,
  minus n n = 0.
Proof.
  
  intros n. induction n as [| n' IHn'].
  - 
    simpl. reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.  Qed.





Theorem mul_0_r : forall n:nat,
  n * 0 = 0.
Proof.
  induction n as [| n' IHn'].
  -     reflexivity.
  -  simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem plus_n_Sm : forall n m : nat,
  S (n + m) = n + (S m).
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem add_comm : forall n m : nat,
  n + m = m + n.
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - 
    simpl. rewrite <- plus_n_O. reflexivity.
  - 
    simpl. rewrite <- plus_n_Sm. rewrite <- IHn'. reflexivity.
Qed.

Theorem add_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.
Qed.




Fixpoint double (n:nat) :=
  match n with
  | O => O
  | S n' => S (S (double n'))
  end.



Lemma double_plus : forall n, double n = n + n .
Proof.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl.
    rewrite -> IHn'.
    rewrite <- plus_n_Sm.
    reflexivity.
Qed.





Lemma nat_equality_reflexivity_2 : forall n : nat, (n =? n) = true.

Proof.
(* Base case: n =? n is true for O *)
  intros n.
induction n as [|n' IHn'].
- (* n = O *)
    reflexivity.
- (* n = S n' *)
    simpl.
(* By induction hypothesis, (n' =? n') = true *)
    rewrite IHn'.
reflexivity.
Qed.

Lemma nat_equality_reflexivity_1 : forall n : nat, (n =? n) = true.

Proof.
(* Base case: n =? n is true for O *)
  intros n.
apply (@nat_equality_reflexivity_2 n).
Qed.

Lemma nat_equality_reflexivity_0 : forall n : nat, (n =? n) = true.

Proof.
(* Base case: n =? n = true for n = 0 *)
  intros n.
apply (@nat_equality_reflexivity_1 n).
Qed.

Theorem eqb_refl : forall n : nat,
  (n =? n) = true.

Proof.
(* Base case: eqb_refl 0 *)
  intros n.
simpl.
apply (@nat_equality_reflexivity_0 n).
Qed.