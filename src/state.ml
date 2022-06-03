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

let rec print_input_line = function
    | [] -> print_endline ""
    | h::t -> print_string h ; print_string ", " ; print_input_line t

let rec print_states (state: t ) =
  match state with
  | {input_line = []; transitions = []} -> Printf.printf "state:%s\n" "idle"
  | _ -> List.iter (fun (a, b) -> print_states b) state.transitions;
  Printf.printf "%s" "state: ";
  List.iter (Printf.printf "%s,") state.input_line;
  Printf.printf "\n"

let print_combos s =
  List.iter (fun c -> print_endline (Combo.to_string c)) s.combos
