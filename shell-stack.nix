{ pkgs ? import <nixpkgs> {}, ghc ? pkgs.ghc }: with pkgs;

haskell.lib.buildStackProject {
  inherit ghc;
  name = "default-stack-shell";
  buildInputs = with pkgs; [
    git    # HACK: Provide access to Git inside Nix env that is executed by Stack
           # FIXME: why `nativeBuildInputs = [ git ]`  not enough?
    icu                     # for text-icu
    libxml2                 
    postgresql              # for postgresql-simple / opaleye
    libphonenumber protobuf # for phonenumber
    zlib                    # all stack stuff need zlib
  ];
  
  nativeBuildInputs = with pkgs; [
    git    # HACK: Provide access to Git inside Nix env that is executed by Stack
  ];

  LANG = "en_US.UTF-8";    # HACK: Haddock fails without this inside pure Nix environment
}
