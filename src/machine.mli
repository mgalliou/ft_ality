type t = {
  alphabet : string list;
  bindings : Move.t list;
  states : State.t;
}

val create : Move.t list -> Combo.t list -> t

val to_string : t -> string
