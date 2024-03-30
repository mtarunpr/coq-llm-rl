

Set Warnings "-notation-overridden,-parsing,-deprecated-hint-without-locality".
From LF Require Export IndProp.









Inductive ev : nat -> Prop :=
  | ev_0                       : ev 0
  | ev_SS (n : nat) (H : ev n) : ev (S (S n)).







Check ev_SS
  : forall n,
    ev n ->
    ev (S (S n)).







Theorem ev_4 : ev 4.

Proof.
(* We will use the constructor for ev_SS to build the proof.
We need to show that ev (S (S 2)) holds.
*)
  apply ev_SS.
(* We now need to show that ev 2 holds.
We will use the constructor for ev_SS again to build the proof.
We need to show that ev (S 1) holds.
*)
  apply ev_SS.
(* We now need to show that ev 1 holds.
We will use the constructor for ev_SS again to build the proof.
We need to show that ev 0 holds.
*)
  apply ev_0.
(* All subgoals are now proven.
*)

Qed.