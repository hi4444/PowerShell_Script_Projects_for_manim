# 🧭 Manim AutoRunner PowerShell Script — Changelog

# 🗓️ [v1.0] – Initial Release  
# **Author:** `Capy` | **Date:** `10/24/25`

---

# 🧩 Overview
A Windows PowerShell helper script that detects `manim.exe`, builds safe command-line arguments via an interactive menu or manual mode, and runs Manim scenes with a single, reproducible flow.

---

# 🌟 Features

## Automatic manim.exe detection
- Caches discovered path to `$env:USERPROFILE\.manim_path.txt`
- Scans common locations: `.venv\Scripts`, `AppData\Local\Programs\Python`, typical `manimce` installs
- Smart `C:\` scan that excludes system folders (e.g., `Windows`, `Program Files`)
- Manual fallback prompt if `manim.exe` is not found

## Option selection & UX
- `Menu Mode` (visual) and `Manual Mode` (type file + scene)
- `TAB` cycles options; `ENTER` confirms
- Categories: `Global`, `Output`, `Render`, `Ease`
- Multi-select UI (`[ ]` / `[x]`) and support for key/value flags
- Prompts for required/missing values and auto-skips empty inputs

## Argument assembly & preview
- Builds full `manim.exe` command-line and previews before execution
- Supports flags: `-p`, `--fullscreen`, `--write_to_movie`, `--quality`, `--renderer`, `--format`

---

## 🐞 Fixes & Improvements
- Fixed `$quickPaths` array (missing commas and escaping issues)
- Corrected `switch` / `foreach` handling to avoid parsing glitches
- Improved multi-select logic and input parsing for menus
- Better menu alignment and smoother visual feedback
- Safer handling of RawUI input and invalid manual paths

---

## ⚙️ Notes & Requirements
- Requires **PowerShell 5.1+** (tested on PS7+)
- Designed for **Windows PowerShell / Windows Terminal**
- Extendable via the `$optionsList` array in the script
- Avoid WSL or plain `cmd` for interactive menus — use PowerShell host

---

## 🧰 PyCharm — Quick Setup (collapsible)
<details>
<summary>Show setup steps</summary>

1. Open **Run / Debug Configurations** → press <kbd>Alt</kbd> + <kbd>Insert</kbd>  
2. Select **Shell Script** → press <kbd>Enter</kbd>  
3. Name the configuration (e.g., `Manim Run`)  
4. Script Path → point to `Manim_Run.ps1`  
5. Interpreter Path → _(leave blank)_  
6. Working Directory → project folder  
7. Check **Execute in terminal**  
8. Apply → **OK ✅**

</details>

---

## ▶️ Quick Run Guide
1. Launch the `Manim Run` configuration in your IDE or run `Manim_Run.ps1` in PowerShell.  
2. Choose `Menu Mode` for guided selection or `Manual Mode` to type file + scene.  
3. Select options (use TAB to navigate, ENTER to confirm).  
4. Preview the assembled command, confirm, and run.  
5. Check console output for logs and rendered movie files.

---

## 🧪 Testing & Execution Tips
- Run inside your manim project directory to ensure paths resolve.  
- Test first with a small sample scene (short duration) to validate arguments & renderer.  
- If detection fails, use the manual path prompt — it will be cached for future runs.

---

## 🧠 Developer Notes
- Keep `$optionsList` readable — group flags by category and add metadata for `type` (`flag` / `kv`) to simplify UI generation.  
- Use the cached `.manim_path.txt` to avoid repeated disk scans; add a flag to force rescan when necessary.  
- Preserve command-preview readability (line-wrapped friendly) for easier automation and debugging.

---

## 💡 Preview
[![Preview](https://raw.githubusercontent.com/hi4444/Manim-Utility-Projects/main/Preview.png)](https://github.com/hi4444/Manim-Utility-Projects/blob/main/Preview.png)

---
