type t = {
  name : string;
  input : Move.t list list
}

let _new name input = {
  name = name;
  input = input
}

let rec comb_to_string (comb: Move.t list) j =
  (List.nth comb j).name ^ if List.length comb > j + 1 then
    "+" ^ comb_to_string comb (j + 1)
  else
    "" 

let rec input_to_string (input : Move.t list list) i =
  comb_to_string (List.nth input i) 0 ^ if List.length input > i + 1 then
    "," ^ input_to_string input (i + 1)
  else
    ""

let to_string m =
  m.name ^ ": " ^ input_to_string m.input 0


