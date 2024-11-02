{config, pkgs, ...}:
{
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      # Setup Nextcloud virtual host to listen on ports
      virtualHosts = {

        ${config.services.nextcloud.hostName} = {
           ## Force HTTP redirect to HTTPS
           forceSSL = true;
           ## LetsEncrypt
           enableACME = true;
        };
      };
    };
    nextcloud = {
      enable = true;
      hostName = "somedomain.com";
      package = pkgs.nextcloud29;
      # Enable built-in virtual host management
      # Takes care of somewhat complicated setup
      # See here: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/web-apps/nextcloud.nix#L529
      # nginx.enable = true; depricated

      # Use HTTPS for links
      https = true;

      # Auto-update Nextcloud Apps
      #autoUpdateApps.enable = true;
      # Set what time makes sense for you
      #autoUpdateApps.startAt = "03:00:00";
      settings = {
        # Further forces Nextcloud to use HTTPS
        extraTrustedDomains = ["192.168.234.1" "192.168.234.8" "192.168.234.100" "framework" "*"];
        #overwriteProtocol = "https";
        trustedProxies = ["192.168.234.1"];
      };
      config = {

        # Nextcloud PostegreSQL database configuration, recommended over using SQLite
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        dbpassFile = "/persist/nextcloud-db-pass";

        adminpassFile = "/persist/nextcloud-admin-pass";
        adminuser = "admin";
      };
      #maxUploadSize = "1G"; # Adjust for max upload sizei
    };
    postgresql = {
      enable = true;

      # Ensure the database, user, and permissions always exist
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        { name = "nextcloud";
          #ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
          ensureDBOwnership = true;
        }
      ];
    };
  };
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
