{ pkgs, ... }: {
  networking.wireguard.interfaces =
    let
      server_ip = "176.125.235.71";
    in
    {
      wg0 = {
        ips = [10.66.203.155/32];
        listenPort = 51820;
        privateKeyFile = "/etc/mullvad-vpn.key";

        peers = [{
          publicKey = "jOUZjMq2PWHDzQxu3jPXktYB7EKeFwBzGZx56cTXXQg=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "${server_ip}:51820";
          persistentKeepalive = 25;
        }];
      };
    };
}
