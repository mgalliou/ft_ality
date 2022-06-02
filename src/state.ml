type t = {
  input_line : string list;
  transitions: (string * t) list;
  combos: Combo.t list;
}

let idle = {
  input_line = [];
  transitions = [];
  combos = []
}

let check_transition input_line (combos: Combo.t list) =
  let rec is_sublist (sublist: string list) (full_list: string list) =
    match (sublist, full_list) with
    | ([], _) -> true
    | (_, []) -> false
    | (sublist, full_list) when String.equal (List.hd sublist) (List.hd full_list) ->
        is_sublist (List.tl sublist) (List.tl full_list)
    | _ -> false
  in
  List.exists (fun (a: Combo.t) -> is_sublist input_line (a.input)) combos

let get_combos input_line combos =
  let l = List.filter (fun (c : Combo.t) -> List.equal (String.equal) c.input input_line) combos in
  List.iter print_string input_line;
  print_string " -> \n";
  List.iter (fun c -> print_endline (Combo.to_string c)) l;
  l

let rec generate_all (alphabet: string list) (combos: Combo.t list) (input_line: string list) =
  let list_transitions a =
    let new_line = match input_line with
    | [] -> [a]
    | _ -> input_line@[a]
    in
    match check_transition new_line combos with
    | true -> a, (generate_all alphabet combos new_line)
    | false -> a, idle
  in
  {
    input_line = input_line;
    transitions = List.map (list_transitions) alphabet;
    combos = get_combos input_line combos
  }

let rec print_states (state: t ) =
  match state with
  | {input_line = []; transitions = []} -> Printf.printf "state:%s\n" "idle"
  | _ -> List.iter (fun (a, b) -> print_states b) state.transitions;
  Printf.printf "%s" "state: ";
  List.iter (Printf.printf "%s,") state.input_line;
  Printf.printf "\n"

let print_combos s =
  List.iter (fun c -> print_endline (Combo.to_string c)) s.combos
