(*
   Application's entrypoint.
*)

let codegen filename =
  let tree_sitter_grammar =
    Atdgen_runtime.Util.Json.from_file Tree_sitter_j.read_grammar filename
  in
  let grammar = AST_grammar.of_tree_sitter tree_sitter_grammar in
  let out = Codegen.reason grammar in
  print_string out

(* TODO: use cmdliner (see e.g. dune-deps for a simple template)
   TODO: provide basic command-line help
*)
let main () =
  match Sys.argv with
  | [| _; filename |] -> codegen filename
  | _ ->
      eprintf "\
Usage: please pass exactly one grammar.json file as argument\n%!";
      exit 1

(* TODO: print clean error messages, print backtrace for unexpected errors. *)
let () = main ()
