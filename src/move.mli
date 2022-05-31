type t = 
  | Left 
  | Right 
  | Up 
  | Down 
  | Front_Punch 
  | Back_Punch 
  | Front_Kick 
  | Back_Kick
  | Throw
  | Tag
  | Flip_Stance
  | Unknown

val to_string : t -> string

val from_string : string -> t

val to_keycode : t -> Sdlkeycode.t

val from_keycode : Sdlkeycode.t -> t
