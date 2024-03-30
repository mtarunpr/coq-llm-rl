






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



Theorem eqb_refl : forall n : nat,
  (n =? n) = true.
Proof.
  intros n.
  induction n.
  reflexivity.
  simpl. rewrite <- IHn. reflexivity.
Qed.




Theorem even_S : forall n : nat,
  even (S n) = negb (even n).
Proof.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    rewrite -> IHn'.
    rewrite -> negb_involutive.
    reflexivity.
Qed.











Theorem mult_0_plus' : forall n m : nat,
  (n + 0 + 0) * m = n * m.
Proof.
  intros n m.
  assert (H: n + 0 + 0 = n).
    { rewrite add_comm. simpl. rewrite add_comm. reflexivity. }
  rewrite -> H.
  reflexivity.  Qed.





Theorem plus_rearrange_firsttry : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  
  rewrite add_comm.
  
Abort.



Theorem plus_rearrange : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (H: n + m = m + n).
  { rewrite add_comm. reflexivity. }
  rewrite H. reflexivity.  Qed.










Theorem add_assoc' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof. intros n m p. induction n as [| n' IHn']. reflexivity.
  simpl. rewrite IHn'. reflexivity.  Qed.



Theorem add_assoc'' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p. induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite IHn'. reflexivity.   Qed.










Definition manual_grade_for_add_comm_informal : option (nat*string) := None.





Definition manual_grade_for_eqb_refl_informal : option (nat*string) := None.







Theorem add_shuffle3 : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite -> add_assoc.
  rewrite -> add_assoc.
  assert (H: n + m = m + n).
  { rewrite -> add_comm. reflexivity. }
  rewrite -> H. reflexivity.
Qed.



Theorem mul_comm : forall m n : nat,
  m * n = n * m.
Proof.
  intros m n.
  destruct m as [| m'].
  - simpl. rewrite -> mul_0_r. reflexivity.
  - induction n as [| n' IHn'].
    + simpl. rewrite -> mul_0_r. reflexivity.
    + simpl.
      rewrite <- IHn'.
      simpl.
      rewrite <- mult_n_Sm.
      assert (H1: m' + (n' + m' * n') = n' + (m' + m' * n')).
      { rewrite -> add_shuffle3. reflexivity. }
      assert (H2: m' * n' + m' = m' + m' * n').
      { rewrite -> add_comm. reflexivity. }
      rewrite -> H1. rewrite -> H2.
      reflexivity.
Qed.




Check leb.

Theorem plus_leb_compat_l : forall n m p : nat,
  n <=? m = true -> (p + n) <=? (p + m) = true.
Proof.
  intros n m p.
  intros H.
  induction p as [| p' IHp'].
  - simpl. rewrite -> H. reflexivity.
  - simpl. rewrite -> IHp'. reflexivity.
Qed.





Theorem leb_refl : forall n:nat,
  (n <=? n) = true.
Proof.
  induction n as [| n'].
  - reflexivity.
  - simpl. rewrite <- IHn'. reflexivity.
Qed.

Theorem zero_neqb_S : forall n:nat,
  0 =? (S n) = false.
Proof.
  reflexivity. Qed.

Theorem andb_false_r : forall b : bool,
  andb b false = false.
Proof.
  destruct b.
  reflexivity. reflexivity. Qed.

Theorem S_neqb_0 : forall n:nat,
  (S n) =? 0 = false.
Proof.
  reflexivity. Qed.

Theorem mult_1_l : forall n:nat, 1 * n = n.
Proof.
  intros n. simpl. rewrite -> plus_n_O. reflexivity. Qed.

Theorem all3_spec : forall b c : bool,
  orb
    (andb b c)
    (orb (negb b)
         (negb c))
  = true.
Proof.
  intros b c.
  destruct b.
  - simpl.
    destruct c.
    + reflexivity.
    + reflexivity.
  - reflexivity.
Qed.

Theorem mult_plus_distr_r : forall n m p : nat,
  (n + m) * p = (n * p) + (m * p).
Proof.
  intros n m p.
  induction p as [| p' IHp'].
  - rewrite -> mul_0_r. rewrite -> mul_0_r. rewrite -> mul_0_r.
    reflexivity.
  - rewrite <- mult_n_Sm.
    rewrite <- mult_n_Sm.
    rewrite <- mult_n_Sm.
    rewrite -> IHp'.
    assert (H1: n * p' + m * p' + (n + m) = n * p' + (m * p' + (n + m))).
    { rewrite <- add_assoc. reflexivity. }
    rewrite -> H1.
    assert (H2: n * p' + n + (m * p' + m) = n * p' + (n + (m * p' + m))).
    { rewrite <- add_assoc. reflexivity. }
    rewrite -> H2.
    assert (H3: n + (m * p' + m) = n + m * p' + m).
    { rewrite <- add_assoc. reflexivity. }
    rewrite -> H3.
    assert (H4: n + m * p' = m * p' + n).
    { rewrite -> add_comm. reflexivity. }
    rewrite -> H4.
    rewrite -> add_assoc.
    rewrite -> add_assoc.
    rewrite -> add_assoc.
    rewrite -> add_assoc.
    reflexivity.
Qed.



Theorem mult_assoc : forall n m p : nat,
  n * (m * p) = (n * m) * p.

Proof.
(* We will proceed by induction on n.
*)
  intros n.
(* Base case: n = 0.
*)
  induction n as [|n' IHn'].
- (* n = 0, m * 0 = 0 *)
    intros m p.
simpl.
reflexivity.
- (* n = S n', (S n') * (m * p) = (S n' * m) * p *)
    intros m p.
simpl.
rewrite IHn'.
reflexivity.
Qed.