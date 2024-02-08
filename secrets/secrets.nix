let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkt8xgN5ZlTyuSBWAhlv0CCxIN6LmzfSMTHTc53rZ6i";
 

  # keys to work for all secrets
  all = [ agenix  ];

in
{

  "key.age".publicKeys = all;


  #example for calling groups
  #"secret2.age".publicKeys = users ++ systems;
} 