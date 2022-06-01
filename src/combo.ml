type t = {
  name : string;
  input : string list
}

let _new name input = {
  name = name;
  input = input
}

let rec comb_to_string (comb: string list) j =
  (List.nth comb j) ^ if List.length comb > j + 1 then
    "+" ^ comb_to_string comb (j + 1)
  else
    ""

let rec input_to_string (input : string list) i =
  (List.nth input i) ^ if List.length input > i + 1 then
    "," ^ input_to_string input (i + 1)
  else
    ""

let to_string m =
  m.name ^ ": " ^ input_to_string m.input 0


