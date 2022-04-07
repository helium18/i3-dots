# nvimconf
 
 Neovim Config
 
 ![image](https://user-images.githubusercontent.com/86223025/153351059-d5905b19-92e6-40f3-8592-f74b866a3612.png)

## Key Points
1. Goes well with Adwaita - Uses the `Tender` theme with the `minimalist` airline theme.

2. Preconfigured for: 
 - Rust
 - Typescript & Javascript
 - Java
 - Html
 - Css
3. Coc lsp which gives vscode like completions (both of them have the same backend). 

# Install Instructions 

Install [Vim Plug](https://github.com/junegunn/vim-plug) 
then 

```
git clone https://github.com/helium18/nvimconf.git 
mv nvimconf nvim
mv nvim ~/.config
``` 

Inside `init.vim` run `source %` and then `PlugInstall` and `CocInstall`.
