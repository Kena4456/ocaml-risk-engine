type decision =
  | Approve
  | Review
  | Block

type trade = {
  exporter_name : string;
  country : string;
  amount_usd : float;
  name_match_score : float;
  blurry_stamp : bool;
  sanctioned_country : bool;
}

type evaluation = {
  score : int;
  decision : decision;
  reasons : string list;
}