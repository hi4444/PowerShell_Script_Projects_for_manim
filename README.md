# PowerShell Scripts for manim

[![GitHub stars](https://img.shields.io/github/stars/hi4444/Manim-Utility-Projects?style=social)](https://github.com/hi4444/Manim-Utility-Projects/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/hi4444/Manim-Utility-Projects)](https://github.com/hi4444/Manim-Utility-Projects/issues)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/hi4444/Manim-Utility-Projects/blob/main/LICENSES)

> A collection of scripts and utilities designed to simplify and automate **Manim** workflows and project management.

---

## About

This repository includes a set of scripts and tools to streamline **Manim** project automation.  
All utilities are designed to be user-friendly and suitable for both beginners and advanced users.

### Supported Platforms
- **Operating System:** Windows only

### Supported IDEs
- [PyCharm](https://www.jetbrains.com/pycharm/download/?section=windows)  
- [Visual Studio Code](https://code.visualstudio.com/download)

---

## Utils / Script List

### 1. Automation/GUI PowerShell Script
Currently **not compatible** with the PowerShell application inside **Windows Terminal** (crashes on use).  
Works only in IDE-integrated PowerShell terminals such as **Visual Studio Code** or **PyCharm**.  
Support for Windows Terminal may be added in the future.

This script allows you to run **Manim projects** automatically through a **GUI** with various customization options.

---

## PyCharm Requirements
- **Required Extension:** [PowerShell Plugin](https://plugins.jetbrains.com/plugin/10249-powershell)

---

## VS Code Requirements
- **PowerShell Version:** 7.0 or higher  
- **Required Extensions:**  
  - [Code Runner (by Jun Han)](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)  
  - [PowerShell (by Microsoft)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)  
- **Optional Extension:**  
  - [Terminal Zoom (by trybick)](https://marketplace.visualstudio.com/items?itemName=trybick.terminal-zoom) – improves terminal UI navigation.

---

## Installation

Download the latest release from the [Releases Section](https://github.com/hi4444/Manim-Utility-Projects/releases).

---

## Setup Guide (Run/Debug Configuration)

Follow these steps to set up and run Manim_Run.ps1 in your IDE.

### Visual Studio Code Setup
Ensure **Code Runner**, the **PowerShell extension**, and **PowerShell 7+** are installed.

1. Press **Windows + R** to open the Run dialog.  
2. Enter the following path to open VS Code’s settings.json file:  
```
%appdata%\Code\User\settings.json
```

3. Go to the last line and remove the closing bracket `}`.  
4. Copy and Paste the following into the line you just made and indent it Properly.
```json
  ,"launch": {
    "version": "0.2.0",
    "configurations": [
      {
        "name": "Run Manim",
        "type": "PowerShell",
        "request": "launch",
        "script": "",  // Find and copy the full path to your Manim_Run.ps1 file inside the qoutes — Replace the backslashes (\) with forward slashes (/)
        "args": [],
        "cwd": "${workspaceFolder}"
      }
    ],
    "compounds": []
  }
}

```
5. Save the file. 
Their might be a notification asking to OverWrite so you can save. If you get that click OverWrite otherwise it will not save. 
Then if you press f5 it will run the script.

If you get a Excution policy error

Run PowerShell as admin and Copy and paste the code below.

`Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force`
When prompted, type A and press Enter.
Do the Exact same for PowerShell 7 as well

If issues persist, open Settings → System → Advanced → expand the PowerShell section → enable/Turn on

“Allow local PowerShell scripts to run without signing. Require signing for remote scripts.”
___
### PyCharm Setup
1. Open your project containing `Manim_Run.ps1` in PyCharm.  
2. Go to **Run → Edit Configurations**.  
3. Click the **+** icon → select **Shell Script**.  
4. Configure the following:
   - **Name:** `Run Manim`
   - **Script path:** Full path to `Manim_Run.ps1` If it pastes with BackSlashes (/) replace them with Forward slashes (/)
     Example: `C:\Users\YourName\Documents\Manim_Run.ps1`
   - Remove the Interpreter path / leave blank
5. Click **Apply** and then **OK**.  
6. Select the new configuration and press **Shift + F10** (or the green play button) to run the script.

**Note:** Make sure your execution policy allows running local PowerShell scripts. If needed, run PowerShell as Administrator:

```
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force
```
When prompted, type A and press Enter.
Do the Exact same for PowerShell 7 as well

If issues persist, open Settings → System → Advanced → expand the PowerShell section → enable/Turn on
---

## Tips & Notes
| Tip             | Details                                                                                      |
| --------------- | -------------------------------------------------------------------------------------------- |
| Reset paths     | Press Windows + R, enter `%localappdata%\Manim_Cache`, and delete `manim_paths.txt`.<br>To remove a single path, Open up the txt file and remove the path and save. Use this if Manim or Python paths are no longer valid or were entered incorrectly. |
| Fix visuals     | Resize the PowerShell window if colors or alignment appear incorrect.                        |
| Recommended     | Use PowerShell 7+ (also compatible with Windows PowerShell 5.1).                             |

**Note:** The GUI provides a structured interface with clear categories for easy navigation and configuration.

---

## Preview: Manual Mode Picture outdated.
![Preview](https://github.com/hi4444/Manim-Utility-Projects/raw/main/Previews_images/Preview_Manual.png) This has been redone to be vertical and also use tab selection instead of numbers. 

## Preview: Menu Mode
![Preview](https://github.com/hi4444/Manim-Utility-Projects/raw/main/Previews_images/Preview_Menu.png)
