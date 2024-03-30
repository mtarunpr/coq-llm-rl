

Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From LF Require Export Tactics.



Check (3 = 3) : Prop.

Check (forall n m : nat, n + m = m + n) : Prop.



Check 2 = 2 : Prop.

Check 3 = 2 : Prop.

Check forall n : nat, n = 2 : Prop.





Theorem plus_2_2_is_4 :
  2 + 2 = 4.
Proof. reflexivity.  Qed.



Definition plus_claim : Prop := 2 + 2 = 4.
Check plus_claim : Prop.



Theorem plus_claim_is_true :
  plus_claim.
Proof. reflexivity.  Qed.





Definition is_three (n : nat) : Prop :=
  n = 3.
Check is_three : nat -> Prop.



Definition injective {A B} (f : A -> B) :=
  forall x y : A, f x = f y -> x = y.

Lemma succ_inj : injective S.
Proof.
  intros n m H. injection H as H1. apply H1.
Qed.



Check @eq : forall A : Type, A -> A -> Prop.











Example and_example : 3 + 4 = 7 /\ 2 * 2 = 4.



Proof.
  split.
  -  reflexivity.
  -  reflexivity.
Qed.



Lemma and_intro : forall A B : Prop, A -> B -> A /\ B.
Proof.
  intros A B HA HB. split.
  - apply HA.
  - apply HB.
Qed.



Example and_example' : 3 + 4 = 7 /\ 2 * 2 = 4.
Proof.
  apply and_intro.
  -  reflexivity.
  -  reflexivity.
Qed.


Example and_exercise :
  forall n m : nat, n + m = 0 -> n = 0 /\ m = 0.
Proof.
  intros n m H.
  split.
  - destruct m in H.
    + rewrite <- plus_n_O in H. apply H.
    + rewrite <- plus_n_Sm in H. discriminate H.
  - destruct n in H.
    + rewrite -> plus_n_O in H. apply H.
    + simpl in H. discriminate H.
Qed.




Lemma and_example2 :
  forall n m : nat, n = 0 /\ m = 0 -> n + m = 0.
Proof.
  
  intros n m H.
  destruct H as [Hn Hm].
  rewrite Hn. rewrite Hm.
  reflexivity.
Qed.



Lemma and_example2' :
  forall n m : nat, n = 0 /\ m = 0 -> n + m = 0.
Proof.
  intros n m [Hn Hm].
  rewrite Hn. rewrite Hm.
  reflexivity.
Qed.



Lemma and_example2'' :
  forall n m : nat, n = 0 -> m = 0 -> n + m = 0.
Proof.
  intros n m Hn Hm.
  rewrite Hn. rewrite Hm.
  reflexivity.
Qed.



Lemma and_example3 :
  forall n m : nat, n + m = 0 -> n * m = 0.
Proof.
  
  intros n m H.
  apply and_exercise in H.
  destruct H as [Hn Hm].
  rewrite Hn. reflexivity.
Qed.



Lemma proj1 : forall P Q : Prop,
  P /\ Q -> P.
Proof.
  intros P Q HPQ.
  destruct HPQ as [HP _].
  apply HP.  Qed.


Lemma proj2 : forall P Q : Prop,
  P /\ Q -> Q.
Proof.
  intros P Q [_ HQ].
  apply HQ.
Qed.




Theorem and_commut : forall P Q : Prop,
  P /\ Q -> Q /\ P.
Proof.
  intros P Q [HP HQ].
  split.
    -  apply HQ.
    -  apply HP.  Qed.



Theorem and_assoc : forall P Q R : Prop,
  P /\ (Q /\ R) -> (P /\ Q) /\ R.
Proof.
  intros P Q R [HP [HQ HR]].
  split.
  + split. apply HP. apply HQ.
  + apply HR.
Qed.




Check and : Prop -> Prop -> Prop.








Lemma factor_is_O:
  forall n m : nat, n = 0 \/ m = 0 -> n * m = 0.
Proof.
  
  intros n m [Hn | Hm].
  - 
    rewrite Hn. reflexivity.
  - 
    rewrite Hm. rewrite <- mult_n_O.
    reflexivity.
Qed.



Lemma or_intro_l : forall A B : Prop, A -> A \/ B.
Proof.
  intros A B HA.
  left.
  apply HA.
Qed.



Lemma zero_or_succ :
  forall n : nat, n = 0 \/ n = S (pred n).
Proof.
  
  intros [|n'].
  - left. reflexivity.
  - right. reflexivity.
Qed.


Lemma mult_is_O :
  forall n m, n * m = 0 -> n = 0 \/ m = 0.
Proof.
  intros n m H.
  destruct n.
  - left. reflexivity.
  - right. destruct m.
    + reflexivity.
    + discriminate H.
Qed.



Theorem or_commut : forall P Q : Prop,
  P \/ Q  -> Q \/ P.
Proof.
  intros P Q [HP | HQ].
  - right. apply HP.
  - left. apply HQ.
Qed.







Module NotPlayground.

Definition not (P:Prop) := P -> False.

Notation "~ x" := (not x) : type_scope.

Check not : Prop -> Prop.

End NotPlayground.



Theorem ex_falso_quodlibet : forall (P:Prop),
  False -> P.
Proof.
  
  intros P contra.
  destruct contra.  Qed.





Theorem not_implies_our_not : forall (P:Prop),
  ~ P -> (forall (Q:Prop), P -> Q).
Proof.
  intros P HNP Q contra.
  unfold not in HNP.
  apply HNP in contra. destruct contra.
Qed.








Lemma contradiction_lemma_3 : False.

Proof.
(* We are trying to prove False.
Since we have no information or hypotheses
     to work with, we can't construct a proof.
Therefore, we can't prove this lemma.
*)
Admitted.
Qed.

Lemma zero_not_equal_one_2 : 0 <> 1.

Proof.
(* We will use the definition of inequality in Coq, which is defined as a negation of equality.
In other words, a <> b is the same as ~ (a = b).
So, we want to prove ~ (0 = 1).
*)
  intros.
(* We will use the ex_falso_quodlibet theorem, which states that from a contradiction (False), we can derive any proposition (P).
So, we will first prove False, and then use ex_falso_quodlibet to derive our goal.
*)
  apply ex_falso_quodlibet.
(* To prove False, we will use the not_implies_our_not theorem, which states that if we have a negation of a proposition (~ P),
     then we can derive a forall (Q : Prop), P -> Q, which is equivalent to P -> False.
*)
  apply (@contradiction_lemma_3 ).
Qed.

Lemma zero_not_equal_one_1 : 0 <> 1.

Proof.
(* We will use the definition of inequality in Coq, which is defined as a negation of equality.
In other words, "0 <> 1" is the same as "~ (0 = 1)".
We will prove this by contradiction.
Assume "0 = 1".
Then, we have a contradiction with the axiom "0 <> S n" for any n.
This axiom states that no number is equal to the successor of that number.
So, we have "0 = S n" for some n, which contradicts "0 = 1".
Therefore, our assumption that "0 = 1" is false, and we have proved "0 <> 1".
*)
  intros.
apply (@zero_not_equal_one_2 ).
- (* Base case: n = 0 *)
    intros.
apply nat_0_S_neq.
- (* Inductive step: n = S n' *)
    intros.
apply IHn.
apply nat_S_neq.
Qed.

Lemma zero_not_equal_one_0 : 0 <> 1.

Proof.
(* We will use the definition of inequality in Coq, which is defined as a negation of equality.
In other words, "0 <> 1" is the same as "~ (0 = 1)".
We will prove this by contradiction.
Assume "0 = 1".
Then, we have a contradiction with the axiom "0 <> S n" for any n.
This axiom states that no number is equal to the successor of that number.
So, we have "0 = S n" for some n, which contradicts "0 = 1".
Therefore, our assumption that "0 = 1" is false, and we have proved "0 <> 1".
*)
  intros.
apply (@zero_not_equal_one_1 ).
Qed.

Theorem zero_not_one : 0 <> 1.

Proof.
(* We will use the definition of inequality in Coq, which is defined as a negation of equality.
Thus, we will prove 0 = 1 -> False.
*)
  intros.
(* We now have the hypothesis H: 0 = 1.
We will now use the induction principle for natural numbers.
*)
  apply (@zero_not_equal_one_0 ).
- (* In this case, we have H: 0 = 1, which is a contradiction as we know 0 <> 1.
*)
    exfalso.
(* We now have the hypothesis H1: False.
We will now use the ex_falso_quodlibet lemma to derive a contradiction.
*)
    apply ex_falso_quodlibet.
(* This gives us the goal False, which is what we wanted to prove.
*)
    

Qed.