open Risk_engine.Types
open Risk_engine.Risk

let review_trade =
  {
    exporter_name = "Shell Trading Limited UAE";
    country = "UAE";
    amount_usd = 1_250_000.0;
    name_match_score = 0.82;
    blurry_stamp = true;
    sanctioned_country = false;
  }

let low_risk_trade =
  {
    exporter_name = "North Sea Metals";
    country = "Norway";
    amount_usd = 90_000.0;
    name_match_score = 0.98;
    blurry_stamp = false;
    sanctioned_country = false;
  }

let blocked_trade =
  {
    exporter_name = "Eastern Energy Holdings";
    country = "Russia";
    amount_usd = 400_000.0;
    name_match_score = 0.91;
    blurry_stamp = false;
    sanctioned_country = true;
  }

let sample_trades = [ review_trade; low_risk_trade; blocked_trade ]

let print_trade_result trade =
  let result = evaluate_trade trade in
  Printf.printf "Exporter: %s\n" trade.exporter_name;
  Printf.printf "Country: %s\n" trade.country;
  Printf.printf "Amount: $%.2f\n" trade.amount_usd;
  Printf.printf "Risk Score: %d\n" result.score;
  Printf.printf "Decision: %s\n" (decision_to_string result.decision);
  Printf.printf "Reasons:\n";
  print_reasons result.reasons;
  Printf.printf "------------------------------\n"

let usage () =
  Printf.printf "Usage:\n";
  Printf.printf "  dune exec risk_engine -- all\n";
  Printf.printf "  dune exec risk_engine -- approve\n";
  Printf.printf "  dune exec risk_engine -- review\n";
  Printf.printf "  dune exec risk_engine -- block\n"

let () =
  if Array.length Sys.argv < 2 then usage ()
  else
    match Sys.argv.(1) with
    | "all" -> List.iter print_trade_result sample_trades
    | "approve" -> print_trade_result low_risk_trade
    | "review" -> print_trade_result review_trade
    | "block" -> print_trade_result blocked_trade
    | _ -> usage ()
