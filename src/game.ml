
let process_keydown_event e =
  match Sdlkeycode.keycode |> Move.from_keycode
  | Move.Unkown -> ();
  | _ -> 
  (*debug)
  print_endline ((Sdlkeycode.to_string e.keycode) ^ " " ^ (e.ke_state |> Sdlevent.string_of_state))
  *)

let process_keyup_event e =
  (*debug)
  print_endline ((Sdlkeycode.to_string e.keycode) ^ " " ^ (e.ke_state |> Sdlevent.string_of_state))
  *)
  ()

let match_event = function
  | Sdlevent.Quit _ -> Sdl.quit (); exit 0;
  | Sdlevent.KeyDown e -> process_keydown_event e
  | Sdlevent.KeyUp e -> process_keyup_event e
  | e -> ()

let rec key_loop () = 
  match Sdlevent.poll_event () with
  | None -> (); key_loop()
  | Some e -> match_event e; key_loop ()

let read_user_input () =
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let window, renderer = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  key_loop ()

let run machine =
  read_user_input ()
