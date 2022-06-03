type t = {
  alphabet : string list;
  bindings : Move.t list;
  states : State.t;
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


(** return  combos (combo list) with corresponding input_line from a combo list **)
let combos_with_input_line input_line combos =
  let l = List.filter (fun (c : Combo.t) -> List.equal (String.equal) c.input input_line) combos in
  l

let rec generate_states (input_line: string list) (alphabet: string list) (combos: Combo.t list)  =
  let list_transitions a =
    let new_line = match input_line with
    | [] -> [a]
    | _ -> input_line@[a]
    in
    match check_transition new_line combos with
    | true -> a, (generate_states new_line alphabet combos)
    | false -> a, State.idle
  in
  {
    input_line = input_line;
    transitions = List.map (list_transitions) alphabet;
    combos = combos_with_input_line input_line combos
  }

let create bindings combos = 
  let alphabet = List.map (fun (a : Move.t ) -> a.name) bindings in
  let states = generate_states [] alphabet combos in
  {
    alphabet = alphabet;
    bindings = bindings;
    states = states;
  }

let to_string m = 
  let rec alphabet_to_string a i =
    (List.nth a i) ^ if List.length a > i + 1  then
      "," ^ alphabet_to_string a (i + 1)
    else
      ""
  in
  "alphabet: " ^ (alphabet_to_string m.alphabet 0)
