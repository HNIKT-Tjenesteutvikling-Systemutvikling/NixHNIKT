{ pkgs, ... }: {
  networking.wg-quick.interfaces =
    let
      server_ip = "176.125.235.71";
    in
    {
      wg0 = {
        address = [
          "10.66.203.155/32,fc00:bbbb:bbbb:bb01::3:cb9a/128"
        ];
        listenPort = 51820;
        privateKeyFile = "/etc/mullvad-vpn.key";
        postUp = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.66.203.155/32 -o wlp0s20f3 -j MASQUERADE
          ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fc00:bbbb:bbbb:bb01::3:cb9a/128 -o wlp0s20f3 -j MASQUERADE
        '';

        # Undo above
        postDown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.66.203.155/32 -o wlp0s20f3 -j MASQUERADE
          ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fc00:bbbb:bbbb:bb01::3:cb9a/128 -o wlp0s20f3 -j MASQUERADE
        '';
        peers = [{
          publicKey = "jOUZjMq2PWHDzQxu3jPXktYB7EKeFwBzGZx56cTXXQg=";
          allowedIPs = [ "192.168.146.65/32" "fe80::5c1:51fb:d012:6930" ];
        }];
      };
    };

  networking.firewall.allowedUDPPorts = [ 51820 ];
}
