# 🧩 Manim Utility Projects

[![GitHub stars](https://img.shields.io/github/stars/hi4444/Manim-Utility-Projects?style=social)](https://github.com/hi4444/Manim-Utility-Projects/stargazers) [![GitHub issues](https://img.shields.io/github/issues/hi4444/Manim-Utility-Projects)](https://github.com/hi4444/Manim-Utility-Projects/issues) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/hi4444/Manim-Utility-Projects/blob/main/LICENSES)

> A collection of scripts and utilities to simplify **Manim** workflows.

---

## 📌 About
This repository contains a variety of scripts and tools to automate Manim projects, including:

- **AutoRunner PowerShell script** for running Manim scripts automatically with many new features
- **Changelog management** for tracking updates  
- Scripts suitable for both **beginners** and **advanced users**  

---

## ✨ Features

| Feature      | Description |
|-------------|-------------|
| AutoRunner   | Run Manim scripts automatically via PowerShell |
| Changelog    | Track updates and version history |
| Easy Scripts | Beginner-friendly scripts with clear instructions |
| Additional Features | - Run Manim via a **Run** button<br>- **Automatically find the manim.exe path** and store it for future use<br>- Input the name of the Python file without the `.py` extension<br>- Optionally specify the Class/Scene you want to run<br>- Use the **Tab** button to cycle through options for quick selection |

---

## 💻 Installation
- Works for [PyCharm](https://www.jetbrains.com/pycharm/download/?section=windows) 
- Get the [ PowerShell extension for PyCharm](https://plugins.jetbrains.com/plugin/10249-powershell) 
- Works for [VS Code](https://code.visualstudio.com/download)
#### Does **not** work with PowerShell terminal yet (crashes on use, Support is planned)
## Download the file from [releases](https://github.com/hi4444/Manim-Utility-Projects/releases)

---

## ⚡ Setup Guide for Debug / Run Configuration

Follow these steps to run `Manim_Run.ps1` in your IDE:

| Step | VS Code Setup | | PyCharm Setup |
| ---- | ------------- | - | ------------- |
| **1. Add Debug / Run Configuration** | Create or edit `.vscode/launch.json` and add the configuration below: | | Go to **Run → Edit Configurations → + → PowerShell**, set **Script path** to `Manim_Run.ps1`, **Working directory** to your project folder, and leave **Interpreter path** blank. |
| | ``` { "version": "0.2.0", "configurations": [ { "name": "Run Manim Script", "type": "PowerShell", "request": "launch", "script": "${workspaceFolder}/Manim_Run.ps1", "args": [], "cwd": "${workspaceFolder}", "console": "integratedTerminal" } ] } ``` | | — |
| **2. Let It Find Manim** | Script searches for `manim.exe`. If not found, type/paste full path. Path cached in `.manim_path.txt`. | | Same behavior: script finds `manim.exe` or prompts for path. Cache saved in `.manim_path.txt`. |
| **3. Select Options** | Options grouped by **Global (🌀), Output (💾), Render (🧱), Ease (⚡)**. Type number to toggle, `0` to finish category. FPS/format prompt for values. Color-coded interface highlights current category. | | Same interactive selection in PowerShell console. Categories and prompts identical. |
| **4. Preview Command** | Full Manim command displayed for review. | | Command preview identical. |
| **5. Run and Render** | Confirm to start. PowerShell shows progress bars, logs. Output saved in `./media/`. | | Same behavior in PyCharm console. |
| **6. Run Again** | Cached path used automatically. Jump straight into option selection. | | Identical behavior: skip rescanning. |
---

## 💼 Example Use Cases

| Task                            | Example                                  |
| ------------------------------- | ---------------------------------------- |
| Quick preview                   | Low-quality test renders                 |
| High-quality render with Opengl | `--quality p --renderer opengl`          |
| GIF output                      | `--format gif`                           |
| Combined options                | `--fps 60 --fullscreen --write_to_movie` |

---

## 🧠 Tips & Notes

| Tip               | Details                                                               |
| ----------------- | --------------------------------------------------------------------- |
| Customize options | Update `$optionsList` array for new Manim versions                    |
| Reset path        | Delete `.manim_path.txt` if Manim moves or Python environment changes |
| Fix visuals       | Resize PowerShell window if colors/alignment glitch                   |
| Recommended       | PowerShell 7+ (also works on Windows PowerShell 5.1)                  |

✨ **Pro Tip:** Emojis and inline color-coded categories make the interface easy to navigate and visually appealing while using the script.

---

## 📸 Preview of Manual mode

![Preview](https://github.com/hi4444/Manim-Utility-Projects/raw/main/Previews_images/Preview_Manual.png)

## 📸 Preview of Menu mode
![Preview](https://github.com/hi4444/Manim-Utility-Projects/raw/main/Previews_images/Preview_Menu.png)
