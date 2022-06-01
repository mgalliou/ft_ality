type t = {
  input_line : string list;
  transitions: (string * t) list
}

let rec is_sublist (sublist: string list) (full_list: string list) =
  match (sublist, full_list) with
  | ([], _) -> true
  | (_, []) -> false
  | (sublist, full_list) when String.equal (List.hd sublist)  (List.hd full_list) ->
    is_sublist (List.tl sublist) (List.tl full_list)
  | _ -> false

let check_transition input_line (combos: Combo.t list) =
  List.exists (fun (a: Combo.t) -> is_sublist input_line (a.input)) combos

let idle = {
  input_line = [];
  transitions= []
}

let rec _new (input_line: string list) (alphabet: string list) (combos: Combo.t list) =
  {
    input_line = input_line;
    transitions = List.map (fun a ->
      let new_line = if input_line = [] then
        [a]
      else
        input_line@[a]
      in
      if check_transition new_line combos then
        a, (_new new_line alphabet combos)
      else
        a, idle
      ) alphabet
  }

let rec print_states (state: t ) =
  match state with
  | {input_line = []; transitions = []} ->
    Printf.printf "state:%s\n" "idle"
  | _ -> List.iter (fun (a, b)-> print_states b) state.transitions;
  Printf.printf "%s" "state: ";
  List.iter (Printf.printf "%s,") state.input_line;
  Printf.printf "\n"

let check_combo (combos: Combo.t list) input_line =
  List.find (fun (a:Combo.t) -> a.input = input_line) combos
