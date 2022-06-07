let split_on_semicolon = String.split_on_char ';'

let get_lines str =
  List.filter (fun a -> not(String.equal "" a)) (String.split_on_char '\n' str)

  (** might throw exception Failure("nth") if no ";" on one line **)
let get_bindings bindings =
  let split_move str =
    let l = split_on_semicolon str in
    Move._new (List.nth l 1) (List.hd l)
    in
  List.map split_move (bindings |> get_lines)

  (** might throw exception Failure("nth") if no ";" on one line **)
let get_combos combos bindings =
  let move_map str =
      List.map (fun a -> Move._new a (Sdlkeycode.to_string (Move.get_key a bindings))) (String.split_on_char '+' str)
  in
  let split_moves str =
    String.split_on_char ',' str
  in
  let split_combos str =
    let tmp = split_on_semicolon str in
    Combo._new (tmp |> List.hd) (List.map move_map (split_moves (List.nth tmp 1)))
  in
  List.map split_combos (combos |> get_lines)

  (**might throw exception Failure("nth") if no "|" in grammar**)
let split_grammar str =
  let tmp = String.split_on_char '|' str in
  (tmp |> List.hd, List.nth tmp 1)

  (** might throw exception Sys_error if file does not exist**)
let get_file file =
  let in_ch = open_in file in
  let s = really_input_string in_ch (in_channel_length in_ch) in
  close_in in_ch;
  s

let parse_grammar grammar_file =
  try
    let ( bindings, combos) = split_grammar (get_file grammar_file) in
    let bindings = get_bindings bindings in
    let combos = get_combos combos bindings in
    bindings, combos
  with
  | Failure(msg) -> raise (Shared.Invalid_grammar "Bad formating in grammar file")
