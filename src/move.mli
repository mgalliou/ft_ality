type t = {
  name : string;
  keycode : Sdlkeycode.t
}

val get_key : string -> t list -> Sdlkeycode.t

val get_move : t list -> string -> t

val _new : string -> string -> t
