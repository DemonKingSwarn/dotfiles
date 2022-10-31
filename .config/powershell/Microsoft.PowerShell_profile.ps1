function cd... { cd ..\.. }
function cd.... { cd ..\..\.. }

function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

function n { nvim $args }

# reloads the powershell profile
function reload-profile {
    & $profile
}

# final line to set the prompt
oh-my-posh --init --shell pwsh --config ~/.config/powershell/jandedobbeleer.omp.json | Invoke-Expression
