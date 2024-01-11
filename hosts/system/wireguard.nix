{ pkgs, ... }: {
  networking.wg-quick.interfaces =
    let
      server_ip = "176.125.235.71";
    in
    {
      wg0 = {
        # IP address of this machine in the *tunnel network*
        address = [
          "10.64.186.60/32"
          "fdc9:281f:04d7:9ee9::2/64"
        ];

        # To match firewall allowedUDPPorts (without this wg
        # uses random port numbers).
        listenPort = 51820;

        # Path to the private key file.
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
