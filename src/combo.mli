type t = {
  name : string;
  input : Input_line.t
}

val _new : string -> Input_line.t -> t

val to_string : t -> string

