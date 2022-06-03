let rec new_state_with_input_str input (current_state : State.t) (machine : Machine.t) =
    match List.find_opt (fun (s, t) -> String.equal input s) current_state.transitions with
      | None -> current_state, current_state
      | Some (s, t) -> match (s,t) with
        | (_, state) when state.input_line = [] && current_state.input_line = [] ->
          current_state, machine.states
        | (_, state) when state.input_line = [] -> 
          new_state_with_input_str input machine.states machine
        | (input_str, to_state) ->
          current_state, to_state

let input_str_from_key_event (e : Sdlevent.keyboard_event) bindings =
  match List.find_opt (fun (b : Move.t) -> b.keycode = e.keycode) bindings with
  | Some b -> b.name
  | None -> ""

let rec input_loop current_state (machine : Machine.t) =
  match Sdlevent.poll_event () with
  | None -> input_loop current_state machine
  | Some e -> 
    match e with
    | Sdlevent.Quit _ -> Sdl.quit (); exit 0
    | Sdlevent.KeyUp e when e.keycode = Sdlkeycode.Escape -> Sdl.quit (); exit 0
    | Sdlevent.KeyUp e -> (match input_str_from_key_event e machine.bindings with
      | "" -> input_loop current_state machine
      | input_str -> input_str)
    | _ -> input_loop current_state machine

let rec game_loop (current_state : State.t) machine =
    let input_str = input_loop current_state machine in
    let current_state, new_state = new_state_with_input_str input_str current_state machine in
    let _ = State.print_input_line current_state.input_line in
    let _ = print_endline input_str in
    let _ = State.print_combos new_state in
    game_loop new_state machine

let run (machine: Machine.t) =
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let _, _ = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  game_loop machine.states machine
