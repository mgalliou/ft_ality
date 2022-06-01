open OUnit2
open Suite_parser

let () =
    run_test_tt_main
    ("ft_ality" >:::
      [
        Suite_parser.tests
      ]
    )
