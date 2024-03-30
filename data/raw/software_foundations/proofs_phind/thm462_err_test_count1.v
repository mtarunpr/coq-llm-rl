

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



Theorem fst_swap_is_snd : forall (p : natprod),
  fst (swap_pair p) = snd p.
Proof.
  destruct p. reflexivity. Qed.







Inductive natlist : Type :=
  | nil
  | cons (n : nat) (l : natlist).



Definition mylist := cons 1 (cons 2 (cons 3 nil)).



Notation "x :: l" := (cons x l)
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).



Definition mylist1 := 1 :: (2 :: (3 :: nil)).
Definition mylist2 := 1 :: 2 :: 3 :: nil.
Definition mylist3 := [1;2;3].








Fixpoint repeat (n count : nat) : natlist :=
  match count with
  | O => nil
  | S count' => n :: (repeat n count')
  end.






Fixpoint length (l:natlist) : nat :=
  match l with
  | nil => O
  | h :: t => S (length t)
  end.






Fixpoint app (l1 l2 : natlist) : natlist :=
  match l1 with
  | nil    => l2
  | h :: t => h :: (app t l2)
  end.



Notation "x ++ y" := (app x y)
                     (right associativity, at level 60).

Example test_app1:             [1;2;3] ++ [4;5] = [1;2;3;4;5].
Proof. reflexivity. Qed.
Example test_app2:             nil ++ [4;5] = [4;5].
Proof. reflexivity. Qed.
Example test_app3:             [1;2;3] ++ nil = [1;2;3].
Proof. reflexivity. Qed.






Definition hd (default : nat) (l : natlist) : nat :=
  match l with
  | nil => default
  | h :: t => h
  end.

Definition tl (l : natlist) : natlist :=
  match l with
  | nil => nil
  | h :: t => t
  end.

Example test_hd1:             hd 0 [1;2;3] = 1.
Proof. reflexivity. Qed.
Example test_hd2:             hd 0 [] = 0.
Proof. reflexivity. Qed.
Example test_tl:              tl [1;2;3] = [2;3].
Proof. reflexivity. Qed.






Fixpoint nonzeros (l:natlist) : natlist
  := match l with
     | nil    => nil
     | O :: t => nonzeros t
     | n :: t => n :: nonzeros t
     end.

Example test_nonzeros:
  nonzeros [0;1;0;2;3;0;0] = [1;2;3].
Proof. reflexivity. Qed.

Fixpoint oddmembers (l:natlist) : natlist
  := match l with
     | nil    => nil
     | n :: t => match odd n with
                | false => oddmembers t
                | true  => n :: oddmembers t
                end
     end.

Example test_oddmembers:
  oddmembers [0;1;0;2;3;0;0] = [1;3].
Proof. reflexivity. Qed.



Definition countoddmembers (l:natlist) : nat
  := length (oddmembers l).

Example test_countoddmembers1:
  countoddmembers [1;0;3;1;4;5] = 4.
Proof. reflexivity. Qed.

Example test_countoddmembers2:
  countoddmembers [0;2;4] = 0.
Proof. reflexivity. Qed.

Example test_countoddmembers3:
  countoddmembers nil = 0.
Proof. reflexivity. Qed.




Fixpoint alternate (l1 l2 : natlist) : natlist
  := match l1, l2 with
     | x1 :: l1', x2 :: l2' => x1 :: x2 :: alternate l1' l2'
     | l1, nil              => l1
     | nil, l2              => l2
     end.

Example test_alternate1:
  alternate [1;2;3] [4;5;6] = [1;4;2;5;3;6].
Proof. reflexivity. Qed.

Example test_alternate2:
  alternate [1] [4;5;6] = [1;4;5;6].
Proof. reflexivity. Qed.

Example test_alternate3:
  alternate [1;2;3] [4] = [1;4;2;3].
Proof. reflexivity. Qed.

Example test_alternate4:
  alternate [] [20;30] = [20;30].
Proof. reflexivity. Qed.







Definition bag := natlist.



Fixpoint count (v : nat) (s : bag) : nat
  := match s with
     | n :: s' => if v =? n then S (count v s') else count v s'
     | nil     => O
     end.





Lemma count_one_empty_list_1 : count 1 [ ] = 3.

Proof.
(* The theorem statement is false, so we cannot prove it.
*)
  (* The count function counts the number of occurrences of a given value in a list.
*)
  (* In the case of an empty list, the count of any value is 0, not 3.
*)
Abort.
```
Qed.

Lemma count_one_in_list_0 : count 1 [1; 2; 3; 1; 4; 1] = 3.

Proof.
(* We will use induction on the list to prove this lemma.
*)
  induction [1; 2; 3; 1; 4; 1] as [| n s IH]; intros.
- (* Base case: count 1 nil = 0 *)
    apply (@count_one_empty_list_1 ).
- (* Inductive case: count 1 (cons n s) *)
    (* We will split into two cases: n = 1 and n ≠ 1 *)
    destruct n as [| n']; rewrite IH; simpl.
- (* Case n = 1 *)
      rewrite Nat.add_comm; rewrite Nat.add_assoc; simpl.
(* Now we have count 1 s + 1 = count 1 s + 1 + count 1 s *)
      (* We will rewrite this to count 1 s + 1 = count 1 s + count 1 (cons 1 s) *)
      rewrite <- Nat.add_assoc; rewrite Nat.add_comm; reflexivity.
- (* Case n ≠ 1 *)
      (* Now we have count 1 s = count 1 s *)
      reflexivity.
Qed.

Example test_count1 : count 1 [1;2;3;1;4;1] = 3.

Proof.
(* We will use induction on the list s to prove the theorem.
*)
  apply (@count_one_in_list_0 ).
- simpl; reflexivity.
(* Inductive case: s = n :: s'.
*)
  - (* We will split into two cases: v = n and v ≠ n.
*)
    destruct (v =? n) eqn:E.
(* Case 1: v = n.
*)
    - (* We know that v = n, so count v (n :: s') = S (count v s').
*)
      simpl in E; rewrite E; reflexivity.
(* Case 2: v ≠ n.
*)
    - (* We know that v ≠ n, so count v (n :: s') = count v s'.
*)
      simpl in E; rewrite E; exact IHs'.
Qed.