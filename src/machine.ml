type t = {
  alphabet : Move.t list list;
  bindings : Move.t list;
  states : State.t;
}

let check_transition input_line (combos: Combo.t list) =
  List.exists (fun (a: Combo.t) -> Input_line.is_subline input_line (a.input)) combos


(** return  combos (combo list) with corresponding input_line from a combo list **)
let combos_with_input_line (input_line: Input_line.t) combos =
  let l = List.filter (fun (c : Combo.t) -> Input_line.equal c.input input_line) combos in
  l

let rec generate_states (input_line: Input_line.t) (alphabet: Move.t list list) (combos: Combo.t list)  =
  let list_transitions (a: Move.t list) =
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

let generate_alphabet bindings combos =
    let filter_input_line input_line =
        List.filter (fun a -> List.length a > 1) input_line
    in
    let combos_with_key_comb = List.map (fun (a : Combo.t) -> filter_input_line a.input ) combos in
    let combos_with_key_comb = List.filter (fun a -> List.length a > 0) combos_with_key_comb in
    let extend_alphabet = List.flatten combos_with_key_comb in
    let extend_alphabet = List.sort_uniq (fun a b -> if Move.list_equal a b then 0 else 1) extend_alphabet in
    (List.map (fun (a : Move.t ) -> [a]) bindings)@extend_alphabet

let create bindings combos =
  let alphabet = generate_alphabet bindings combos in
  let states = generate_states [] alphabet combos in
  {
    alphabet = alphabet;
    bindings = bindings;
    states = states;
  }

let to_string m =
  let rec alphabet_to_string = function
    | [] -> ""
    | h::t -> Move.list_to_string h
              ^ (if List.length t > 0 then ", " else "")
              ^ (alphabet_to_string t)
  in
  "alphabet: " ^ (alphabet_to_string m.alphabet)
