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
    let usage_msg = "usage: ft_ality [-h] grammarfile" in
    let input_strs = ref [] in
    let help = ref false in
    let speclist = [
        ("grammarfile", Arg.Set (ref false) , "\t\tgrammar of the game\n");
        ("-h, --help", Arg.Set (ref false), "\t\tshow this help message and exit\n");
        ("-h", Arg.Set help, "");
        ("--help", Arg.Set help, "");
        ("-help", Arg.Set (ref false), "")
    ] in
    let anon_fun filename = input_strs := !input_strs@[filename]  in
    let () = Arg.parse speclist anon_fun usage_msg in
    let grammarfile = List.nth_opt !input_strs 0 in
    if !help || Option.is_none grammarfile then
        raise (Arg.Help (Arg.usage_string speclist usage_msg));
    List.nth !input_strs 0

let main () =
  try
  let args = get_args () in
  let bindings, combos = Parser.parse_grammar args in
  let _ = print_key_mapping bindings in
  let _ = print_combo combos in
  let machine = Machine.create bindings combos in
  let _ = print_endline (Machine.to_string machine) in
  let _ = Game.run machine in
  ()
  with
   | Arg.Help e -> print_string e
   | Sys_error str -> prerr_endline str
   | Shared.Invalid_grammar str -> prerr_endline str


let () = main ()
