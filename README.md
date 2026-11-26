# Jarvis-ai

A fully local, free AI development stack for an ordinary PC. Jarvis wires several open models together so one runs as a coder, another as a reviewer, behind a single OpenAI-compatible endpoint that editors and agent tools can share.

## How it fits together

```text
VS Code (Continue) ─┐
Aider CLI ──────────┼──►  LiteLLM router :4000  ──►  Ollama :11434
Flowise :3000 ──────┤        (OpenAI API)            deepseek-write  (writes code)
OpenClaw gateway ───┘                                qwen-review     (reviews code)
                                                     nomic-embed     (embeddings)
Jarvis command center (jarvis-fast.html)
```

| Component | Role |
| --- | --- |
| [Ollama](https://ollama.com) | Runs the local models (`models/Modelfile.*` build `deepseek-write` from deepseek-coder 6.7B and `qwen-review` from Qwen) |
| [LiteLLM](https://github.com/BerriAI/litellm) | Routes OpenAI-style requests to the right model (`config.yaml`, `configs/litellm_config.yaml`) |
| [Aider](https://aider.chat) | Pair-programming CLI in architect mode: DeepSeek writes, Qwen edits (`configs/aider.conf.yml`) |
| [Continue](https://continue.dev) | VS Code assistant pointed at the router (`configs/continue_config.json`) |
| [Flowise](https://flowiseai.com) | Visual agent and workflow builder (`flowise/`) |
| OpenClaw | Agent gateway (`openclaw/`, git submodule) |
| `jarvis-fast.html` | Browser command center |

## Requirements

- Windows 10/11 with PowerShell (scripts are PowerShell; the stack itself also runs on macOS/Linux)
- Python 3.11+, Node.js 18+, Ollama
- About 16 GB RAM; a GPU with 6 GB+ VRAM helps

## Setup

```powershell
git clone https://github.com/rajivagarwal221/Jarvis-ai.git
cd Jarvis-ai

# Models
ollama pull deepseek-coder:6.7b
ollama create deepseek-write -f models/Modelfile.deepseek
ollama create qwen-review   -f models/Modelfile.qwen
ollama pull nomic-embed-text

# Python tools (LiteLLM, Aider, Whisper)
python -m venv env; .\env\Scripts\activate
pip install -r requirements.txt

# Flowise
cd flowise; npm install; cd ..
```

## Run

```powershell
$env:FLOWISE_PASSWORD = "<long random password>"   # never commit this
.\scripts\start.ps1           # Ollama, LiteLLM router and OpenClaw gateway
.\scripts\start-flowise.ps1   # Flowise on http://127.0.0.1:3000
```

`scripts/start.ps1` sets `$base` to the clone folder; edit it if you cloned somewhere else.

## Security notes

- Keep Ollama, LiteLLM and Flowise bound to `localhost`. `OLLAMA_ORIGINS` is limited to local pages, because `*` lets any website you visit use your models.
- `local-dev-key` in the configs is a placeholder for the local router, not a real API key.

## Repository layout

```text
configs/        LiteLLM, Aider and Continue configs
models/         Ollama Modelfiles
scripts/        PowerShell launchers
flowise/        Flowise package (dependencies are installed, not committed)
openclaw/       OpenClaw gateway (submodule)
carbon/         vendored copy of the Carbon framework by Buape
Jarvis-ai System/  notes
```
