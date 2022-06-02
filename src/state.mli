type t = {
  input_line : string list;
  transitions: (string * t) list;
  combos: Combo.t list;
}

val idle : t

val generate_all : string list -> Combo.t list -> string list -> t

val print_states : t -> unit

val print_combos : t -> unit
