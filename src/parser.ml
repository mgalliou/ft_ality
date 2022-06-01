exception Invalid_grammar of string

let split_on_semicolon = String.split_on_char ';'

let get_lines str =
  List.filter (fun a -> not(String.equal "" a)) (String.split_on_char '\n' str)

let get_bindings bindings =
  let split_move str =
    let l = split_on_semicolon str in
    Move._new (List.nth l 1) (List.hd l)
    in
  List.map split_move (bindings |> get_lines)

let get_combos combos bindings =
  let move_map str =
    List.map (Move.get_move bindings) (String.split_on_char '+' str)
  in
  let split_moves str =
    List.map move_map (String.split_on_char ',' str)
  in
  let split_combos str =
    let tmp = split_on_semicolon str in
    Combo._new (tmp |> List.hd) (split_moves (List.nth tmp 1))
  in
  List.map split_combos (combos |> get_lines)

let split_grammar str =
  let tmp = String.split_on_char '|' str in
  (tmp |> List.hd, List.nth tmp 1)

let get_file file =
  let in_ch = open_in file in
  let s = really_input_string in_ch (in_channel_length in_ch) in
  close_in in_ch;
  s

let parse_grammar grammar_file =
  let ( bindings, combos) = try split_grammar (get_file grammar_file) with
   | Sys_error str -> raise (Invalid_grammar (str ^ " in " ^ grammar_file))
  in
  let bindings = try get_bindings bindings with
   | Sys_error str -> raise (Invalid_grammar (str ^ " in " ^ grammar_file))
  in
  let combos = get_combos combos bindings in
  bindings, combos
