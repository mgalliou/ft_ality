type t = {
  alphabet : Move.t list list;
  bindings : Move.t list;
  states : State.t;
}

val generate_states : Input_line.t -> Move.t list list -> Combo.t list -> State.t

val create : Move.t list -> Combo.t list -> t

(*val to_string : t -> string*)
