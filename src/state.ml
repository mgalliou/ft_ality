type t = {
  input_line : Input_line.t;
  transitions: (Move.t list * t) list;
  combos: Combo.t list;
}

let idle = {
  input_line = [];
  transitions = [];
  combos = []
}

let rec print_states (state: t ) =
  match state with
  | {input_line = []; transitions = []} -> Printf.printf "state:%s\n" "idle"
  | _ -> List.iter (fun (a, b) -> print_states b) state.transitions;
  Printf.printf "%s" "state: ";
  print_string (Input_line.to_string state.input_line);
  print_newline ()

let print_combos s =
    List.iter (fun (c: Combo.t) -> print_endline (c.name ^ " !!")) s.combos;
    print_newline ()
