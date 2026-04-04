{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    syshud
    (pkgs.syspower.overrideAttrs (oldAttrs: rec {
      version = "0-unstable-2025-11-19";

      src = pkgs.fetchFromGitHub {
        owner = "System64fumo";
        repo = "syspower";
        rev = "bda4d47c8eab9352d2ea0ca80f92903bb0f31f98";
        hash = "sha256-vlanBuHCYAjauGpfnH4Uiig6gQSW1V4dBAia1MOewvc=";
      };
    }))

    materialgram

    wl-mirror

    ouch

    imagemagick
    krita

    ydotool

    supersonic

    sysz

    typst
    tinymist
    pdfarranger
    plantuml

    go
    air
    delve

    dbmate
    pgcli
    postgres-language-server # includes CLI, so needed in nvim and here

    git-crypt

    just
    bear
    gcc
    glibcInfo
    man-pages
    valgrind
    kdePackages.kcachegrind
    hotspot
    perf

    javaPackages.compiler.openjdk21
    maven
    mvnd

    cargo
    rustc
    clippy

    cloudflared

    xh

    obsidian

    vial

    steam
    gale

    inputs.helium.packages.x86_64-linux.default

    bun
    uv

    google-chat-linux
  ];

  programs.vesktop.enable = true;
}
