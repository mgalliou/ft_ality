let split_on_semicolon = String.split_on_char ';'

let list_to_tuple l =
    (l |> List.hd, l |> List.tl |> List.hd)

let get_lines str =
  List.filter (fun a -> not(String.equal "" a)) (String.split_on_char '\n' str)

  (** might throw exception Failure("nth") if no ";" on one line **)
let get_bindings bindings =
  let split_move str =
    str |> split_on_semicolon |> list_to_tuple |> Move._new
  in
  bindings |> get_lines |> List.map split_move

  (** might throw exception Failure("nth") if no ";" on one line **)
let get_combos combos bindings =
  let get_move str =
    Move._new (Sdlkeycode.to_string (Move.get_key str bindings), str)
  in
  let move_map str =
      List.map get_move (String.split_on_char '+' str)
  in
  let split_combos str =
    let (name, moves) =  str |> split_on_semicolon |> list_to_tuple in
    Combo._new name (moves |> String.split_on_char ',' |> List.map move_map )
  in
  combos |> get_lines |> List.map split_combos

  (** might throw exception Sys_error if file does not exist**)
let get_content file =
  let in_ch = open_in file in
  let s = really_input_string in_ch (in_channel_length in_ch) in
  close_in in_ch;
  s

let parse_grammar grammar_file =
  try
    let (bindings, combos) = grammar_file
        |> get_content
        |> String.split_on_char '|'
        |> list_to_tuple
    in
    let bindings = get_bindings bindings in
    let combos = get_combos combos bindings in
    bindings, combos
  with
  | Failure(msg) -> raise (Shared.Invalid_grammar "Bad formating in grammar file")
