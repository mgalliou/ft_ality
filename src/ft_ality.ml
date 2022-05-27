let width, height = (0, 0)

let match_event = function
  | e -> print_endline (e |> Sdlevent.to_string)

let rec key_loop () = 
  match Sdlevent.poll_event () with
  | None -> (); key_loop()
  | Some e -> match_event e; key_loop ()

let main () =
  Sdl.init_subsystem [`VIDEO];
  let window, renderer = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  key_loop ()

let _ = main ();
