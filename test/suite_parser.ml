open OUnit2

let with_valid_gmr _ =
  let file_name = "grammars/mk9.gmr" in
  let _ = Parser.parse_grammar file_name in
  assert_equal true true

let with_no_bindings _ =
  let file_name = "grammars/test/missing_bindings.gmr" in
  assert_raises (Sys_error file_name) (fun () -> Parser.parse_grammar file_name)

let with_no_comma _ =
  let file_name = "grammars/test/missing_comma.gmr" in
  assert_raises (Sys_error file_name) (fun () -> Parser.parse_grammar file_name)

let with_no_name _ =
  let file_name = "grammars/test/missing_name.gmr" in
  assert_raises (Sys_error file_name) (fun () -> Parser.parse_grammar file_name)

let with_no_pipe _ =
  let file_name = "grammars/test/missing_pipe.gmr" in
  assert_raises (Sys_error file_name) (fun () -> Parser.parse_grammar file_name)

let with_no_semicolomn _ =
  let file_name = "grammars/test/missing_semicolomn.gmr" in
  assert_raises (Sys_error file_name) (fun () -> Parser.parse_grammar file_name)

let tests =
  "suite_parser" >::: [
    "with_valid_gmr" >:: with_valid_gmr;
    "with_no_bindings" >:: with_no_bindings;
    "with_no_comma" >:: with_no_comma;
    "with_no_name" >:: with_no_name;
    "with_no_pipe" >:: with_no_pipe;
    "with_no_semicolomn" >:: with_no_semicolomn;
  ]
