let rec new_state (input: Move.t list) (current_state : State.t) (machine : Machine.t) =
    match List.find_opt (fun (s, t) -> Move.list_equal input s) current_state.transitions with
      | None -> current_state, machine.states
      | Some (s, t) -> match (s,t) with
        | (_, state) when state.input_line = [] && current_state.input_line = [] ->
          current_state, machine.states
        | (_, state) when state.input_line = [] ->
          new_state input machine.states machine
        | (input_str, to_state) ->
          current_state, to_state

let input_str_from_key_event bindings e  =
  match List.find_opt (fun (b : Move.t) -> b.keycode = e) bindings with
  | Some b -> b
  | None -> { name = ""; keycode = e}

let rec input_loop keys current_state (machine : Machine.t) =
  match Sdlevent.poll_event () with
  | None -> input_loop keys current_state machine
  | Some e -> 
    match e with
    | Sdlevent.Quit _ -> Sdl.quit (); exit 0
    | Sdlevent.KeyDown e when e.keycode = Sdlkeycode.Escape -> Sdl.quit (); exit 0
    | Sdlevent.KeyDown e ->
            input_loop (keys@[e.keycode]) current_state machine
    | Sdlevent.KeyUp e ->
            if List.length keys = 0 then
                input_loop keys current_state machine
            else
                let input_str = List.map (input_str_from_key_event machine.bindings) keys in
        List.filter (fun (a : Move.t) -> a.name <> "") input_str
    | _ -> input_loop keys current_state machine

let rec game_loop (current_state : State.t) machine =
    (*List.iter (fun (a, (b : State.t)) -> if (List.length b.input_line > 0) then print_endline (Move.list_to_string a )) current_state.transitions;*)
    let input_list = input_loop [] current_state machine in
    let current_state, new_state = new_state input_list current_state machine in
    let _ = print_string (Input_line.to_string current_state.input_line) in
    let _ = print_endline (Move.list_to_string input_list) in
    let _ = State.print_combos new_state in
    flush stdout;
    game_loop new_state machine

let run (machine: Machine.t) =
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let _, _ = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  game_loop machine.states machine
