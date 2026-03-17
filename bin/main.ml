open Risk_engine.Types
open Risk_engine.Risk

let sample_trades = [
  {
    exporter_name = "Shell Trading Limited UAE";
    country = "UAE";
    amount_usd = 1_250_000.0;
    name_match_score = 0.82;
    blurry_stamp = true;
    sanctioned_country = false;
  };
  {
    exporter_name = "North Sea Metals";
    country = "Norway";
    amount_usd = 90_000.0;
    name_match_score = 0.98;
    blurry_stamp = false;
    sanctioned_country = false;
  };
  {
    exporter_name = "Eastern Energy Holdings";
    country = "Russia";
    amount_usd = 400_000.0;
    name_match_score = 0.91;
    blurry_stamp = false;
    sanctioned_country = true;
  };
]

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

let () =
  List.iter print_trade_result sample_trades