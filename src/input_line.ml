type t = Move.t list list

let rec to_string = function
    | [] -> ""
    | h::t -> (Move.list_to_string h) 
              ^ (if List.length t > 0 then "," else "")
              ^ to_string t

let rec is_subline (a : t) (b : t) =
    match (a, b) with
    | ([], _) -> true
    | (_, []) -> false
    | (a, b) when (List.equal (fun (c : Move.t) (d : Move.t) ->
        String.equal c.name d.name) (List.hd a) (List.hd b)) ->
      is_subline (List.tl a) (List.tl b)
    | _ -> false

let equal a b =
    List.equal (fun c d -> List.equal (Move.equal) c d) a b

let cmp a b =
    if equal a b then
        0
    else
        1
