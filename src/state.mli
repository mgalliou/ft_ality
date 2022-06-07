type t = {
  input_line : Input_line.t;
  transitions: (Move.t list * t) list;
  combos: Combo.t list;
}

val idle : t

val print_states : t -> unit

val print_combos : t -> unit
