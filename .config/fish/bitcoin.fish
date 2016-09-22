function btc-gen-key
  set entropy (openssl rand -hex 32)
  set private (bx ec-new $entropy)
  set public (bx ec-to-public $private)
  echo "Private key: $private"
  echo "Public key: $public"
end
