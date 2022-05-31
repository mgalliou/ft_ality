type t = {
  name : string;
  input : Move.t list list
}

val _new : string -> Move.t list list -> t

val to_string : t -> string
