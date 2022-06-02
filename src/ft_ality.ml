let print_combo combos =
  print_endline "Combos:";
  List.iter (fun c -> print_endline (Combo.to_string c)) combos;
  print_endline "--------------------"

let rec bindings_to_string (bindings : Move.t list) i =
  let key = Sdlkeycode.to_string (List.nth bindings i).keycode in
  let move = (List.nth bindings i).name in
  String.lowercase_ascii key ^ " -> " ^ move ^ 
  if List.length bindings > i + 1 then
    "\n" ^ bindings_to_string bindings (i + 1)
  else
    ""

let print_key_mapping bindings =
  print_endline "Key mappings:";
  print_endline (bindings_to_string bindings 0);
  print_endline "--------------------"

let get_args () =
  "grammars/mk9.gmr"

let main () =
  try
  let args = get_args () in
  let bindings, combos = Parser.parse_grammar args in
  let _ = print_key_mapping bindings in
  let _ = print_combo combos in
  let machine = Machine.create bindings combos in
  let states = State.generate_all [] machine.alphabet combos in
  State.print_states states;
  Printf.printf "Starting state: %s\n" "test";
  let _ = print_endline (Machine.to_string machine) in
  let _ = Game.run machine in
  ()
  with
   | Sys_error str -> prerr_string str
   | Shared.Invalid_grammar str -> prerr_string str


let () = main ()
