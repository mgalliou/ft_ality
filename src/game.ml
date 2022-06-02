let process_keydown_event (e : Sdlevent.keyboard_event) =
  (*
  match e.keycode |> Move.from_keycode with
  | Move.Unknown -> ()
  | _ -> print_endline ((Sdlkeycode.to_string e.keycode) ^ " " ^ (e.ke_state |> Sdlevent.string_of_state))
*)
 ()

let process_keyup_event (e : Sdlevent.keyboard_event) =
  (*
  match e.keycode |> Move.from_keycode with
  | Move.Unknown -> ()
  | _ -> print_endline ((Sdlkeycode.to_string e.keycode) ^ " " ^ (e.ke_state |> Sdlevent.string_of_state))
*)
 ()

let find_move_str (e: Sdlevent.keyboard_event) bindings =
  match List.find_opt (fun (b : Move.t) -> b.keycode = e.keycode) bindings with
  | Some b -> b.name
  | None -> ""

let match_event e (machine: Machine.t) (state : State.t) = 
  match e with
  | Sdlevent.Quit _ -> Sdl.quit (); exit 0;
  | Sdlevent.KeyUp e -> let move = find_move_str e machine.bindings in
    let _, new_state = List.find (fun (s, t) -> String.equal move s) state.transitions in
    new_state
  | _ -> state

let rec read_loop machine state = 
  match Sdlevent.poll_event () with
  | None -> (); read_loop machine state
  | Some e -> let new_state = match_event e machine state in
    let new_state = if new_state.input_line = [] then 
      machine.states
    else
      new_state
    in
    List.iter print_endline state.input_line;
    State.print_combos new_state;
    read_loop machine new_state

let run machine =
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let window, renderer = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  read_loop machine machine.states
