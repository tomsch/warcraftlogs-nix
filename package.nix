{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "warcraftlogs";
  version = "8.20.113";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v${version}/${pname}-v${version}.AppImage";
    hash = "sha256-SENHWUvmHPEHigL2Y5vQvxpZHqtfgW+7Wd3R+3oliBA=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm644 "${appimageContents}/Warcraft Logs Uploader.desktop" $out/share/applications/warcraftlogs.desktop
    substituteInPlace $out/share/applications/warcraftlogs.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}' \
      --replace-fail 'Icon=Warcraft Logs Uploader' 'Icon=warcraftlogs'
    install -Dm644 "${appimageContents}/usr/share/icons/hicolor/512x512/apps/Warcraft Logs Uploader.png" \
      $out/share/icons/hicolor/512x512/apps/warcraftlogs.png
  '';

  meta = {
    description = "Warcraft Logs combat log uploader";
    homepage = "https://www.warcraftlogs.com";
    downloadPage = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "warcraftlogs";
  };
}
