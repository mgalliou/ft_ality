type t = Move.t list list

val to_string : t -> string

val is_subline : t -> t -> bool

val equal : t -> t -> bool
