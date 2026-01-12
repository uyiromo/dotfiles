# dotfiles

## Init

```sh
sudo apt install -y git

mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh

cat << __EOF__ > $HOME/.ssh/config
Host github*
  HostName github.com
  User git
  Port 22
  IdentityFile %d/.ssh/pk_github
  IdentitiesOnly yes
__EOF__

cat << __EOF__ > $HOME/.ssh/pk_github
(Github Private Key)
__EOF__
chmod 600 $HOME/.ssh/pk_github

git clone git@github.com:uyiromo/dotfiles.git
```

## Install

```sh
./init-zsh.sh
./init-ssh.sh
./init-tmux.sh
./init-vim.sh
GIT_USER=... GIT_EMAIL=... ./init-git.sh
```

## vscode

### Theme

- [Dracula Theme Official](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
- [Github Theme](https://marketplace.visualstudio.com/items?itemName=GitHub.github-vscode-theme)

### General

- [Vim](https://marketplace.visualstudio.com/items/?itemName=vscodevim.vim)
- [Trailing Spaces](https://marketplace.visualstudio.com/items/?itemName=shardulm94.trailing-spaces)
- [Doxygen Documentation Generator](https://marketplace.visualstudio.com/items/?itemName=cschlosser.doxdocgen)
- [Error Lens](https://marketplace.visualstudio.com/items/?itemName=usernamehw.errorlens)
- [Code Spell Checker](https://marketplace.visualstudio.com/items/?itemName=streetsidesoftware.code-spell-checker)
- [Output Colorizer](https://marketplace.visualstudio.com/items/?itemName=IBM.output-colorizer)
- [Peacock](https://marketplace.visualstudio.com/items/?itemName=johnpapa.vscode-peacock)
- [Todo+](https://marketplace.visualstudio.com/items/?itemName=fabiospampinato.vscode-todo-plus)
- [vscode-icons](https://marketplace.visualstudio.com/items/?itemName=vscode-icons-team.vscode-icons)
- [Draw.io Integration](https://marketplace.visualstudio.com/items/?itemName=hediet.vscode-drawio)
- [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items/?itemName=bierner.markdown-mermaid)
- [Mermaid Markdown Syntax Highlighting](https://marketplace.visualstudio.com/items/?itemName=bpruitt-goddard.mermaid-markdown-syntax-highlighting)
- [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items/?itemName=shd101wyy.markdown-preview-enhanced)

### CSV

- [Rainbow CSV](https://marketplace.visualstudio.com/items/?itemName=mechatroner.rainbow-csv)

### LLM

- [Copilot](https://marketplace.visualstudio.com/items/?itemName=GitHub.copilot)
- [Copilot Chat](https://marketplace.visualstudio.com/items/?itemName=GitHub.copilot-chat)

### Git

- [Gitmoji](https://marketplace.visualstudio.com/items/?itemName=seatonjiang.gitmoji-vscode)
- [Git Graph](https://marketplace.visualstudio.com/items/?itemName=mhutchie.git-graph)
- [Git Lens](https://marketplace.visualstudio.com/items/?itemName=eamodio.gitlens)

### C/C++

- [clangd](https://marketplace.visualstudio.com/items/?itemName=llvm-vs-code-extensions.vscode-clangd)
- [C/C++](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.cpptools)

### CMake

- [CMake Tools](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.cmake-tools)

### Python

- [Python](https://marketplace.visualstudio.com/items/?itemName=ms-python.python)
- [Pylance](https://marketplace.visualstudio.com/items/?itemName=ms-python.vscode-pylance)
- [charliermarsh.ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)
- [autoDocstring](https://marketplace.visualstudio.com/items/?itemName=njpwerner.autodocstring)

### Markdown

- [markdownlint](https://marketplace.visualstudio.com/items/?itemName=DavidAnson.vscode-markdownlint)
- [Table Formatter](https://marketplace.visualstudio.com/items/?itemName=shuworks.vscode-table-formatter)

### JSON

- [Sort JSON objects](https://marketplace.visualstudio.com/items/?itemName=richie5um2.vscode-sort-json)

### shell

- [shfmt](https://marketplace.visualstudio.com/items/?itemName=mkhl.shfmt)
- [shellcheck](https://marketplace.visualstudio.com/items/?itemName=timonwong.shellcheck)
- [editorconfig](https://marketplace.visualstudio.com/items/?itemName=EditorConfig.EditorConfig)

### textlint

```sh
npm install \
    textlint \
    textlint-rule-preset-jtf-style \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-preset-ja-spacing \
    @proofdict/textlint-rule-proofdict
```
