open Risk_engine.Types
open Risk_engine.Risk

let assert_equal name expected actual =
  if expected = actual then
    Printf.printf "[PASS] %s\n" name
  else
    Printf.printf "[FAIL] %s: expected %s but got %s\n"
      name
      (decision_to_string expected)
      (decision_to_string actual)

let low_risk_trade = {
  exporter_name = "North Sea Metals";
  country = "Norway";
  amount_usd = 90_000.0;
  name_match_score = 0.98;
  blurry_stamp = false;
  sanctioned_country = false;
}

let review_trade = {
  exporter_name = "Shell Trading Limited UAE";
  country = "UAE";
  amount_usd = 1_250_000.0;
  name_match_score = 0.82;
  blurry_stamp = true;
  sanctioned_country = false;
}

let blocked_trade = {
  exporter_name = "Eastern Energy Holdings";
  country = "Russia";
  amount_usd = 400_000.0;
  name_match_score = 0.91;
  blurry_stamp = false;
  sanctioned_country = true;
}

let () =
  let low_result = evaluate_trade low_risk_trade in
  let review_result = evaluate_trade review_trade in
  let blocked_result = evaluate_trade blocked_trade in

  assert_equal "low-risk trade approves" Approve low_result.decision;
  assert_equal "moderate-risk trade reviews" Review review_result.decision;
  assert_equal "sanctioned trade blocks" Block blocked_result.decision