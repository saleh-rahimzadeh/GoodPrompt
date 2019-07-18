<#----------------------------------------------------------------------------#
 # GoodPrompt                                                                 #
 # Version 1.3                                                                #
 # Copyright (C) Saleh Rahimzadeh                                             #
 # https://github.com/saleh-rahimzadeh/GoodPrompt                             #
 #----------------------------------------------------------------------------#>

function Prompt {
	<# Preparing details and information of prompt #>
	$Location = '{0} {1}>' -f "`u{2592}",$($ExecutionContext.SessionState.Path.CurrentLocation);
	$Status = '{0}{1} {2} {3} ' -f $(if (Test-Path variable:/PSDebugContext) { '[DBG] {0} ' -f "`u{2502}" } else { '' }), (get-date -uformat %r), "`u{2502}", $MyInvocation.HistoryId;
	$Bar = "`u{258c}";
	$Cursor = $(if ($host.UI.RawUI.WindowSize.Width -lt $host.UI.RawUI.MaxWindowSize.Width) { "`n" } else { '' }) + "`u{25ba}" * ($NestedPromptLevel + 1);

	<# Calculating remained space to draw separator bar #>
	$Space = $host.UI.RawUI.WindowSize.Width - (($Location.Length + $Bar.Length) % $host.UI.RawUI.WindowSize.Width) - $Status.Length
	if ($Space -lt 0) {
		$Space += $host.UI.RawUI.WindowSize.Width
		if ($host.UI.RawUI.WindowSize.Width -lt $host.UI.RawUI.MaxWindowSize.Width) { 
			$Space += ($host.UI.RawUI.MaxWindowSize.Width - $host.UI.RawUI.WindowSize.Width)
		}
	}
	$Bar += ' ' * $Space

	<# Display prompt #>
	Write-Host $Location -ForegroundColor Black -BackgroundColor White -NoNewline
	Write-Host $Bar      -ForegroundColor Black -BackgroundColor DarkGray -NoNewline
	Write-Host $Status   -ForegroundColor White -BackgroundColor DarkGray -NoNewline
	Write-Host $Cursor   -ForegroundColor White -NoNewline
	return ' '
}
