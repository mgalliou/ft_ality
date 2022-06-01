type t = {
  name : string;
  keycode : Sdlkeycode.t
}

let _new name key_str =
  if name = "" then
    raise (Shared.Invalid_grammar ("Key name cannot be empty"))
  else
    let keycode = Sdlkeycode.of_string key_str in
    if keycode = Sdlkeycode.Unknown then
      raise (Shared.Invalid_grammar ("Unknown key: " ^ key_str))
    else
      { name = name; keycode = keycode }

let get_key str bindings =
  let move = try List.find (fun a -> String.equal a.name str) bindings with

      | Not_found -> raise (Shared.Invalid_grammar ("key not found in grammar: " ^ str))
  in
  move.keycode

let get_move bindings str =
  try List.find (fun a -> String.equal a.name str) bindings with
    | Not_found -> raise (Shared.Invalid_grammar ("key not found in grammar: " ^ str))
