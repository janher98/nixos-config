{config, ...}:
{
  networking.firewall = {
    allowedUDPPorts = [ 53 853 ];
    allowedTCPPorts = [ 53 853 ];
  };

  services.adguardhome = {
    enable = true;
    host = "192.168.234.10";
    port = 80;
    settings = {
      http = {
        # You can select any ip and port, just make sure to open firewalls where needed
        address = "192.168.234.10:80";
      };
      dns = {
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

        parental_enabled = false;  # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false;  # Enforcing "Safe search" option for search engines, when possible.
        };
      };
      # The following notation uses map
      # to not have to manually create {enabled = true; url = "";} for every filter
      # This is, however, fully optional
      filters = map(url: { enabled = true; url = url; }) [
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"  # malicious url blocklist
      ];
    };
  };
}
