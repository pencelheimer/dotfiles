{pkgs, ...}: {
  imports = [];
  config = {
    # boot.kernelPackages = pkgs.linuxPackages_cachyos;
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    boot.consoleLogLevel = 0;
  };
}
