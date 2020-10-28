(*
 * sum_test.ml (2020-10-27)
 * ========================
 *
 * An example of compiling code that depends upon another module, a library module,
 * and the standard library, using the ocaml compiler only, ocamlfind with the compiler,
 * and ocamlbuild.
 *
 * ocamlbuild
 * ----------
 * sum_test.byte:   ocamlbuild -use-ocamlfind -package OUnit2 sum_test.byte
 * sum_test.native: ocamlbuild -use-ocamlfind -package OUnit2 sum_test.native
 *
 * ocamlfind
 * ---------
 * sum_test.byte:   ocamlfind ocamlc   -o sum_test.byte   -package OUnit2 -linkpkg sum.ml sum_test.ml
 * sum_test.native: ocamlfind ocamlopt -o sum_test.native -package OUnit2 -linkpkg sum.ml sum_test.ml
 *
 * ocamlc / ocamlopt
 * -----------------
 * The below code was found by running ocamlfind ocamlc/opt -verbose ... and then simplified a bit
 * sum_test.byte:
      ocamlc -o sum_test.byte 					\
        -I ~/.opam/default/lib/ounit2/advanced 			\
        -I ~/.opam/default/lib/ounit2 				\
        ~/.opam/default/lib/ocaml/unix.cma 			\
        ~/.opam/default/lib/ounit2/advanced/oUnitAdvanced.cma	\
        ~/.opam/default/lib/ounit2/oUnit.cma 			\
        sum.ml sum_test.ml
 *
 * sum_test.native:
 *   ocamlopt -o sum_test.native 						\
       -I ~/.opam/default/lib/bytes 						\
       -I ~/.opam/default/lib/ounit2/advanced 					\
       -I ~/.opam/default/lib/ounit2 						\
       /Users/lolh-mbp/.opam/default/lib/ocaml/unix.cmxa 			\
       /Users/lolh-mbp/.opam/default/lib/ounit2/advanced/oUnitAdvanced.cmxa 	\
       /Users/lolh-mbp/.opam/default/lib/ounit2/oUnit.cmxa 			\
       sum.ml sum_test.ml
 *)

open OUnit2
open Sum

let tests = "test suite for sum_list" >::: [
  "empty"  >:: (fun _ -> assert_equal 0 (sum_list []));
  "one"    >:: (fun _ -> assert_equal 1 (sum_list [1]));
  "onetwo" >:: (fun _ -> assert_equal 3 (sum_list [1; 2]));
  "onetwofour" >:: (fun _ -> assert_equal 6 (sum_list [1; 2; 4]));
]

let _ = run_test_tt_main tests
