# Install required packages
winget install -e --id zig.zig
winget install fzf
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd

# Install LSPs
# TODO: odin / godot

# Link nvim config
Start-Process powershell.exe -Verb runAs -ArgumentList "New-Item -Path $env:LOCALAPPDATA\nvim -ItemType SymbolicLink -Value $PSScriptRoot\.config\nvim -Force"
Start-Process powershell.exe -Verb runAs -ArgumentList "New-Item -Path '$env:LOCALAPPDATA\nvim' -ItemType SymbolicLink -Value '$PSScriptRoot\.config\nvim' -Force"
