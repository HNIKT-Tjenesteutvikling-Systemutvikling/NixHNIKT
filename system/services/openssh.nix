{
  services = {
    openssh = {
      enable = true;
      # Forbid root login through SSH.
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
  # Add dconf settings
  users.users = {
    dev = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEPjadku0NlF1Zkkn5lEQoUtQf7Ze4MiumMJu24y6LVFHwuygjIfZvNZYgcylMR5JzzDiCpz06cuO8pm0nGntquXADwZ6VyMdYqvepUVAMxesmSIr3p0tYhAtaPg0AvQ6CalSHe3tsL9KJPqqRAnqDB3PXSOI7hY3i5mR3EnwC7HzdEc9LlkR7NH3X2nLiY0b6Olhvgr9LhlENJ0dZxMMk36iLPDmL+dmnVITDkLFMkxS4TBNo5aA5AtNod9uMc+r96Y1Y8+6siHe4qNKdibrfp6xKaDnXIWstxaM076WTMINqzdK6/eXNnaTaIYnEkEU91jvS6tcvFwrEyhfWd+8wkJZ7JdCg4Y3dTwl2/3Ok3/jZvi79wrNpHWzlmAdj0EpGV9kLdgAD5nuEvI+zs8uJXC1CWiKj8cPo5wR5HK0pYFqXCvSGyhZRwSYwK4VgRSjJFz8SqX/5FlHLSK7Dbf3ULTmcPERMP84Q1B5h32Cwxn3G9iriPVRZ8yk24IJdQ62LBoAHjJHNjquFlpUXeXLr6mA1wXE32sCFOHV7PpsK9OOdpghQkDUZ2AgHLiL/czrozSy+y4eodBWQI0Abn9QptIYQfH9zppT4L2PZsdjCF7dclbKyKv9IJ2uWnMoZJoG0dO6hGt+xLGsfftCZH7eu3/NmX3WI1uGOuSacQv/YFQ== gako358@outlook.com"
      ];
      extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "video" "audio" ];
    };
  };
}
