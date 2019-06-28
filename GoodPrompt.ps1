<#----------------------------------------------------------------------------#
 # GoodPrompt                                                                 #
 # Version 1.1                                                                #
 # Copyright (C) Saleh Rahimzadeh                                             #
 # https://github.com/saleh-rahimzadeh/GoodPrompt                             #
 #----------------------------------------------------------------------------#>

function Prompt {
	<# Preparing details and information of prompt as a data dictionary #>
	$data = @{
		Path = '{0} {1}>' -f "`u{2592}",$($ExecutionContext.SessionState.Path.CurrentLocation);
		Status = '{0}{1} {2} {3} ' -f $(if (test-path variable:/PSDebugContext) { '[DBG] {0} ' -f "`u{2502}" } else { '' }), (get-date -uformat %r), "`u{2502}", $MyInvocation.HistoryId;
		Bar = "`u{258c}";
		Prompt = "`u{25ba}" * ($NestedPromptLevel + 1);
	}

	<# Calculating remained space to draw separator bar #>
	$space = $host.UI.RawUI.WindowSize.Width - (($data.Path.Length + $data.Bar.Length) % $host.UI.RawUI.WindowSize.Width) - $data.Status.Length
	if ($space -lt 0) {
		$space += $host.UI.RawUI.WindowSize.Width
	}
	$data.Bar += ' ' * $space

	<# Display prompt #>
	Write-Host $data.Path   -ForegroundColor Black -BackgroundColor White -NoNewline
	Write-Host $data.Bar    -ForegroundColor Black -BackgroundColor DarkGray -NoNewLine
	Write-Host $data.Status -ForegroundColor White -BackgroundColor DarkGray -NoNewLine
	Write-Host $data.Prompt -ForegroundColor White -NoNewLine
	return ' '
}
