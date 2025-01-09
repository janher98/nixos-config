{config, ...}:
{
  networking.firewall = {
    allowedUDPPorts = [ 53 853 ];
    allowedTCPPorts = [ 80 443 ];
  };

  services.adguardhome = {
    enable = true;
    host = "192.168.234.10";
    mutableSettings = false;
    port = 80;
    settings = {
      http = {
        # You can select any ip and port, just make sure to open firewalls where needed
        address = "192.168.234.10:80";
      };
      #users = [{
      #    name = "admin";
      #    password = "$2y$19$r2pXQ3rfgZkAZFNqFrKcbOCrjLxGhe3NMmSuR7pzVrKqEV6Vinj/G"; # admin
      #}];
      dns = {
        bootstrap_dns = [ "1.1.1.1" ];
        upstream_dns = [
          # Example config with quad9
          "1.1.1.3"
          # Uncomment the following to use a local DNS service (e.g. Unbound)
          # Additionally replace the address & port as needed
          # "127.0.0.1:5335"
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = true;  # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false;  # Enforcing "Safe search" option for search engines, when possible.
        };
        blocked_services = {
          ids = [
            "reddit"
            "tiktok"
            "facebook"
            "instagram"
            "youtube"
          ];
          schedule = {
            timezone = "Europe/Berlin";
             mon = {
               start = "0h";
               end = "16h";
             };
             tue = {
               start = "0h";
               end = "16h";
             };
             wed = {
               start = "0h";
               end = "16h";
             };
             thu = {
               start = "0h";
               end = "16h";
             };
             fri = {
               start = "0h";
               end = "16h";
             };
             sat = {
               start = "0h";
               end = "14h";
             };
             sun = {
               start = "0h";
               end = "14h";
             };
          };
        };
      };
      filters = [
        { enabled = true; id = 1; name = "Adguard 9"; url ="https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt";}  # The Big List of Hacked Malware Web Sites
        { enabled = true; id = 2; name = "Adguard 11"; url ="https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt";}  # malicious url blocklist
        { enabled = true; id = 3; name = "Blocklistproject all"; url ="https://blocklistproject.github.io/Lists/everything.txt";}
        { enabled = true; id = 4; name = "Blocklistproject smart-tv"; url ="https://blocklistproject.github.io/Lists/smart-tv.txt";}
        { enabled = true; id = 5; name = "Other"; url ="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";}
      ];
      user_rules = [
        "||reddit.com^"
      ];
    };
  };
}
