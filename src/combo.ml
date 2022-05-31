type t = {
  name : string;
  input : Move.t list list
}

let _new name input =
  {
    name = name;
    input = input
  }
