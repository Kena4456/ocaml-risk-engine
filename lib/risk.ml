open Types

let country_check country =
  match String.lowercase_ascii country with
  | "iran" | "russia" | "north korea" ->
      (100, [ "sanctioned or high-risk country" ])
  | "uae" | "hong kong" -> (25, [ "elevated country risk" ])
  | _ -> (0, [])

let amount_check amount =
  if amount >= 1_000_000.0 then (30, [ "high transaction amount" ])
  else if amount >= 250_000.0 then (15, [ "moderate transaction amount" ])
  else (5, [ "low transaction amount" ])

let entity_match_check score =
  if score >= 0.95 then (0, [])
  else if score >= 0.80 then (25, [ "moderate entity match confidence" ])
  else (60, [ "low entity match confidence" ])

let stamp_check blurry =
  if blurry then (20, [ "blurry or unclear stamp" ]) else (0, [])

let sanctions_check flagged =
  if flagged then (100, [ "explicit sanctions flag" ]) else (0, [])

let combine_checks checks =
  List.fold_left
    (fun (total_score, all_reasons) (score, reasons) ->
      (total_score + score, all_reasons @ reasons))
    (0, []) checks

let has_hard_block trade =
  trade.sanctioned_country
  ||
  match String.lowercase_ascii trade.country with
  | "iran" | "russia" | "north korea" -> true
  | _ -> false

let decide trade score =
  if has_hard_block trade then Block
  else if score >= 50 then Review
  else Approve

let decision_to_string = function
  | Approve -> "APPROVE"
  | Review -> "REVIEW"
  | Block -> "BLOCK"

let evaluate_trade trade =
  let checks =
    [
      sanctions_check trade.sanctioned_country;
      country_check trade.country;
      amount_check trade.amount_usd;
      entity_match_check trade.name_match_score;
      stamp_check trade.blurry_stamp;
    ]
  in
  let score, reasons = combine_checks checks in
  { score; decision = decide trade score; reasons }

let print_reasons reasons =
  List.iter (fun reason -> Printf.printf "- %s\n" reason) reasons
