[
    { "key" = "alt+backspace"; "command" = "-subwordNavigation.deleteSubwordLeft"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "alt+delete"; "command" = "-subwordNavigation.deleteSubwordRight"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "alt+down"; "command" = "-editor.action.moveLinesDownAction"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "alt+down"; "command" = "editor.action.insertCursorBelow"; "when" = "editorTextFocus"; }
    { "key" = "alt+left"; "command" = "-subwordNavigation.cursorSubwordLeft"; "when" = "editorTextFocus"; }
    { "key" = "alt+left"; "command" = "workbench.action.previousEditor"; }
    { "key" = "alt+p"; "command" = "-keybindings.editor.toggleSortByPrecedence"; "when" = "inKeybindings"; }
    { "key" = "alt+p"; "command" = "editor.action.replaceOne"; "when" = "editorFocus && findWidgetVisible"; }
    { "key" = "alt+p"; "command" = "search.action.replace"; "when" = "matchFocus && replaceActive && searchViewletVisible"; }
    { "key" = "alt+right"; "command" = "-subwordNavigation.cursorSubwordRight"; "when" = "editorTextFocus"; }
    { "key" = "alt+right"; "command" = "workbench.action.nextEditor"; }
    { "key" = "alt+up"; "command" = "-editor.action.moveLinesUpAction"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "alt+up"; "command" = "editor.action.insertCursorAbove"; "when" = "editorTextFocus"; }

    { "key" = "ctrl+`"; "command" = "-workbench.action.terminal.toggleTerminal"; "when" = "terminal.active"; }
    { "key" = "ctrl+alt+enter"; "command" = "-editor.action.replaceAll"; "when" = "editorFocus && findWidgetVisible"; }
    { "key" = "ctrl+alt+enter"; "command" = "-search.action.replaceAll"; "when" = "replaceActive && searchViewletVisible && !findWidgetVisible"; }
    { "key" = "ctrl+alt+z"; "command" = "workbench.action.toggleZenMode"; }
    { "key" = "ctrl+b"; "command" = "-workbench.action.toggleSidebarVisibility"; }
    { "key" = "ctrl+b"; "command" = "editor.action.revealDefinition"; "when" = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"; }
    { "key" = "ctrl+backspace"; "command" = "subwordNavigation.deleteSubwordLeft"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "ctrl+delete"; "command" = "subwordNavigation.deleteSubwordRight"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "ctrl+end"; "command" = "-cursorBottom"; "when" = "textInputFocus"; }
    { "key" = "ctrl+enter"; "command" = "editor.action.replaceAll"; "when" = "editorFocus && findWidgetVisible"; }
    { "key" = "ctrl+enter"; "command" = "search.action.replaceAll"; "when" = "replaceActive && searchViewletVisible && !findWidgetVisible"; }
    { "key" = "ctrl+h"; "command" = "-editor.action.startFindReplaceAction"; }
    { "key" = "ctrl+home"; "command" = "-cursorTop"; "when" = "textInputFocus"; }
    { "key" = "ctrl+k z"; "command" = "-workbench.action.toggleZenMode"; }
    { "key" = "ctrl+k"; "command" = "workbench.action.terminal.toggleTerminal"; "when" = "terminal.active"; }
    { "key" = "ctrl+left"; "command" = "subwordNavigation.cursorSubwordLeft"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+o"; "command" = "-workbench.action.files.openFile"; "when" = "true"; }
    { "key" = "ctrl+o"; "command" = "-workbench.action.files.openFileFolder"; "when" = "isMacNative && openFolderWorkspaceSupport"; }
    { "key" = "ctrl+o"; "command" = "-workbench.action.files.openFolderViaWorkspace"; "when" = "!openFolderWorkspaceSupport && workbenchState == 'workspace'"; }
    { "key" = "ctrl+o"; "command" = "-workbench.action.files.openLocalFile"; "when" = "remoteFileDialogVisible"; }
    { "key" = "ctrl+pagedown"; "command" = "-workbench.action.nextEditor"; }
    { "key" = "ctrl+pageup"; "command" = "-workbench.action.previousEditor"; }
    { "key" = "ctrl+q"; "command" = "-workbench.action.quit"; }
    { "key" = "ctrl+r"; "command" = "-workbench.action.reloadWindow"; "when" = "isDevelopment"; }
    { "key" = "ctrl+r"; "command" = "editor.action.startFindReplaceAction"; }
    { "key" = "ctrl+right"; "command" = "subwordNavigation.cursorSubwordRight"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+s"; "command" = "-workbench.action.files.save"; }
    { "key" = "ctrl+s"; "command" = "workbench.action.files.saveAll"; }
    { "key" = "ctrl+w"; "command" = "workbench.action.terminal.kill"; "when" = "terminalFocus"; }
    { "key" = "ctrl+y"; "command" = "editor.action.deleteLines"; "when" = "textInputFocus && !editorReadonly"; }

    { "key" = "ctrl+shift+`"; "command" = "-workbench.action.terminal.new"; }
    { "key" = "ctrl+shift+1"; "command" = "-editor.action.replaceOne"; "when" = "editorFocus && findWidgetVisible"; }
    { "key" = "ctrl+shift+1"; "command" = "-search.action.replace"; "when" = "matchFocus && replaceActive && searchViewletVisible"; }
    { "key" = "ctrl+shift+c"; "command" = "-workbench.action.terminal.openNativeConsole"; "when" = "!terminalFocus"; }
    { "key" = "ctrl+shift+down"; "command" = "-editor.action.insertCursorBelow"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+shift+down"; "command" = "editor.action.moveLinesDownAction"; "when" = "editorTextFocus && !editorReadonly"; }
    { "key" = "ctrl+shift+h"; "command" = "-workbench.action.replaceInFiles"; }
    { "key" = "ctrl+shift+k"; "command" = "-editor.action.deleteLines"; "when" = "textInputFocus && !editorReadonly"; }
    { "key" = "ctrl+shift+left"; "command" = "subwordNavigation.cursorSubwordLeftSelect"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+shift+r"; "command" = "workbench.action.replaceInFiles"; }
    { "key" = "ctrl+shift+right"; "command" = "subwordNavigation.cursorSubwordRightSelect"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+shift+up"; "command" = "-editor.action.insertCursorAbove"; "when" = "editorTextFocus"; }
    { "key" = "ctrl+shift+up"; "command" = "editor.action.moveLinesUpAction"; "when" = "editorTextFocus && !editorReadonly"; }

    { "key" = "shift+alt+down"; "command" = "-editor.action.insertCursorBelow"; "when" = "editorTextFocus"; }
    { "key" = "shift+alt+left"; "command" = "-subwordNavigation.cursorSubwordLeftSelect"; "when" = "editorTextFocus"; }
    { "key" = "shift+alt+right"; "command" = "-subwordNavigation.cursorSubwordRightSelect"; "when" = "editorTextFocus"; }
    { "key" = "shift+alt+up"; "command" = "-editor.action.insertCursorAbove"; "when" = "editorTextFocus"; }

    { "key" = "up"; "command" = "editor.action.previousMatchFindAction"; "when" = "editorFocus && findInputFocussed"; }
    { "key" = "up"; "command" = "editor.action.previousMatchFindAction"; "when" = "editorFocus && replaceInputFocussed"; }
    { "key" = "down"; "command" = "editor.action.nextMatchFindAction"; "when" = "editorFocus && findInputFocussed"; }
    { "key" = "down"; "command" = "editor.action.nextMatchFindAction"; "when" = "editorFocus && replaceInputFocussed"; }

    { "key" = "shift+enter"; "command" = "-editor.action.previousMatchFindAction"; "when" = "editorFocus && findInputFocussed"; }
    { "key" = "enter"; "command" = "editor.action.nextMatchFindAction"; "when" = "editorFocus && findInputFocussed"; }

    { "key" = "f3"; "command" = "-editor.action.nextMatchFindAction"; "when" = "editorFocus"; }
    { "key" = "shift+f3"; "command" = "-editor.action.previousMatchFindAction"; "when" = "editorFocus"; }
    { "key" = "f5"; "command" = "-debug.openView"; "when" = "!debuggersAvailable"; }
    { "key" = "f5"; "command" = "-vscode-postgres.runQuery"; "when" = "editorLangId == 'postgres'"; }
    { "key" = "f5"; "command" = "-workbench.action.debug.continue"; "when" = "debugState == 'stopped'"; }
    { "key" = "f5"; "command" = "-workbench.action.debug.continue"; "when" = "inDebugMode"; }
    { "key" = "f5"; "command" = "-workbench.action.debug.start"; "when" = "!inDebugMode"; }
    { "key" = "f5"; "command" = "-workbench.action.debug.start"; "when" = "debuggersAvailable && debugState == 'inactive'"; }
    { "key" = "f5"; "command" = "haskell.commands.restartServer"; }
    { "key" = "f12"; "command" = "-editor.action.revealDefinition"; "when" = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"; }
]
