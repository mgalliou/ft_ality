type t = {
  alphabet : Move.t list;
  states : State.t list;
  start : State.t;
  regoc : State.t list
}

val create : Move.t list -> Combo.t list -> t
