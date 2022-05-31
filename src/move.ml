type t = {
  name : string;
  keycode : Sdlkeycode.t
}

let _new name key_str =
{
  name = name;
  keycode = Sdlkeycode.of_string key_str
}

let get_key str bindings =
  let move = List.find (fun a -> String.equal a.name str) bindings in
  move.keycode

let get_move bindings str =
  List.find (fun a -> String.equal a.name str) bindings
