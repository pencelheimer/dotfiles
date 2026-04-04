{pkgs, lib, ...}: {
  config = {
    services.postgresql = {
      enable = false;
      package = pkgs.postgresql_17;
      ensureDatabases = ["sds"];
      authentication = lib.mkOverride 10 ''
        #type  database     DBuser    address       auth-method
        local  all          all                     trust
        local  replication  postgres                trust
        host   all          all       127.0.0.1/32  trust
      '';
    };
  };
}
