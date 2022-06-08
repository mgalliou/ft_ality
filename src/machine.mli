type t = {
  alphabet : Move.t list list;
  bindings : Move.t list;
  states : State.t;
}

val generate_alphabet : Combo.t list -> Move.t list -> Move.t list list

val generate_states : Move.t list list -> Combo.t list -> Input_line.t -> State.t

val to_string : t -> string

