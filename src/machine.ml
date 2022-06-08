type t = {
  alphabet : Move.t list list;
  bindings : Move.t list;
  states : State.t;
}

let generate_alphabet combos bindings =
  (bindings |> List.map (fun (a : Move.t ) -> [a]))
      @(combos
      |> List.map (fun (b: Combo.t) -> b.input |> List.filter (fun a -> List.length a > 1) )
      |> List.filter (fun a -> List.length a > 0)
      |> List.flatten
      |> List.sort_uniq (fun a b -> if Move.list_equal a b then 0 else 1)
    )

let rec generate_states alphabet combos (input_line: Input_line.t) =
  let list_transitions (a: Move.t list) =
    (* check if input line exist as a subcombo *)
    match combos |> List.exists (fun (a : Combo.t) ->
      a.input |> Input_line.is_subline input_line )
    with
        | false -> a, State.idle
        | true -> a, (generate_states alphabet combos (match input_line with
            | [] -> [a]
            | _ -> input_line@[a]
          )
        )
  in
    {
      input_line = input_line;
      transitions = List.map (list_transitions) alphabet;
      (** return  combos (combo list) with corresponding input_line from a combo list **)
      combos = combos |> List.filter (fun (c : Combo.t) -> c.input |> Input_line.equal input_line)
    }


let to_string m =
  let rec alphabet_to_string = function
    | [] -> ""
    | h::t -> Move.list_to_string h
              ^ (if List.length t > 0 then ", " else "")
              ^ (alphabet_to_string t)
  in
  "alphabet: " ^ (alphabet_to_string m.alphabet)
