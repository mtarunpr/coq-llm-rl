

Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From Coq Require Import Lia.
From LF Require Import Maps.
From LF Require Import Imp.



Theorem ceval_deterministic: forall c st st1 st2,
  st =[ c ]=> st1  ->
  st =[ c ]=> st2 ->
  st1 = st2.
Proof.
  intros c st st1 st2 E1 E2;
  generalize dependent st2;
  induction E1; intros st2 E2; inversion E2; subst.
  -  reflexivity.
  -  reflexivity.
  - 
    rewrite (IHE1_1 st'0 H1) in *.
    apply IHE1_2. assumption.
  
  - 
    apply IHE1. assumption.
  - 
    rewrite H in H5. discriminate.
  
  - 
    rewrite H in H5. discriminate.
  - 
    apply IHE1. assumption.
  
  - 
    reflexivity.
  - 
    rewrite H in H2. discriminate.
  
  - 
    rewrite H in H4. discriminate.
  - 
    rewrite (IHE1_1 st'0 H3) in *.
    apply IHE1_2. assumption.  Qed.






Example auto_example_1 : forall (P Q R: Prop),
  (P -> Q) -> (Q -> R) -> P -> R.
Proof.
  intros P Q R H1 H2 H3.
  apply H2. apply H1. assumption.
Qed.



Example auto_example_1' : forall (P Q R: Prop),
  (P -> Q) -> (Q -> R) -> P -> R.
Proof.
  auto.
Qed.







Example auto_example_2 : forall P Q R S T U : Prop,
  (P -> Q) ->
  (P -> R) ->
  (T -> R) ->
  (S -> T -> U) ->
  ((P -> Q) -> (P -> S)) ->
  T ->
  P ->
  U.
Proof. auto. Qed.




Example auto_example_3 : forall (P Q R S T U: Prop),
  (P -> Q) ->
  (Q -> R) ->
  (R -> S) ->
  (S -> T) ->
  (T -> U) ->
  P ->
  U.
Proof.
  
  auto.

  
  

  
  auto 6.
Qed.



Example auto_example_4 : forall P Q R : Prop,
  Q ->
  (Q -> R) ->
  P \/ (Q /\ R).
Proof. auto. Qed.



Example auto_example_5: 2 = 2.
Proof.
  auto.
Qed.

Example auto_example_5' : forall (P Q R S T U W: Prop),
  (U -> T) ->
  (W -> U) ->
  (R -> S) ->
  (S -> T) ->
  (P -> R) ->
  (U -> T) ->
  P ->
  T.
Proof.
  intros.
  auto.
Qed.



Lemma le_antisym : forall n m: nat, (n <= m /\ m <= n) -> n = m.
Proof. lia. Qed.

Example auto_example_6 : forall n m p : nat,
  (n <= p -> (n <= m /\ m <= n)) ->
  n <= p ->
  n = m.
Proof.
  auto using le_antisym.
Qed.





Hint Resolve le_antisym : core.

Example auto_example_6' : forall n m p : nat,
  (n<= p -> (n <= m /\ m <= n)) ->
  n <= p ->
  n = m.
Proof.
  auto. 
Qed.

Definition is_fortytwo x := (x = 42).

Example auto_example_7: forall x,
  (x <= 42 /\ 42 <= x) -> is_fortytwo x.
Proof.
  auto.  
Abort.

Hint Unfold is_fortytwo : core.

Example auto_example_7' : forall x,
  (x <= 42 /\ 42 <= x) -> is_fortytwo x.
Proof.
  auto. 
Qed.







Theorem ceval_deterministic' : forall c st st1 st2,
  st =[ c ]=> st1  ->
  st =[ c ]=> st2 ->
  st1 = st2.

Proof.
(* This theorem is already proven by the existing theorem "ceval_deterministic".
The theorem "ceval_deterministic'" is an exact duplicate of "ceval_deterministic" with a different name.
Therefore, we can simply use "ceval_deterministic" as the proof of "ceval_deterministic'".
*)
  exact ceval_deterministic.
Qed.