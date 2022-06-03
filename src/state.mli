type t = {
  input_line : string list;
  transitions: (string * t) list;
  combos: Combo.t list;
}

val idle : t

val print_input_line : string list -> unit

val print_states : t -> unit

val print_combos : t -> unit
