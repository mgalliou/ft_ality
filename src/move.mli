type t = {
  name : string;
  keycode : Sdlkeycode.t
}

val _new : string * string -> t

val get_key : string -> t list -> Sdlkeycode.t

val get_move : t list -> string -> t

val equal :t -> t -> bool

val list_equal : t list -> t list -> bool

val list_to_string : t list -> string
