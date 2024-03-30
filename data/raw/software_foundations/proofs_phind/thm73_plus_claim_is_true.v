

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





Theorem plus_claim_is_true : plus_claim.

Proof.
(* We will use the reflexivity tactic to prove this theorem.
*)
  (* The reflexivity tactic is used when the goal is to prove that *)
  (* a term is equal to itself.
In this case, we need to prove that *)
  (* 2 + 2 is equal to 2 + 2, which is trivially true by reflexivity.
*)
  reflexivity.
Qed.