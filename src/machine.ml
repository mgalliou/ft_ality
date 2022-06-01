type t = {
  alphabet : string list;
  states : State.t list;
  start : State.t;
  regoc : State.t list
}

(*let gen_states alphabet combos =
  let states = List.map (fun i -> if State._new [i]) alphabet in
      states

let gen_recog_states combos =
  []

let gen_start_state alphabet combos = 
  let start = {
    input_line = [];
    to_states = List.map (fun i -> 
        (i, State._new [i])
*)


let create bindings combos = 
  let alphabet = List.map (fun (a : Move.t ) -> a.name) bindings in
(*  let start_state = gen_start_state alphabet combos in *)
  (*let states = gen_states alphabet combos in*)
  {
    alphabet = alphabet;
    states = [];
    start =  State.idle;
    regoc = []
  }

let to_string m = 
  let rec alphabet_to_string a i =
    (List.nth a i) ^ if List.length a > i + 1  then
      "," ^ alphabet_to_string a (i + 1)
    else
      ""
  in
  "alphabet: " ^ (alphabet_to_string m.alphabet 0)
