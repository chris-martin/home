{ lib }:
lib.foldl' lib.mergeAttrs { } [
  (import ./editor.nix)
  (import ./explorer.nix)
  (import ./haskell.nix)
  (import ./terminal.nix)
  { "cSpell.userWords" = import ./words.nix; }
  {
    "breadcrumbs.enabled" = false;
    "vs-color-picker.autoLaunch" = false;
    "diffEditor.renderSideBySide" = false;
    "debug.console.fontSize" = 12;
  }
  {
    "todohighlight.keywordsPattern" =
      "\\bTODO\\b|\\b[Tt][Oo][Dd][Oo](?= *[:\\-\\r\\n])|\\[ *[Tt][Oo][Dd][Oo] *\\]|\\( *[Tt][Oo][Dd][Oo] *\\)|\\b_[Tt][Oo][Dd][Oo]\\b";
    "todohighlight.include" = [
      "**/*.md"
      "**/*.txt"
      "**/*.hs"
      "**/*.hsc"
      "**/*.hs.boot"
      "**/*.hsc.boot"
    ];
  }
  {
    "telemetry.enableTelemetry" = false;
    "telemetry.enableCrashReporter" = false;
    "enableTelemetry" = false;
  }
  {
    "update.enableWindowsBackgroundUpdates" = false;
    "update.mode" = "none";
    "update.showReleaseNotes" = false;
  }
  {
    "files.autoSave" = "onWindowChange";
    "files.trimTrailingWhitespace" = true;
  }
  {
    "workbench.tree.indent" = 28;
    "workbench.panel.defaultLocation" = "right";
    "workbench.sash.size" = 12;
    "workbench.startupEditor" = "none";
  }
  {
    "window.title" = "\${rootName}\${separator}\${dirty}";
    "window.titleSeparator" = "  ";
  }
  {
    "git.autofetch" = true;
    "git.openRepositoryInParentFolders" = "always";
  }
]
