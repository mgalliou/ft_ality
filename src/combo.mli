type t = {
  name : string;
  input : string list 
}

val _new : string -> string list -> t

val to_string : t -> string
