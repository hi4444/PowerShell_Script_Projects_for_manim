# 🤝 Contributing to Manim Utility Projects

Welcome, developer! 🎬  
We’re thrilled that you’re interested in improving **Manim Utility Projects** — a collection of automation tools and PowerShell scripts designed to make Manim workflows smoother, faster, and friendlier.

This guide explains everything you need to know about setting up, coding, testing, and submitting contributions.

---

## 📘 Table of Contents
1. [Project Overview](#-project-overview)
2. [Getting Started](#-getting-started)
3. [Development Workflow](#-development-workflow)
4. [Code Guidelines](#-code-guidelines)
5. [Testing Your Changes](#-testing-your-changes)
6. [Adding New CLI Options](#-adding-new-cli-options)
7. [Documentation Standards](#-documentation-standards)
8. [Commit Conventions](#-commit-conventions)
9. [Pull Request Process](#-pull-request-process)
10. [Reporting Issues](#-reporting-issues)
11. [Community Rules](#-community-rules)
12. [Resources](#-resources)

---

## 🧩 Project Overview

**Manim Utility Projects** provides a suite of PowerShell tools that automate rendering tasks for [Manim Community Edition](https://github.com/ManimCommunity/manim).  
The flagship script, `Manim_Run.ps1`, is a powerful wrapper for `manim.exe` that:

- Automatically locates and caches the `manim.exe` executable.  
- Provides an **interactive menu** for selecting render options and flags.  
- Simplifies command-line complexity for both beginners and advanced Manim users.  
- Supports both **Menu mode** (guided) and **Manual mode** (custom argument builder).

Your contributions help keep these tools current, reliable, and easy to use across different Manim setups.

---

## 🧰 Getting Started

### 1. Fork and Clone

Fork the repository and clone it to your local machine:

```bash
git fork https://github.com/hi4444/Manim-Utility-Projects.git
git clone https://github.com/<your-username>/Manim-Utility-Projects.git
cd Manim-Utility-Projects
