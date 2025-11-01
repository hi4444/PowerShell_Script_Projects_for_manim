# -------------------------
# Locate manim.exe (manual selection with multiple cached paths)
# -------------------------
$cacheDir = "$env:LOCALAPPDATA\Manim_Cache"
$cacheFile = Join-Path $cacheDir "manim_paths.txt"
$manimPath = $null

if (-not (Test-Path $cacheDir)) { New-Item -ItemType Directory -Path $cacheDir | Out-Null }

$cachedPaths = @()
if (Test-Path $cacheFile) { $cachedPaths = Get-Content $cacheFile | Where-Object { Test-Path $_ } }

# -------------------------
# Select manim.exe patha
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
                Write-Host ("--> {0}" -f $cachedPaths[$i]) -ForegroundColor Blue
            } else {
                Write-Host ("    {0}" -f $cachedPaths[$i]) -ForegroundColor White
            }
        }
        if ($index -eq $totalOptions) {
            Write-Host "--> $manualLabel" -ForegroundColor Blue
        } else {
            Write-Host "    $manualLabel" -ForegroundColor White
        }

        Write-Host "`nUse UP/DOWN or W/S or TAB to move, ENTER to select."
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        switch ($key.VirtualKeyCode) {
            9   { $index = ($index + 1) % ($totalOptions + 1) }   # TAB
            38  { $index = ($index - 1 + $totalOptions + 1) % ($totalOptions + 1) } # UP arrow
            40  { $index = ($index + 1) % ($totalOptions + 1) }   # DOWN arrow
            87  { $index = ($index - 1 + $totalOptions + 1) % ($totalOptions + 1) } # W
            83  { $index = ($index + 1) % ($totalOptions + 1) }   # S
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

$manimPath = Select-ManimPath -cachedPaths $cachedPaths

# -------------------------
# Utility: Select from options (single selection)
# -------------------------
function Select-Option($prompt, $options) {
    $index = 0
    $done = $false
    while (-not $done) {
        Clear-Host
        Write-Host "`n$prompt`n"
        for ($i = 0; $i -lt $options.Count; $i++) {
            if ($i -eq $index) {
                Write-Host ("--> {0}" -f $options[$i]) -ForegroundColor Blue
            } else {
                Write-Host ("    {0}" -f $options[$i]) -ForegroundColor White
            }
        }

        Write-Host "`nUse UP/DOWN or W/S or TAB to move, ENTER to select."
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        switch ($key.VirtualKeyCode) {
            9   { $index = ($index + 1) % $options.Count } # TAB
            38  { $index = ($index - 1 + $options.Count) % $options.Count } # UP
            40  { $index = ($index + 1) % $options.Count } # DOWN
            87  { $index = ($index - 1 + $options.Count) % $options.Count } # W
            83  { $index = ($index + 1) % $options.Count } # S
            13  { $done = $true } # ENTER
        }
    }

    Clear-Host
    Write-Host "`nSelected: $($options[$index])`n" -ForegroundColor Cyan
    return $options[$index]
}

# -------------------------
# Options list (all categories)
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
    @{Arg='--use_projection_fill_shaders'; Desc=''; NeedsValue=$false; Example='--use_projection_fill_shaders'; Category='Render'},
    @{Arg='--use_projection_stroke_shaders'; Desc=''; NeedsValue=$false; Example='--use_projection_stroke_shaders'; Category='Render'},

    # Ease
    @{Arg='--progress_bar'; Desc='Display progress bars'; NeedsValue=$true; Example='--progress_bar display'; Category='Ease'},
    @{Arg='--preview'; Desc='Preview scene animation'; NeedsValue=$false; Example='--preview'; Category='Ease'},
    @{Arg='--show_in_file_browser'; Desc='Show file browser'; NeedsValue=$false; Example='--show_in_file_browser'; Category='Ease'},
    @{Arg='--jupyter'; Desc='Using Jupyter magic'; NeedsValue=$false; Example='--jupyter'; Category='Ease'}
)

# -------------------------
# Function: Multi-select menu
# -------------------------
function Select-Options-Done {
    param([ref]$optionsList)
    $selectedArgs = @()
    $categories = @('Global','Output','Render','Ease')
    $catColors = @{ Global='Cyan'; Output='Green'; Render='Yellow'; Ease='Magenta' }

    foreach ($cat in $categories) {
        $catOptions = $optionsList.Value | Where-Object { $_.Category -eq $cat }
        if ($catOptions.Count -eq 0) { continue }
        $index = 0
        $doneCategory = $false

        while (-not $doneCategory) {
            Clear-Host
            Write-Host "`n$cat options:`n" -ForegroundColor $catColors[$cat]

            for ($i = 0; $i -lt $catOptions.Count; $i++) {
                $arg = $catOptions[$i].Arg
                $mark = if ($selectedArgs -contains $arg) { '[x]' } else { '[ ]' }

                if ($i -eq $index) {
                    $arrowField = ('{0,6}' -f '-->')
                    $line = "{0} {1} {2}" -f $arrowField, $mark, $arg
                    Write-Host $line -ForegroundColor White
                } else {
                    $arrowField = ('{0,2}' -f '')
                    $line = "{0} {1} {2}" -f $arrowField, $mark, $arg
                    Write-Host $line -ForegroundColor $catColors[$cat]
                }
            }

            # Next category button
            $buttonIndex = $catOptions.Count
            $arrowField = if ($index -eq $buttonIndex) { '{0,6}' -f '-->' } else { '{0,2}' -f '' }
            $color = if ($index -eq $buttonIndex) { 'White' } else { 'Gray' }
            Write-Host ("{0} [Next Category]" -f $arrowField) -ForegroundColor $color

            Write-Host "`nUse UP/DOWN or W/S or TAB to move, ENTER to toggle/select, highlight button to continue."
            $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            switch ($key.VirtualKeyCode) {
                9   { $index = ($index + 1) % ($catOptions.Count + 1) } # TAB
                38  { $index = ($index - 1 + $catOptions.Count + 1) % ($catOptions.Count + 1) } # UP
                40  { $index = ($index + 1) % ($catOptions.Count + 1) } # DOWN
                87  { $index = ($index - 1 + $catOptions.Count + 1) % ($catOptions.Count + 1) } # W
                83  { $index = ($index + 1) % ($catOptions.Count + 1) } # S
                13  {
                    if ($index -eq $buttonIndex) {$doneCategory = $true } else {$arg = $catOptions[$index].Arg
                        if ($selectedArgs -contains $arg) {
                            $selectedArgs = @($selectedArgs | Where-Object { $_ -ne $arg }) # remove
                        } else {$selectedArgs += $arg }
                    }
                }
            }
        }
    }

    # Collect values for options that need them
    $finalArgs = @()
    foreach ($arg in $selectedArgs) {
        $opt = $optionsList.Value | Where-Object { $_.Arg -eq $arg } | Select-Object -First 1
        if ($opt.NeedsValue) {
            switch ($arg) {
                '--renderer' { $val = Select-Option "Select renderer for $arg" @('cairo','opengl') }
                '--format'   { $val = Select-Option "Select format for $arg" @('mp4','gif','png','webm','mov') }
                default      { $val = Read-Host "Enter value for $arg (Example: $($opt.Example))" }
            }
            $finalArgs += $arg; $finalArgs += $val
        } else {
            $finalArgs += $arg
        }
    }

    return $finalArgs
}
# -------------------------
# Mode selection
# -------------------------
$mode = Select-Option "Select mode:" @('Custom Menu','Manual Mode')

if ($mode -eq 'Custom Menu') {
    Write-Host "`nCustom Menu mode selected."

    $pyFileBase = Read-Host 'Enter Python file name (without extension)'
    $pyFile = "$pyFileBase.py"
    $scene = Read-Host 'Enter class/scene name'

    Write-Host "`nSelect render quality:`n"
    $quality = Select-Option "Choose render quality" @(
        'l (Low-480p) 720 x 480 Pixels',
        'm (Medium-720p) 1280 x 720 Pixels',
        'h (High-1080p ) 1920 x 1080 Pixels',
        'p (2K) 2560 x 1440 pixels',
        'k (4K) 4096 x 2160 pixels'
    )
    $qualityValue = $quality[0]
    $args = @('--quality', $qualityValue)

    $filteredList = [ref]($optionsList | Where-Object { $_.Arg -ne '--quality' })
    $extraArgs = Select-Options-Done $filteredList
    $args += $extraArgs
    $args += $pyFile
    $args += $scene

    Write-Host "`nRunning: `"$manimPath`" $( $args -join ' ' )"
    & "$manimPath" @args
    exit 0
}
# -------------------------
# Manual Mode
# -------------------------
Write-Host "`nManual Mode selected.`n"

# Step 1: Prompt for Python file and scene
$pyFileBase = Read-Host 'Enter Python file name (without extension)'
$pyFile = "$pyFileBase.py"
$scene = Read-Host 'Optional class/scene name (press Enter to skip)'

# Step 2: Prepare categories
$categories = @('Global','Output','Render','Ease')
$catColors = @{ Global='Cyan'; Output='Green'; Render='Yellow'; Ease='Magenta' }

# Collect arguments and descriptions per category
$catArgs = @{}
$catDesc = @{}
$maxRows = 0
$colWidths = @{ Arg=0; Desc=0 }

foreach ($cat in $categories) {
    $argsInCat = $optionsList | Where-Object { $_.Category -eq $cat } | ForEach-Object { $_.Arg }
    $descInCat = $optionsList | Where-Object { $_.Category -eq $cat } | ForEach-Object { $_.Desc }

    $catArgs[$cat] = $argsInCat
    $catDesc[$cat] = $descInCat

    if ($argsInCat.Count -gt $maxRows) { $maxRows = $argsInCat.Count }

    # Determine column widths
    $maxArgLength = ($argsInCat | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
    $maxDescLength = ($descInCat | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
    $colWidths['Arg'] = [Math]::Max(20, $maxArgLength + 5)
    $colWidths['Desc'] = [Math]::Max(30, $maxDescLength + 5)
}

# Step 3: Display category headers horizontally with color
for ($i = 0; $i -lt $categories.Count; $i++) {
    $cat = $categories[$i]
    Write-Host ("{0,-$($colWidths['Arg'])}{1,-$($colWidths['Desc'])}" -f ($cat + " Option"), "Description") -ForegroundColor $catColors[$cat] -NoNewline
}
Write-Host ""  # newline

# Step 4: Display arguments and descriptions row by row
for ($i = 0; $i -lt $maxRows; $i++) {
    for ($j = 0; $j -lt $categories.Count; $j++) {
        $cat = $categories[$j]
        $arg = if ($i -lt $catArgs[$cat].Count) { $catArgs[$cat][$i] } else { "" }
        $desc = if ($i -lt $catDesc[$cat].Count) { $catDesc[$cat][$i] } else { "" }
        Write-Host ("{0,-$($colWidths['Arg'])}{1,-$($colWidths['Desc'])}" -f $arg, $desc) -ForegroundColor $catColors[$cat] -NoNewline
    }
    Write-Host ""
}

# Step 5: Ask user to type custom arguments manually
$userArgs = Read-Host "`nType your custom arguments separated by spaces (use quotes if needed)"
$argsArray = [regex]::Matches($userArgs, '(?<=^| )("[^"]*"|''[^'']*''|\S+)') | ForEach-Object { $_.Value.Trim('"').Trim("'") }

# Step 6: Add Python file and optional scene
if ($pyFile -ne '') { $argsArray += $pyFile }
if ($scene -ne '') { $argsArray += $scene }

# Step 7: Run Manim
Write-Host "`nRunning: `"$manimPath`" $($argsArray -join ' ')"
& "$manimPath" @argsArray
exit 0