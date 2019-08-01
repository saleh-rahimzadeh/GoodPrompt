<#----------------------------------------------------------------------------#
 # WellPrompt                                                                 #
 # Version 1.0                                                                #
 # Copyright (C) Saleh Rahimzadeh                                             #
 #----------------------------------------------------------------------------#>

function Prompt {
	$Status = "`u{2592} " + $MyInvocation.HistoryId + ' '
	$Location = "`u{258c} " + $($ExecutionContext.SessionState.Path.CurrentLocation)
	$Addition = get-date -uformat %r;
	
	if (Test-Path variable:/PSDebugContext) { 
		$Addition = "[DBG] `u{2502} " + $Addition
	}

	$Space = $host.UI.RawUI.WindowSize.Width - (($Status.Length + $Location.Length) % $host.UI.RawUI.WindowSize.Width) - $Addition.Length - 1
	if ($Space -lt 0) {
		$Space += $host.UI.RawUI.WindowSize.Width
		if ($host.UI.RawUI.WindowSize.Width -lt $host.UI.RawUI.MaxWindowSize.Width) { 
			$Space += ($host.UI.RawUI.MaxWindowSize.Width - $host.UI.RawUI.WindowSize.Width)
		}
	}

	Write-Host ('─' * $host.UI.RawUI.MaxWindowSize.Width) -ForegroundColor DarkGray -BackgroundColor Black -NoNewline
	Write-Host $Status -ForegroundColor Black -BackgroundColor White -NoNewline
	Write-Host $Location -ForegroundColor White -BackgroundColor Black -NoNewline
	Write-Host (' ' * $Space) -ForegroundColor Black -BackgroundColor Black -NoNewline
	Write-Host $Addition -ForegroundColor White -BackgroundColor Black
	Write-Host ("`u{25ba}" * ($NestedPromptLevel + 1)) -ForegroundColor White -BackgroundColor Black -NoNewline
	return ' '
}