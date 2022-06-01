type t = {
  input_line : string list;
}

let idle = {
  input_line = [];
  to_states = []
}

let _new input_line =
  {
    input_line = input_line;
        to_states = []
  }
