{pkgs, ...}: {
  config = {
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruber.yaml";
    stylix.homeManagerIntegration.followSystem = false;
  };
}
