type t = {
  name : string;
  input : Input_line.t
}

let _new name input = {
  name = name;
  input = input
}

let to_string m =
  m.name ^ ": " ^ Input_line.to_string m.input
