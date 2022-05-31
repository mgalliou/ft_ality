type t = {
  name : string;
  keycode : Sdlkeycode.t
}

let _new name key_str =
{
  name = name;
  keycode = Sdlkeycode.of_string key_str
}

