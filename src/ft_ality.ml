let get_args () =
 "args"

let main () =
  let args = get_args () in
  let combos = Parser.parse_grammar args in
  let machine = Machine.create combos in
  let _ = Game.run machine in
  ()

let () = main ()
