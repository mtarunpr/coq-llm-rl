




Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From LF Require Export Lists.











Inductive boollist : Type :=
  | bool_nil
  | bool_cons (b : bool) (l : boollist).





Inductive list (X:Type) : Type :=
  | nil
  | cons (x : X) (l : list X).



Check list : Type -> Type.



Check (nil nat) : list nat.



Check (cons nat 3 (nil nat)) : list nat.



Check nil : forall X : Type, list X.



Check cons : forall X : Type, X -> list X -> list X.





Check (cons nat 2 (cons nat 1 (nil nat)))
      : list nat.



Fixpoint repeat (X : Type) (x : X) (count : nat) : list X :=
  match count with
  | 0 => nil X
  | S count' => cons X x (repeat X x count')
  end.



Example test_repeat1 :
  repeat nat 4 2 = cons nat 4 (cons nat 4 (nil nat)).
Proof. reflexivity. Qed.



Example test_repeat2 :
  repeat bool false 1 = cons bool false (nil bool).
Proof. reflexivity. Qed.



Module MumbleGrumble.

Inductive mumble : Type :=
  | a
  | b (x : mumble) (y : nat)
  | c.

Inductive grumble (X:Type) : Type :=
  | d (m : mumble)
  | e (x : X).


Eval compute in d mumble (b a 5).
Eval compute in d bool (b a 5).
Eval compute in e bool true.
Eval compute in e mumble (b c 0).
End MumbleGrumble.







Fixpoint repeat' X x count : list X :=
  match count with
  | 0        => nil X
  | S count' => cons X x (repeat' X x count')
  end.



Check repeat'
  : forall X : Type, X -> nat -> list X.
Check repeat
  : forall X : Type, X -> nat -> list X.








Fixpoint repeat'' X x count : list X :=
  match count with
  | 0        => nil _
  | S count' => cons _ x (repeat'' _ x count')
  end.



Definition list123 :=
  cons nat 1 (cons nat 2 (cons nat 3 (nil nat))).



Definition list123' :=
  cons _ 1 (cons _ 2 (cons _ 3 (nil _))).






Arguments nil {X}.
Arguments cons {X}.
Arguments repeat {X}.



Definition list123'' := cons 1 (cons 2 (cons 3 nil)).



Fixpoint repeat''' {X : Type} (x : X) (count : nat) : list X :=
  match count with
  | 0        => nil
  | S count' => cons x (repeat''' x count')
  end.



Inductive list' {X:Type} : Type :=
  | nil'
  | cons' (x : X) (l : list').





Fixpoint app {X : Type} (l1 l2 : list X) : list X :=
  match l1 with
  | nil      => l2
  | cons h t => cons h (app t l2)
  end.

Fixpoint rev {X:Type} (l:list X) : list X :=
  match l with
  | nil      => nil
  | cons h t => app (rev t) (cons h nil)
  end.

Fixpoint length {X : Type} (l : list X) : nat :=
  match l with
  | nil => 0
  | cons _ l' => S (length l')
  end.

Example test_rev1 :
  rev (cons 1 (cons 2 nil)) = (cons 2 (cons 1 nil)).
Proof. reflexivity. Qed.

Example test_rev2:
  rev (cons true nil) = cons true nil.
Proof. reflexivity. Qed.

Example test_length1: length (cons 1 (cons 2 (cons 3 nil))) = 3.
Proof. reflexivity. Qed.






Fail Definition mynil := nil.



Definition mynil : list nat := nil.



Check @nil : forall X : Type, list X.

Definition mynil' := @nil nat.



Notation "x :: y" := (cons x y)
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y []) ..).
Notation "x ++ y" := (app x y)
                     (at level 60, right associativity).



Definition list123''' := [1; 2; 3].






Theorem app_nil_r : forall (X:Type), forall l:list X,
  l ++ [] = l.
Proof.
  intros X.
  induction l as [| n l'].
  - reflexivity.
  - simpl. rewrite -> IHl'.
    reflexivity.
Qed.



Lemma append_nil_associativity_0 : forall A : Type, forall l m : list A, l ++ m ++ [ ] = (l ++ m) ++ [ ].

Proof.
intros A l m.
induction l as [|x l' IHl'].
- (* l = nil *)
    reflexivity.
- (* l = cons x l' *)
    simpl.
rewrite IHl'.
reflexivity.
Qed.

Theorem app_assoc : forall A (l m n:list A),
  l ++ m ++ n = (l ++ m) ++ n.

Proof.
(* We will proceed by induction on the list n.
*)
  intros A l m n.
induction n as [| n' hn'].
(* Base case: n = nil *)
  - simpl.
apply (@append_nil_associativity_0 A l m).
- simpl.
(* We will now use the associativity of appending lists.
*)
    rewrite -> IHn'.
(* The goal is now l ++ m ++ cons a n' = (l ++ m) ++ cons a n'.
*)
    (* By the definition of appending lists, this is true.
*)
    reflexivity.
Qed.