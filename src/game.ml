let new_state_with_input_str input (current_state : State.t) (machine : Machine.t) =
  match List.find (fun (s, t) -> String.equal input s) current_state.transitions with
  | ("", _) -> machine.states
  | (_, state) when state.input_line = [] -> machine.states
  | (input_str, to_state) -> to_state

let input_str_from_key_event (e : Sdlevent.keyboard_event) bindings =
  match List.find_opt (fun (b : Move.t) -> b.keycode = e.keycode) bindings with
  | Some b -> b.name
  | None -> ""

let new_state_with_event e state (machine : Machine.t) =
  match e with
  | Sdlevent.Quit _ -> Sdl.quit (); exit 0
  | Sdlevent.KeyUp e -> 
    let input_str = input_str_from_key_event e machine.bindings in
    let new_state = new_state_with_input_str input_str state machine in
    let _ =  List.iter print_endline new_state.input_line in
    let _ = State.print_combos new_state in
    new_state
  | _ -> state

let rec event_loop current_state machine =
  match Sdlevent.poll_event () with
  | None -> event_loop current_state machine
  | Some e -> 
    let new_state = new_state_with_event e current_state machine in
    event_loop new_state machine

let run (machine: Machine.t) =
  Sdl.init_subsystem [`VIDEO];
  let width, height = (0, 0) in
  let _, _ = Sdl.Render.create_window_and_renderer ~width ~height ~flags:[] in
  event_loop machine.states machine
