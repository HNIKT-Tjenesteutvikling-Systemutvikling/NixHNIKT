{
  inputs,
  ...
}:
{

  imports = [ inputs.mugge.homeManagerModules.default ];

  services.mugge-chat.enable = true;
}
