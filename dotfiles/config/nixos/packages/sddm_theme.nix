{ stdenv, fetchFromGitHub, pkgs }:
let
config = ''
  [General]

  Background="/etc/nixos/backgrounds/NixLoginWallpaper.png"
  ScaleImageCropped=true

  ScreenWidth=1920
  ScreenHeight=1080

  MainColor="#c678dd"
  AccentColor="white"

  RoundCorners=20
  Font="Noto Sans"
  FontSize=

  Locale=
  HourFormat="HH:mm"
  DateFormat="d MMMM yyyy"

  ForceRightToLeft=false
  ForceLastUser=true
  ForcePasswordFocus=true
  ForceHideCompletePassword=true
  ForceHideVirtualKeyboardButton="false"

  HeaderText=""

  TranslatePlaceholderUsername=""
  TranslatePlaceholderPassword=""
  TranslateShowPassword=""
  TranslateLogin=""
  TranslateLoginFailedWarning=""
  TranslateCapslockWarning=""
  TranslateSession=""
  TranslateSuspend=""
  TranslateHibernate=""
  TranslateReboot=""
  TranslateShutdown=""
  TranslateVirtualKeyboardButton=""
'';
in
{
  sddm-theme = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark";
    version = "custom";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
      chmod -R 755 $out/share/sddm/themes/sugar-dark/theme.conf
      echo "${config}" > $out/share/sddm/themes/sugar-dark/theme.conf
      chmod 755 $out/share/sddm/themes/sugar-dark/
      find $out -type f -exec sed -i 's/#444/#282c34/g' {} \;
    '';
    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
    };
  };
}
