let get_bindings bindings =
  List.map (fun a ->
    let l = String.split_on_char ';' a in
    Move._new (List.nth l 1) (List.hd l)
  ) (List.filter (fun a -> not(String.equal a "")) (String.split_on_char '\n' bindings))

let get_combos combos bindings =
  let split_moves str =
    List.map (fun b -> List.map (Move.get_move bindings) (String.split_on_char '+' b))(String.split_on_char ',' str)
  in
  let split_combos str =
    let tmp = String.split_on_char ';' str in
    Combo._new (tmp |> List.hd) (split_moves (List.nth tmp 1))
  in
  List.map split_combos (List.filter (fun a -> not(String.equal a "")) (String.split_on_char '\n' combos))

let split_grammar s =
  let l = String.split_on_char '/' s in
  let bindings = l |> List.hd in
  let combos = List.nth l 1 in
  bindings, combos

let get_file file =
  let in_ch = open_in file in
  let s = really_input_string in_ch (in_channel_length in_ch) in
  close_in in_ch;
  s

let parse_grammar grammar_file =
  let ( bindings, combos) = split_grammar (get_file grammar_file) in
  let bindings = get_bindings bindings in
  let combos = get_combos combos bindings in
  bindings, combos

