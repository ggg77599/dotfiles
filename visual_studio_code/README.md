

### Enable repeat press

```shell
$ defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For MacOS
```

* https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode

### Plugins

All the configuation set at settings.json

* Vim

  * using .vimrc

  ```json
      "vim.vimrc.enable": true
  ```

* Go

  * verbose mode for build and test
  * delve debug print log

  ```json
      "go.buildFlags": [
          "-v"
      ],
      "go.testFlags": [
          "-v"
      ],
  ```

  * https://github.com/golang/vscode-go/blob/master/docs/settings.md
