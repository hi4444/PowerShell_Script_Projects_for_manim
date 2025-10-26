# -------------------------
# Locate manim.exe (manual selection with multiple cached paths)
# -------------------------
$cacheDir = Join-Path $env:USERPROFILE\AppData\Local "Manim_Cache"
$cacheFile = Join-Path $cacheDir "manim_paths.txt"
$manimPath = $null

if (-not (Test-Path $cacheDir)) { New-Item -ItemType Directory -Path $cacheDir | Out-Null }

$cachedPaths = @()
if (Test-Path $cacheFile) { $cachedPaths = Get-Content $cacheFile | Where-Object { Test-Path $_ } }

# -------------------------
# Select manim.exe path
# -------------------------
function Select-ManimPath {
    param([string[]]$cachedPaths)

    $manualLabel = "Enter a new path manually"
    $index = 0
    $totalOptions = $cachedPaths.Count
    $doneSelection = $false
    $manimPathLocal = $null

    while (-not $doneSelection) {
        Clear-Host
        Write-Host "`nSelect a manim.exe path:`n"

        for ($i = 0; $i -lt $totalOptions; $i++) {
            if ($i -eq $index) { 
                Write-Host ("--> {0}" -f $cachedPaths[$i]) -ForegroundColor White
            } else {
                Write-Host ("    {0}" -f $cachedPaths[$i]) -ForegroundColor Cyan
            }
        }

        if ($index -eq $totalOptions) { 
            Write-Host "--> $manualLabel" -ForegroundColor White
        } else {
            Write-Host "    $manualLabel" -ForegroundColor Gray
        }

        Write-Host "`nUse TAB to move, ENTER to select."
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

        switch ($key.VirtualKeyCode) {
            9 { $index = ($index + 1) % ($totalOptions + 1) } # TAB
            13 {
                if ($index -eq $totalOptions) {
                    $manualPath = Read-Host "Enter the full path to manim.exe"
                    if (Test-Path $manualPath) {
                        $manimPathLocal = $manualPath
                        if ($cachedPaths -notcontains $manimPathLocal) {
                            $cachedPaths += $manimPathLocal
                            Set-Content -Path $cacheFile -Value $cachedPaths
                        }
                        $doneSelection = $true
                    } else {
                        Write-Host "Invalid path. Press any key to try again."
                        $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                    }
                } else {
                    $manimPathLocal = $cachedPaths[$index]
                    $doneSelection = $true
                }
            }
        }
    }

    Clear-Host
    Write-Host "`nUsing manim.exe path: $manimPathLocal`n"
    return $manimPathLocal
}

# Call the function to select manim.exe path
$manimPath = Select-ManimPath -cachedPaths $cachedPaths

# -------------------------
# Define Select-Option
# -------------------------
function Select-Option($prompt, $options) {
    $index = 0
    Write-Host "$prompt (TAB to cycle, ENTER to confirm):"
    do {
        Write-Host -NoNewline "`rSelected: $( $options[$index] ) "
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if ($key.VirtualKeyCode -eq 9) { $index = ($index + 1) % $options.Count } # TAB
    } until ($key.VirtualKeyCode -eq 13) # ENTER
    Write-Host ""
    return $options[$index]
}

# -------------------------
# Options list
# -------------------------
$optionsList = @(
    # Global
    @{Arg='--config_file'; Desc='Specify config file'; NeedsValue=$true; Example='--config_file myconfig.cfg'; Category='Global'},
    @{Arg='--custom_folders'; Desc='Use custom folders'; NeedsValue=$false; Example='--custom_folders'; Category='Global'},
    @{Arg='--disable_caching'; Desc='Disable caching'; NeedsValue=$false; Example='--disable_caching'; Category='Global'},
    @{Arg='--flush_cache'; Desc='Remove cached files'; NeedsValue=$false; Example='--flush_cache'; Category='Global'},
    @{Arg='--tex_template'; Desc='Custom TeX template'; NeedsValue=$true; Example='--tex_template mytemplate.tex'; Category='Global'},
    @{Arg='--verbosity'; Desc='CLI verbosity'; NeedsValue=$true; Example='--verbosity debug'; Category='Global'},
    @{Arg='--notify_outdated_version'; Desc='Warn if outdated'; NeedsValue=$false; Example='--notify_outdated_version'; Category='Global'},
    @{Arg='--silent'; Desc='Suppress warnings'; NeedsValue=$false; Example='--silent'; Category='Global'},
    @{Arg='--enable_gui'; Desc='Enable GUI'; NeedsValue=$false; Example='--enable_gui'; Category='Global'},
    @{Arg='--gui_location'; Desc='GUI start location'; NeedsValue=$true; Example='--gui_location 100,100'; Category='Global'},
    @{Arg='--fullscreen'; Desc='Expand window'; NeedsValue=$false; Example='--fullscreen'; Category='Global'},
    @{Arg='--enable_wireframe'; Desc='Wireframe debug'; NeedsValue=$false; Example='--enable_wireframe'; Category='Global'},
    @{Arg='--force_window'; Desc='Force window open'; NeedsValue=$false; Example='--force_window'; Category='Global'},
    @{Arg='--dry_run'; Desc='Render without output'; NeedsValue=$false; Example='--dry_run'; Category='Global'},
    @{Arg='--no_latex_cleanup'; Desc='Keep LaTeX files'; NeedsValue=$false; Example='--no_latex_cleanup'; Category='Global'},
    @{Arg='--preview_command'; Desc='Command to preview'; NeedsValue=$true; Example='--preview_command vlc'; Category='Global'},

    # Output
    @{Arg='--output_file'; Desc='Output filename'; NeedsValue=$true; Example='--output_file scene.mp4'; Category='Output'},
    @{Arg='--zero_pad'; Desc='Zero padding for PNGs'; NeedsValue=$true; Example='--zero_pad 3'; Category='Output'},
    @{Arg='--write_to_movie'; Desc='Write video to file'; NeedsValue=$false; Example='--write_to_movie'; Category='Output'},
    @{Arg='--media_dir'; Desc='Media directory'; NeedsValue=$true; Example='--media_dir ./media'; Category='Output'},
    @{Arg='--log_dir'; Desc='Log directory'; NeedsValue=$true; Example='--log_dir ./logs'; Category='Output'},
    @{Arg='--log_to_file'; Desc='Log to file'; NeedsValue=$false; Example='--log_to_file'; Category='Output'},

    # Render
    @{Arg='--from_animation_number'; Desc='Start from animation'; NeedsValue=$true; Example='--from_animation_number 2'; Category='Render'},
    @{Arg='--write_all'; Desc='Render all scenes'; NeedsValue=$false; Example='--write_all'; Category='Render'},
    @{Arg='--format'; Desc='Output format'; NeedsValue=$true; Example='--format mp4'; Category='Render'},
    @{Arg='--save_last_frame'; Desc='Save last frame'; NeedsValue=$false; Example='--save_last_frame'; Category='Render'},
    @{Arg='--quality'; Desc='Render quality'; NeedsValue=$true; Example='--quality h'; Category='Render'},
    @{Arg='--resolution'; Desc='Resolution WxH'; NeedsValue=$true; Example='--resolution 1920x1080'; Category='Render'},
    @{Arg='--fps'; Desc='Frame rate'; NeedsValue=$true; Example='--fps 60'; Category='Render'},
    @{Arg='--renderer'; Desc='Renderer'; NeedsValue=$true; Example='--renderer opengl'; Category='Render'},
    @{Arg='--save_sections'; Desc='Save section videos'; NeedsValue=$false; Example='--save_sections'; Category='Render'},
    @{Arg='--transparent'; Desc='Render with alpha'; NeedsValue=$false; Example='--transparent'; Category='Render'},
    @{Arg='--use_projection_fill_shaders'; Desc='Use fill shaders'; NeedsValue=$false; Example='--use_projection_fill_shaders'; Category='Render'},
    @{Arg='--use_projection_stroke_shaders'; Desc='Use stroke shaders'; NeedsValue=$false; Example='--use_projection_stroke_shaders'; Category='Render'},

    # Ease
    @{Arg='--progress_bar'; Desc='Display progress bars'; NeedsValue=$true; Example='--progress_bar display'; Category='Ease'},
    @{Arg='--preview'; Desc='Preview scene animation'; NeedsValue=$false; Example='--preview'; Category='Ease'},
    @{Arg='--show_in_file_browser'; Desc='Show file browser'; NeedsValue=$false; Example='--show_in_file_browser'; Category='Ease'},
    @{Arg='--jupyter'; Desc='Using Jupyter magic'; NeedsValue=$false; Example='--jupyter'; Category='Ease'}
)

# -------------------------
# Function: Horizontal multi-select with TAB and Next/Done
# -------------------------
function Select-Options-Done {
    param([ref]$optionsList)

    $selectedArgs = @()
    $categories = @('Global','Output','Render','Ease')
    $catColors = @{ Global='Cyan'; Output='Green'; Render='Yellow'; Ease='Magenta' }

    for ($c = 0; $c -lt $categories.Count; $c++) {
        $cat = $categories[$c]
        $catOptions = $optionsList.Value | Where-Object { $_.Category -eq $cat }
        $index = 0
        $totalOptions = $catOptions.Count
        $isLastCategory = ($c -eq $categories.Count - 1)
        $doneCategory = $false

        while (-not $doneCategory) {
            Clear-Host
            Write-Host "`n$cat options:" -ForegroundColor $catColors[$cat]

            for ($i = 0; $i -lt $totalOptions; $i++) {
                $arg = $catOptions[$i].Arg
                $mark = if ($selectedArgs -contains $arg) { '[x]' } else { '[ ]' }
                if ($i -eq $index) { Write-Host ("--> $mark $arg") -ForegroundColor White }
                else { Write-Host ("    $mark $arg") -ForegroundColor $catColors[$cat] }
            }

            $buttonLabel = if ($isLastCategory) { "[Done]" } else { "[Next Category]" }
            $buttonIndex = $totalOptions
            if ($index -eq $buttonIndex) { Write-Host "--> $buttonLabel" -ForegroundColor White }
            else { Write-Host "    $buttonLabel" -ForegroundColor Gray }

            Write-Host "`nUse TAB to move, ENTER to toggle/select, highlight button to continue."
            $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

            switch ($key.VirtualKeyCode) {
                9 { $index = ($index + 1) % ($totalOptions + 1) } # TAB
                13 {
                    if ($index -eq $buttonIndex) { $doneCategory = $true; break }
                    $arg = $catOptions[$index].Arg
                    if ($selectedArgs -contains $arg) { $selectedArgs = $selectedArgs | Where-Object { $_ -ne $arg } }
                    else { $selectedArgs += $arg }
                }
            }
        }
        Clear-Host
    }

    $finalArgs = @()
    foreach ($arg in $selectedArgs) {
        $opt = $optionsList.Value | Where-Object { $_.Arg -eq $arg } | Select-Object -First 1
        if ($opt.NeedsValue) {
            switch ($arg) {
                '--quality' {$val = Select-Option "Select quality for $arg" @('l','m','h','p','k')}
                '--renderer' {$val = Select-Option "Select renderer for $arg" @('cairo','opengl')}
                '--format' {$val = Select-Option "Select format for $arg" @('mp4','gif','png','webm','mov')}
                default {$val = Read-Host "Enter value for $arg (Example: $($opt.Example))"}
            }
            $finalArgs += $arg
            $finalArgs += $val
        } else {
            $finalArgs += $arg
        }
    }
    return $finalArgs
}

# -------------------------
# Mode selection
# -------------------------
$mode = Select-Option "Select mode:" @('Menu','Manual','Custom')

if ($mode -eq 'Manual') {
    Write-Host "`nManual mode selected."
    $pyFileBase = Read-Host 'Enter Python file name (without extension)'
    $pyFile = "$pyFileBase.py"
    $scene = Read-Host 'Enter class/scene name'

    $args = Select-Options-Done ([ref]$optionsList)
    $args += $pyFile
    $args += $scene

    Write-Host "`nRunning (manual): `"$manimPath`" $( $args -join ' ' )"
    & "$manimPath" @args
    exit 0
}
elseif ($mode -eq 'Custom') {
    Write-Host "`nCustom mode selected."

    # Ask for Python file and optional scene
    $pyFileBase = Read-Host 'Enter Python file name (without extension)'
    $pyFile = "$pyFileBase.py"
    $scene = Read-Host 'Optional class/scene name (press Enter to skip)'

    Write-Host "`nAvailable arguments and examples:`n"

    $catColors = @{ Global='Cyan'; Output='Green'; Render='Yellow'; Ease='Magenta' }
    $categories = @('Global','Output','Render','Ease')

    foreach ($cat in $categories) {
        $catOptions = $optionsList | Where-Object { $_.Category -eq $cat }
        if ($catOptions.Count -gt 0) {
            Write-Host "$cat arguments:" -ForegroundColor $catColors[$cat]

            # Calculate max argument width
            $maxArgLen = ($catOptions | ForEach-Object { $_.Arg.Length } | Measure-Object -Maximum).Maximum + 2

            foreach ($opt in $catOptions) {
                $line = "{0,-$maxArgLen} (Example: {1})" -f $opt.Arg, $opt.Example
                Write-Host $line -ForegroundColor $catColors[$cat]
            }

            Write-Host ""  # Only one empty line between categories
        }
    }

    # Read input and split while preserving quoted arguments
    $userArgs = Read-Host "`nType your custom arguments separated by spaces (use quotes if needed)"
    $argsArray = [regex]::Matches($userArgs, '(?<=^| )("[^"]*"|''[^'']*''|\S+)') | ForEach-Object {
        $_.Value.Trim('"').Trim("'")
    }

    # Add the required file and optional scene to arguments
    $argsArray = $argsArray + $pyFile
    if ($scene -ne '') { $argsArray += $scene }

    Write-Host "`nRunning (custom): `"$manimPath`" $($argsArray -join ' ')"
    & "$manimPath" @argsArray
    exit 0
}
# -------------------------
# Menu Mode
# -------------------------
$pyFileBase = Read-Host 'Enter Python file name (without extension)'
$pyFile = "$pyFileBase.py"
$scene = Read-Host 'Optional class name (press Enter to skip)'

$useP = Select-Option "Include -p flag?" @('No','Yes')
$qualityOptions = @('-ql','-qm','-qh','-qp','-qk')
$qualitySelected = Select-Option "Select quality" $qualityOptions
$rendererSelected = Select-Option "Select renderer:" @('cairo','opengl')
$renderer = "--renderer=$rendererSelected"
$fpsYN = Select-Option "Set --fps?" @('No','Yes')
$formatYN = Select-Option "Use --format?" @('No','Yes')
$writeYN = Select-Option "Use --write_to_movie?" @('No','Yes')
$fullscreenYN = Select-Option "Use --fullscreen?" @('No','Yes')

$fps = @(); if ($fpsYN -eq 'Yes') { $fpsNumber = Read-Host 'Enter FPS number'; $fps = @('--fps',$fpsNumber) }
$format = @(); if ($formatYN -eq 'Yes') { $formatSelected = Select-Option 'Select format type' @('mp4','gif','png','webm','mov'); $format = @('--format',$formatSelected) }
$writeToMovie = if ($writeYN -eq 'Yes') { @('--write_to_movie') } else { @() }
$fullscreen = if ($fullscreenYN -eq 'Yes') { @('--fullscreen') } else { @() }

$args = @()
if ($useP -eq 'Yes') { $args += '-p' }
$args += $qualitySelected
$args += $format
$args += $renderer
$args += $fps
$args += $writeToMovie
$args += $fullscreen
$args += $pyFile
$args += $scene
$args = $args | Where-Object { $_ -ne $null -and $_ -ne '' }

Write-Host "`nRunning: `"$manimPath`" $( $args -join ' ' )"
& "$manimPath" @args