# Setup and consent

Nothing in this skill installs anything without an explicit yes from the user. That rule has no
exceptions for "obvious" cases.

## Detect before you plan

Do this before describing what you are going to make, so the plan matches the machine.

**1. Which apps are installed.** Check the CLI, because the CLI is the MCP server:

```bash
# macOS / Linux
command -v wordcraft-cli deckcraft-cli gridcraft-cli pdfcraft-cli \
           photocraft-cli vectorcraft-cli filmcraft-cli effectcraft-cli \
           soundcraft-cli designcraft-cli figcraft-cli cadcraft-cli lightcraft-cli
```

```powershell
# Windows — the suite installs to Program Files, so it is not on PATH
Get-ChildItem "C:\Program Files" -Filter "*-cli.exe" -Recurse -Depth 1 |
  Select-Object -ExpandProperty FullName
```

```bash
# Windows via Git Bash
ls "/c/Program Files"/*Craft/*-cli.exe
```

A present CLI also gives you its version (`--version`) and its whole command registry
(`commands`, `list_commands`, `--help`), which is how you avoid guessing.

**2. Which apps code-mode can already reach.** Inside `exec`, `ALL_SERVERS` is the authoritative
list. Anything not there is not reachable through code mode this session, whatever is installed.

**3. Whether code-mode itself is present.** Look for an MCP server named `code-mode` in the
client's MCP configuration, or run the check:

```bash
npx -y @tmustier/code-mode-mcp@0.4.0 --check-config \
  --config ~/.config/code-mode-mcp/mcp.json
```

On Windows the config path is `C:/Users/<you>/.config/code-mode-mcp/mcp.json`. A successful check
prints every upstream server, its transport and whether it is enabled.

## The three consent questions

Ask the question that matches what is actually missing. Do not bundle them.

### A — The app is not installed

Say what the app is for, which artifact needs it, the exact install command, and whether a restart
is needed. Then stop and wait.

> PhotoCraft is not installed. It is the image editor in the ArtCraft suite and it is what I need
> to composite and retouch the images for this deck. Install it with `winget install --id
> ArtCraft.PhotoCraft --exact` (or from getartcraft.com/apps). It is about 200 MB, free and open
> source. Should I?

Install with winget on Windows where a package exists:

| App | winget id |
|---|---|
| CadCraft | `ArtCraft.CadCraft` |
| EffectCraft | `ArtCraft.EffectCraft` |
| FilmCraft | `ArtCraft.FilmCraft` |
| GridCraft | `ArtCraft.GridCraft` |
| PdfCraft | `ArtCraft.PdfCraft` |
| SoundCraft | `ArtCraft.SoundCraft` |
| VectorCraft | `ArtCraft.VectorCraft` |

Where winget has no package, the app's own installer page is
[getartcraft.com/apps](https://getartcraft.com/apps), or the GitHub release for
`storytold/<app>` (`photocraft`, `wordcraft`, `deckcraft`, `lightcraft`, `designcraft`, `figcraft`).
ArtCraft Launcher installs and updates the whole suite if the user prefers one manager.

macOS and Linux: use the release installer for the platform, or the launcher.

After installing, the CLI lands in the app's install folder. Verify with `--version` before
continuing; a winget install can require a new shell for PATH updates.

### B — The app is installed, code-mode is not set up for it

This is not a software install. It is one entry in a JSON file. Say so, add it, verify, and
mention that the current session will not see it until the MCP server restarts.

> WordCraft is installed but not registered with code-mode. I'm adding it to
> `~/.config/code-mode-mcp/mcp.json` — one entry, no new software. It will be reachable after the
> agent restarts.

Entry shape, mirroring how the suite is configured:

```json
{
  "mcpServers": {
    "wordcraft": {
      "command": "${ProgramFiles}/WordCraft/wordcraft-cli.exe",
      "args": [
        "mcp",
        "--automation-read-root", "${USERPROFILE}",
        "--automation-write-root", "${USERPROFILE}",
        "--author", "Claude Code"
      ]
    }
  }
}
```

On macOS/Linux the command is the CLI on `PATH` (`"wordcraft-cli"`) with the same `mcp` argument.

**Narrow the roots.** The `${USERPROFILE}` roots above grant the agent the entire home directory.
When you write an entry yourself, point the roots at the project:

```json
"args": ["mcp",
         "--automation-read-root", "D:/work/project",
         "--automation-write-root", "D:/work/project"]
```

A root left out grants no access in that direction, which is the correct default. VectorCraft takes
each root more than once and implies `--headless` when they are present.

Per-app flags that matter:

| App | Flag | Why |
|---|---|---|
| WordCraft | `--author NAME` | Names who tracked changes and comments are by |
| VectorCraft | `--headless` | Otherwise `mcp` silently attaches to a running app on 7979 |
| EffectCraft | `--autosave` | Headless checkpoints, recovery after a server restart |
| PdfCraft | `--compact` | Keeps a core tool set plus `tool_search`/`tool_call` instead of 179 tools |
| LightCraft | `--library DIR` | Persistent catalog location |
| FilmCraft | (none) | No root flags; keep it local |

Then validate, because a broken JSON file takes the whole code-mode server down:

```bash
npx -y @tmustier/code-mode-mcp@0.4.0 --check-config \
  --config ~/.config/code-mode-mcp/mcp.json
```

### C — code-mode itself is missing

Say plainly what it is and why it is worth it, then ask once:

> Code mode is not installed. It is one MCP server that takes a single `exec` call and lets me
> discover and call the other MCP servers from inside it. Without it I would register every Craft
> app separately and load about 340 tool schemas into context to write one document. With it, one
> call does the work and only the result comes back. It is a small npm package and it runs
> locally. Install it?

```bash
npm install --global @tmustier/code-mode-mcp@0.4.0
code-mode-mcp --help
```

Then register it as an MCP server:

```bash
claude mcp add code-mode -s user -- \
  npx -y @tmustier/code-mode-mcp@0.4.0 --config ~/.config/code-mode-mcp/mcp.json
```

The exact syntax differs per harness. In a JSON MCP config the shape is:

```json
{
  "mcpServers": {
    "code-mode": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@tmustier/code-mode-mcp@0.4.0",
               "--config", "/Users/you/.config/code-mode-mcp/mcp.json"]
    }
  }
}
```

Both the client config and the upstream config are required: the client talks to code mode, and
code mode reads the upstream file for the apps. Never list code-mode as its own upstream server.

A restart of the agent is required before the tool appears.

**Harness note.** Codex and Pi have code mode built in; Claude Code does not, so this is how Claude
Code gets it — `code-mode` is a top-level stdio MCP server in `~/.claude.json`, and the Craft apps
are its upstreams rather than separate MCP servers. If the harness already exposes an `exec` tool
over a composed tool catalog, use it and skip this section.

## After setup

Run one cheap call to prove the wiring before starting real work:

```js
return ALL_SERVERS.filter(s => ['wordcraft','deckcraft','pdfcraft'].includes(s.server));
```

A connected server reports `status: "connected"` and a tool count. A server that reports an error
is a config or path problem, not a skill problem — read the error, fix the entry, re-check.

## When installation is impossible

No permission, no package manager, no network: say so and use the narrowest fallback that needs no
new dependency. For documents and decks a markdown or HTML artifact is honest and editable; for
images and video, say plainly that the editing step cannot be done rather than pretending a
screenshot is the deliverable.

Never clone a fork or run an unverified installer because the official one failed.
