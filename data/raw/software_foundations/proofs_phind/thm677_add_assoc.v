






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
(*
     We will proceed by induction on n.
Base case: n = 0.
LHS: 0 + (m + p) = (0 + m) + p
             = m + p
         RHS: (0 + m) + p = m + p
     Step case: n = S n'.
Inductive hypothesis: n' + (m + p) = (n' + m) + p
         LHS: S n' + (m + p) = (S n' + m) + p
             = S (n' + m) + p
         RHS: (S n' + m) + p = (n' + m) + S p
             = n' + (m + S p) by induction hypothesis
             = S (n' + (m + p)) by associativity of addition
  *)
  intros n m p.
induction n as [|n' IHn'].
- (* Base case: n = 0 *)
    reflexivity.
- (* Step case: n = S n' *)
    simpl.
rewrite IHn'.
reflexivity.
Qed.