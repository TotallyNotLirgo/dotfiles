{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage {
    pname = "gripgrab";
    version = "0.6.7";

    src = pkgs.fetchFromGitHub {
        owner = "alexpasmantier";
        repo = "grip-grab";
        rev = "831a5646dd030785b6ea32c1c3ceb0f33b989779";
        sha256 = "sha256-e7duLL4tjW+11jXUqU6sqoKTAPGkH81iDCfjtNcnd4I=";
    };

    cargoHash = "sha256-ANQL+G8EjnpNv/uIY6hqRLsuSPPcBXfb90bBiCw1Qp0=";

    meta = with pkgs.lib; {
        description = "gripgrab";
        license = licenses.mit;
    };
}
