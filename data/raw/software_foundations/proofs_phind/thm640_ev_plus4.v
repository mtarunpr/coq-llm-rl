

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
  apply ev_SS. apply ev_SS. apply ev_0. Qed.



Print ev_4.




Check (ev_SS 2 (ev_SS 0 ev_0))
  : ev 4.





Theorem ev_4': ev 4.
Proof.
  apply (ev_SS 2 (ev_SS 0 ev_0)).
Qed.






Theorem ev_4'' : ev 4.
Proof.
  Show Proof.
  apply ev_SS.
  Show Proof.
  apply ev_SS.
  Show Proof.
  apply ev_0.
  Show Proof.
Qed.





Definition ev_4''' : ev 4 :=
  ev_SS 2 (ev_SS 0 ev_0).



Print ev_4.

Print ev_4'.

Print ev_4''.

Print ev_4'''.




Theorem ev_8 : ev 8.
Proof.
  apply ev_SS.
  apply ev_SS.
  apply ev_SS.
  apply ev_SS.
  apply ev_0.
Qed.

Definition ev_8' : ev 8
  := ev_SS 6 (ev_SS 4 (ev_SS 2 (ev_SS 0 ev_0))).











Theorem ev_plus4 : forall n, ev n -> ev (4 + n).

Proof.
(* The goal is to prove that for any natural number n, if n is even, then 4 + n is also even.
*)
  (* We will proceed by induction on n.
*)
  intros n Hn.
induction Hn as [| n' Hn' IHn'].
(* Base case: n = 0 *)
  - (* We know that ev 0 holds, so we need to prove ev 4.
We have this definition: *)
    exact ev_4'''.
(* Inductive case: n = S (S n') and ev (S (S n')) holds.
We need to prove ev (4 + S (S n')).
*)
  (* By definition of ev, we know that ev (S (S n')) = ev_SS n' (ev n').
*)
  (* We will use the induction hypothesis IHn' on (ev n').
*)
  - (* We have ev (S (S n')), and we need to prove ev (4 + S (S n')).
*)
    (* We know that 4 + S (S n') = S (S (S (S n'))) by Peano arithmetic.
*)
    (* We also know that ev (S (S n')) = ev_SS n' (ev n').
*)
    (* By the induction hypothesis IHn', we have ev (4 + n').
*)
    (* Therefore, we have ev_SS n' (ev (4 + n')).
*)
    (* By definition of ev_SS, we have ev (S (S (S (S n')))).
*)
    (* This proves the theorem for the inductive case.
*)
    apply ev_SS; assumption.
Qed.