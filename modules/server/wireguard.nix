{pkgs, ...}:
{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp2s0";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      privateKeyFile = "/home/jan/wireguard-keys/private";

      peers = [
        # List of allowed peers.
        { # framework
          # Public key of the peer (not a file path).
          publicKey = "0RN6mscElibLmlAZpVl5kBcBABYFWWAVFun6yFPzMlE=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }
        #{ # John Doe
          #publicKey = "{john doe's public key}";
          #allowedIPs = [ "10.100.0.3/32" ];
        #}
      ];
    };
  };
}
