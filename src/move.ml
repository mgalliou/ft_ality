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

let to_string move =
  match move with
  | Left -> "Left"
  | Right -> "Right"
  | Up -> "Up"
  | Down -> "Down"
  | Front_Punch -> "[FP]"
  | Back_Punch -> "[BP]"
  | Front_Kick -> "[FK]"
  | Back_Kick -> "[BK]"
  | Throw -> "Throw"
  | Tag -> "Tag"
  | Flip_Stance -> "Flip Stance"
  
let from_string move =
  match move with
  | "Left" -> Left
  | "Right" -> Right
  | "Up" -> Up
  | "Down" -> Down
  | "[FP]" -> Front_Punch
  | "[BP]" -> Back_Punch
  | "[FK]" -> Front_Kick
  | "[BK]" -> Back_Kick
  | "Throw" -> Throw
  | "Tag" -> Tag
  | "Flip Stance" -> Flip_Stance

let key_from_move move =
  match move with
  | Left -> Sdlkeycode.Left
  | Right -> Sdlkeycode.Right
  | Up -> Sdlkeycode.Up
  | Down -> Sdlkeycode.Down
  | Front_Punch -> Sdlkeycode.X
  | Back_Punch -> Sdlkeycode.D
  | Front_Kick -> Sdlkeycode.Z
  | Back_Kick -> Sdlkeycode.S
  | Throw -> Sdlkeycode.A
  | Tag -> Sdlkeycode.E
  | Flip_Stance -> Sdlkeycode.W
