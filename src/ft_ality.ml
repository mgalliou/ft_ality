let rec bindings_to_string (bindings : Move.t list) i =
  Sdlkeycode.to_string (List.nth bindings i).keycode 
  ^ " -> " ^ (List.nth bindings i).name ^ "\n" ^
  if List.length bindings > i + 1 then
    bindings_to_string bindings (i + 1)
  else
    ""


let get_args () =
  "grammars/mk9.gmr"

let main () =
  let args = get_args () in
  let bindings, combos = Parser.parse_grammar args in
  let _ = print_endline (bindings_to_string bindings 0) in
  let machine = Machine.create bindings combos in
  let _ = Game.run machine in
  ()

let () = main ()
