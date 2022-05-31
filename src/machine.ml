type t = {
  alphabet : Move.t list;
  states : State.t list;
  start : State.t;
  regoc : State.t list
}

let gen_states alphabet combos =
  []

let gen_recog_states combos =
  let combo_to_state (c : Combo.t) : State.t = {
    name = c.name;
    combo = c
  } in
  List.map combo_to_state combos

let create bindings combos = 
  {
    alphabet = bindings;
    states = [];
    start =  State.idle;
    regoc = gen_recog_states combos
  }

(*
let to_string t = 
  let rec alphabet_to_string alphabet i =
    (List.nth alphabet i).move ^ "," ^ alphabet_to_string alphabet i + 1
  sprintf "alphabet: %s\nstates: %s\n start: %s\n regoc: %s"
  alphabet_to_string
  states
  start
  recog
*)
