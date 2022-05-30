let read_lines file process =
  let in_ch = open_in file in
  let rec read_line () =
    let line = try input_line in_ch with End_of_file -> "" in
    process line;
    read_line ()
    in
  read_line ()

let parse_grammar grammar_file =
  let combos = [] in
  combos
