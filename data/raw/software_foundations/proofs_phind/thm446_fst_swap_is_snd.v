

From LF Require Export Induction.
Module NatList.






Inductive natprod : Type :=
  | pair (n1 n2 : nat).



Check (pair 3 5) : natprod.



Definition fst (p : natprod) : nat :=
  match p with
  | pair x y => x
  end.

Definition snd (p : natprod) : nat :=
  match p with
  | pair x y => y
  end.

Compute (fst (pair 3 5)).




Notation "( x , y )" := (pair x y).



Compute (fst (3,5)).

Definition fst' (p : natprod) : nat :=
  match p with
  | (x,y) => x
  end.

Definition snd' (p : natprod) : nat :=
  match p with
  | (x,y) => y
  end.

Definition swap_pair (p : natprod) : natprod :=
  match p with
  | (x,y) => (y,x)
  end.





Theorem surjective_pairing' : forall (n m : nat),
  (n,m) = (fst (n,m), snd (n,m)).
Proof.
  reflexivity. Qed.



Theorem surjective_pairing_stuck : forall (p : natprod),
  p = (fst p, snd p).
Proof.
  simpl. 
Abort.



Theorem surjective_pairing : forall (p : natprod),
  p = (fst p, snd p).
Proof.
  intros p. destruct p as [n m]. simpl. reflexivity. Qed.




Theorem snd_fst_is_swap : forall (p : natprod),
  (snd p, fst p) = swap_pair p.
Proof.
  destruct p. reflexivity. Qed.





Lemma nat_equality_reflexive_4 : forall n m : nat, m = m.

Proof.
(* The goal is to prove that m is equal to itself.
This is a trivial
     proposition in Coq, as the equality relation is reflexive.
*)
  intros n m.
reflexivity.
Qed.

Lemma swap_fst_and_snd_3 : forall p : natprod, fst match p with
    | (x, y) => (y, x)
    end = snd p.




Proof.
(*
    We will proceed by induction on p.
The base case will be when p is of the form (pair n m).
In this case, we will show that fst (pair m n) = snd (pair n m).
The inductive case will be when p is of the form (pair x y).
In this case, we will show that fst (pair y x) = snd (pair x y).
*)
  
intros p.
destruct p as [n m].
-
 (* Base case: p = (pair n m) *)
    
simpl.
apply (@nat_equality_reflexive_4 n m).
Qed.

Lemma swap_fst_and_snd_2 : forall p : natprod, fst match p with
    | (x, y) => (y, x)
    end = snd p.




Proof.
(*
    We will proceed by induction on p.
Case analysis on p will reveal that the statement holds for all possible values of p.
*)
  
intros p.
apply (@swap_fst_and_snd_3 p).
Qed.

Lemma swap_pair_fst_equals_snd_1 : forall p : natprod, fst (swap_pair p) = snd p.

Proof.
(* We will proceed by induction on p.
*)
  intros p.
(* We will need to use the definition of swap_pair.
*)
  unfold swap_pair.
(* Now we will case on p.
*)
  apply (@swap_fst_and_snd_2 p).
Qed.

Lemma swap_pair_fst_equals_snd_0 : forall p : natprod, fst (swap_pair p) = snd p.

Proof.
(*
    We will proceed by induction on p.
The base case will be when p is (pair n m).
In this case, we will show that fst (swap_pair (pair n m)) = snd (pair n m).
By the definition of swap_pair, we have fst (swap_pair (pair n m)) = snd (pair n m).
Therefore, the base case holds.
For the inductive step, we will assume that the property holds for some p and show that it holds for (swap_pair p).
By the definition of swap_pair, we have fst (swap_pair p) = snd p.
Therefore, the inductive step holds.
By the principle of mathematical induction, the property holds for all p.
*)
  intros p.
apply (@swap_pair_fst_equals_snd_1 p).
Qed.

Theorem fst_swap_is_snd : forall (p : natprod),
  fst (swap_pair p) = snd p.

Proof.
(*
    We will proceed by induction on p.
The base case will be when p is (pair n m).
In this case, we will show that fst (swap_pair (pair n m)) = snd (pair n m).
By the definition of swap_pair, we have fst (swap_pair (pair n m)) = snd (pair n m).
Therefore, the base case holds.
For the inductive step, we will assume that the property holds for some p and show that it holds for (swap_pair p).
By the definition of swap_pair, we have fst (swap_pair p) = snd p.
Therefore, the inductive step holds.
By the principle of mathematical induction, the property holds for all p.
*)
  intros p.
apply (@swap_pair_fst_equals_snd_0 p).
Qed.