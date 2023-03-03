# prompt
#Import-Module oh-my-posh

# SSH Agent
Import-Module posh-git
Import-Module posh-sshell
Start-SshAgent

# Load promt config 
$PROMPT_CONFIG = 'C:\Users\SzytkoK\workspace\Posh\amro.omp.json'
oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression

# icons
Import-Module Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

Set-PSReadLineKeyHandler -Chord 'Ctrl+p'`
                         -ScriptBlock {
    param($key, $arg)

	$branchName = git rev-parse --abbrev-ref HEAD
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($branchName)")
}

# PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'


# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tig 'C:\Users\SzytkoK\AppData\Local\Programs\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Users\SzytkoK\AppData\Local\Programs\Git\usr\bin\less.exe'

Set-Alias git-commit gitBranchCommit
Set-Alias git-commit-amend gitBranchCommitAmend

Set-Alias git-status Invoke-FuzzyGitStatus

# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function gitBranchCommit($commit) {
	$branchName = git rev-parse --abbrev-ref HEAD
        $command = git commit -m"$($branchName): $commit"
}

function gitBranchCommitAmend($commit) {
	$branchName = git rev-parse --abbrev-ref HEAD
        $command = git commit -m"$($branchName): $commit" --amend
}
