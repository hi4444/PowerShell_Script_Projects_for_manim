<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manim AutoRunner — README</title>
<style>
  :root{
    --bg:#0f1724; --card:#0b1220; --muted:#94a3b8; --accent:#60a5fa;
    --feat:#16a34a; --fix:#ef4444; --note:#2563eb; --setup:#7c3aed;
    color-scheme: dark;
  }
  body{
    font-family: "Segoe UI", Inter, sans-serif;
    margin:24px;
    background:var(--bg);
    color:#e6eef8;
    line-height:1.5;
  }
  .wrap{
    max-width:1000px;
    margin:0 auto;
  }
  header{
    display:flex;
    flex-direction:column;
    align-items:center;
    gap:8px;
    margin-bottom:24px;
    text-align:center;
  }
  h1{font-size:2rem;margin:0;}
  .meta{color:var(--muted); font-size:0.9rem;}
  .card{
    background:var(--card);
    border:1px solid rgba(255,255,255,0.05);
    padding:18px;
    border-radius:12px;
    margin-bottom:16px;
    box-shadow:0 4px 16px rgba(0,0,0,0.6);
  }
  h2{margin-top:0.2rem;}
  h3{margin-top:0.4rem;}
  .row{display:grid;grid-template-columns:1fr 1fr;gap:12px;}
  .badge{
    display:inline-block;
    padding:5px 10px;
    border-radius:8px;
    font-weight:700;
    font-size:0.85rem;
    color:white;
  }
  .feat{background:var(--feat);}
  .fix{background:var(--fix);}
  .note{background:var(--note);}
  .setup{background:var(--setup);}
  details{
    background:rgba(255,255,255,0.02);
    padding:10px;
    border-radius:8px;
    border-left:3px solid rgba(255,255,255,0.05);
  }
  summary{font-weight:700;cursor:pointer;}
  ul{margin:8px 0 8px 18px;}
  ol{margin:8px 0 8px 18px;}
  img{max-width:100%;border-radius:6px;border:1px solid rgba(255,255,255,0.03);}
  .preview{display:flex;flex-direction:column;align-items:center;gap:12px;text-align:center;}
  footer{color:var(--muted);font-size:0.85rem;margin-top:12px;text-align:center;}
  @media(max-width:800px){.row{grid-template-columns:1fr;}}
</style>
</head>
<body>
<div class="wrap">
  <header>
    <h1>🧭 Manim AutoRunner PowerShell Script</h1>
    <div class="meta">v1.0 • Author: Capy • PowerShell 5.1+ • Windows-focused</div>
  </header>

  <section class="card">
    <h2>🧩 Overview</h2>
    <p>A Windows PowerShell helper script that detects <code>manim.exe</code>, builds safe command-line arguments via interactive menus or manual mode, and runs Manim scenes in a single, reproducible flow.</p>
  </section>

  <section class="card row">
    <div>
      <div class="badge feat">FEATURES</div>
      <ul>
        <li>Automatic detection of <code>manim.exe</code> (caches path, scans venvs & installs, smart C:\ scan, manual fallback)</li>
        <li>Option selection: Menu & Manual modes, TAB navigation, categories, multi-select support</li>
        <li>Full command preview before execution</li>
      </ul>
    </div>
    <div>
      <div class="badge fix">FIXES & IMPROVEMENTS</div>
      <ul>
        <li>Fixed path array issues</li>
        <li>Corrected switch/foreach parsing</li>
        <li>Improved multi-select logic, menu alignment, and RawUI input handling</li>
      </ul>
    </div>
  </section>

  <section class="card row">
    <div>
      <div class="badge note">NOTES & REQUIREMENTS</div>
      <ul>
        <li>PowerShell 5.1+ recommended, tested on PS7+</li>
        <li>Designed for Windows PowerShell / Windows Terminal</li>
        <li>Extendable via <code>$optionsList</code></li>
      </ul>
    </div>
    <div>
      <div class="badge setup">PYCHARM SETUP</div>
      <details>
        <summary>Show setup steps</summary>
        <ol>
          <li>Run/Debug Configurations → Alt + Insert → Shell Script</li>
          <li>Name it (e.g., Manim Run) and set Script Path to <code>Manim_Run.ps1</code></li>
          <li>Leave Interpreter blank; set Working Directory; check Execute in terminal → OK</li>
        </ol>
      </details>
    </div>
  </section>

  <section class="card">
    <h3>▶️ Quick Run Guide</h3>
    <ol>
      <li>Run <code>Manim_Run.ps1</code> in PowerShell or via PyCharm configuration.</li>
      <li>Choose Menu or Manual mode; select options using TAB/ENTER.</li>
      <li>Preview command, confirm, and execute; check console output and movie files.</li>
    </ol>
  </section>

  <section class="card row">
    <div>
      <h3>🧪 Testing & Execution Tips</h3>
      <ul>
        <li>Run inside project directory</li>
        <li>Test short sample scenes first</li>
        <li>Manual path entry will be cached for future runs</li>
      </ul>
    </div>
    <div>
      <h3>🧠 Developer Notes</h3>
      <ul>
        <li>Keep <code>$optionsList</code> grouped with metadata for easy UI generation</li>
        <li>Cache scan results to avoid repeated disk access</li>
        <li>Preserve readable previews for automation & debugging</li>
      </ul>
    </div>
  </section>

  <section class="card preview">
    <h3>💡 Example Preview</h3>
    <a href="https://github.com/hi4444/Manim-Utility-Projects/blob/main/Preview.png" target="_blank">
      <img src="https://raw.githubusercontent.com/hi4444/Manim-Utility-Projects/main/Preview.png" alt="Manim AutoRunner Preview">
    </a>
    <p><em>▲ Click to view full-size screenshot</em></p>
  </section>

  <footer>
    Initial release focused on stability & UX. Future updates: profiles, cross-platform fallbacks, scene autodiscovery.
  </footer>
</div>
</body>
</html>
