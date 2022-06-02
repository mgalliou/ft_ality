type t = {
  input_line : string list;
  transitions: (string * t) list;
  combos: Combo.t list;
}

val idle : t

val generate_all : string list -> string list -> Combo.t list -> t

val print_states :  t -> unit

val print_combos : t -> unit
