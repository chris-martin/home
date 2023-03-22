{ config, pkgs, ... }:
{
    services.monero = {
        enable = true;
        mining.enable = true;
        mining.address = "427YsNgWdfJ9VraWsLC6h4Rygqq1VozD8Q6JC2DoPcHzbRxo6xjtWHyF7B1PBYsqFN8R37itSYthm6xiaDxGoFdFLKnDMn7";
        mining.threads = 1;
    };
}
