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

let to_string m = 
  let rec alphabet_to_string (a : Move.t list) i =
    (List.nth a i).name ^ if List.length a > i + 1  then
      "," ^ alphabet_to_string a (i + 1)
    else
      ""
  in
  "alphabet: " ^ alphabet_to_string m.alphabet 0
