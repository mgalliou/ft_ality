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

let match_event e bindings =
  match e with
  | Sdlevent.Quit _ -> Sdl.quit (); exit 0;
  | Sdlevent.KeyUp e -> find_move_str e bindings
  | _ -> ""

let get_next_state input_str states_root (state: State.t) =
  match input_str with
  | "" -> state
  | _ ->
    match List.find (fun (s, t) -> String.equal input_str s) state.transitions with
    | ("", _) -> states_root
    | (_, idle) when idle.input_line = [] -> states_root
    | (input_str, to_state) -> to_state

let run (machine: Machine.t) =
  let rec read_loop state =
    match Sdlevent.poll_event () with
    | None -> (); read_loop state
    | Some e ->
      let input_str = match_event e machine.bindings in
      let new_state = get_next_state input_str machine.states state in
      List.iter print_endline state.input_line;
      State.print_combos new_state;
      read_loop new_state
  in
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let window, renderer = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  read_loop machine.states
