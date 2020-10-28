(*
 * sum.ml (2020-10-27)
 * ===================
 *)

let rec sum_list ls =
  match ls with
  |    [] -> 0
  | x::[] -> x
  | x::xs -> x + sum_list xs;;
