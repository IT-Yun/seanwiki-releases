<div align="center">

# Seanwiki

**Obsidian + Claude Code, fused into your personal knowledge encyclopedia.**

A macOS app that ties Obsidian and Claude Code into a single vault — so the AI you talk to
reads from, and writes back into, the same knowledge base you already trust.

<p>
  <a href="https://github.com/IT-Yun/seanwiki-releases/releases/latest"><img alt="Latest release" src="https://img.shields.io/github/v/release/IT-Yun/seanwiki-releases?logo=github&label=release&color=2C2E3B"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/github/license/IT-Yun/seanwiki-releases?color=blue"></a>
  <img alt="Platform: macOS" src="https://img.shields.io/badge/platform-macOS-000000?logo=apple&logoColor=white">
  <a href="https://github.com/IT-Yun/seanwiki-releases/releases"><img alt="Downloads" src="https://img.shields.io/github/downloads/IT-Yun/seanwiki-releases/total?logo=github&color=success"></a>
  <a href="https://github.com/IT-Yun/seanwiki-releases/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/IT-Yun/seanwiki-releases?style=social"></a>
</p>

<p>
  <img alt="Electron" src="https://img.shields.io/badge/Electron-2C2E3B?logo=electron&logoColor=9FEAF9">
  <img alt="React" src="https://img.shields.io/badge/React-20232A?logo=react&logoColor=61DAFB">
  <img alt="TypeScript" src="https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white">
  <img alt="Claude" src="https://img.shields.io/badge/Claude_Code-D97757?logo=anthropic&logoColor=white">
  <img alt="Obsidian" src="https://img.shields.io/badge/Obsidian-7C3AED?logo=obsidian&logoColor=white">
</p>

<br>

<img alt="Seanwiki screenshot" src="docs/screenshot.png" width="820">

<br><br>

**English** · [한국어](README.ko.md)

</div>

> This is the **release-only** repo — the source lives privately for now. Here you can download
> signed binaries, verify them, read the philosophy behind the tool, and decide if it's for you.
> If it sounds useful, a ⭐ on this repo helps other people find it.

---

## Why I built this

For years I had two habits that never talked to each other.

The first was Obsidian. I dumped everything into it — meeting notes, screenshots, half-formed ideas, papers I bookmarked but never read. The vault grew into thousands of markdown files. A graveyard of my own thinking.

The second was Claude. Every conversation started from zero. I'd paste context, get a useful answer, close the tab. Tomorrow I'd ask a similar question and paste the same context again. The intelligence was real, but it had no memory of *me*.

Both halves were great in isolation. Together they were nothing — because nothing connected them.

**Seanwiki is what happens when you stop treating those two as separate tools and start treating them as one second brain.** Your Obsidian vault is the long-term memory. Claude is the reasoning engine that reads from it, writes back into it, and keeps the whole structure honest.

The interview at the start is not optional. It's the entire point. It teaches the AI who you are, what you record, and what you want back — and bakes those answers into `CLAUDE.md` / `AGENTS.md` so every future session inherits the same context. No more re-explaining yourself.

---

## What Seanwiki actually is

A macOS app. ~135 MB. Drag-to-install. No background services, no daemons, no menubar icon by default.

When you open it the first time you see two cards: **Obsidian** and **Claude Code**. Click each one, install them (both are free, both run locally). That's the only setup.

Hit **`+ New project`**, pick a category, point it at a folder, and answer 3–5 questions in a terminal. Six minutes later your vault looks like this:

```
<vault>/
├── CLAUDE.md              ← rules every AI reads on every turn
├── AGENTS.md              ← same rules, cross-AI variant
├── core-context.md        ← who you are, written from your answers
│
├── inbox/                 ← drop zone. throw anything in.
├── raw/                   ← immutable source box. AI cannot edit these.
│   ├── benchmarks/
│   ├── inspiration/
│   ├── research/
│   └── ...
│
├── wiki/                  ← Claude's interpretations live here
│   ├── index.md           ← table of contents (one line per page)
│   └── log.md             ← every meaningful action logged here
│
├── Output/                ← compiled deliverables (drafts, PDFs, exports)
│
└── .claude/skills/        ← slash commands you can edit
    ├── ingest/SKILL.md    ← sweep inbox → classify → move into raw → update wiki
    ├── query/SKILL.md     ← ask the wiki, get answers with [[wikilink]] citations
    ├── lint/SKILL.md      ← health check (orphan pages, broken links)
    └── <category-extras>
```

### What this looks like day-to-day

**You capture a screenshot.** Drag it into `inbox/` from anywhere. Claude OCRs it, identifies what it is ("this looks like a competitor's pricing page"), moves it into `raw/benchmarks/competitor-pricing-<slug>.png`, and writes one line into `wiki/log.md` saying so. You did nothing but drop a file.

**You ask the wiki a question.** In Claude Code: `/query "what did we decide about the auth flow?"` Claude reads `wiki/index.md`, finds the relevant pages, returns an answer with `[[wikilink]]` citations pointing back to the exact `raw/` source. Every claim is traceable. There is no hallucinated context.

**You change your mind about a rule.** Open `CLAUDE.md`, rewrite the rule, save. Every Claude session from that point forward follows the new rule. No re-prompting. No re-training. Markdown is the only configuration language.

**You want a custom slash command.** Open `.claude/skills/`, write a new `SKILL.md` file describing what the command should do. Save. Claude picks it up next run.

The whole system is files. Plain markdown files. If Seanwiki vanishes tomorrow, your vault keeps working with any other editor.

---

## The five things I refuse to compromise on

### 1. Manual updates only. No exceptions.

Auto-update is a back door I will not leave open. If my GitHub account ever gets phished or my signing key leaks, an auto-updater would silently push malicious binaries to every install. With manual updates, **you** decide when, and **you** verify what.

Every release ships with an `ed25519` detached signature + SHA-256. You run one script, it tells you yes or no. No surprise version swaps. No "you updated automatically while you were sleeping."

### 2. 100% local. The vault never phones home.

No telemetry. No license check. No "anonymous usage stats." Nothing leaves your machine unless you flip a specific switch.

The reason I built this on Obsidian instead of a custom format is exactly this: if Seanwiki disappears tomorrow, your vault is still just markdown. You can open it in any editor. You can grep it. You can git-commit it. The data outlives the tool.

### 3. Opt-in network. Every channel, individually.

Telegram bridge? Off by default. Plugin auto-installs? Off by default. External API calls? Off by default. Each one is a switch you flip when you want it, with a chat-id whitelist or equivalent guardrail.

The default state of the app is "isolated." You opt **into** the outside world, not **out of** it.

### 4. `raw/` is immutable. The AI never edits your sources.

The single biggest failure mode of AI-on-your-notes is the AI silently rewriting your originals during some "cleanup" pass. I refuse to ship that.

Seanwiki splits the vault into two halves: `raw/` is yours forever — once a file lands there, no AI process can edit it, ever. `wiki/` is where the AI gets to write, and every claim in `wiki/` is traceable back to a verbatim source in `raw/` via `[[wikilink]]` citations.

This means you can audit every interpretation. You can disagree with one and rewrite the `wiki/` page without touching the source. You can never get into a state where your originals were quietly mutated and you can't tell what was changed.

### 5. The interview, not a template.

A generic vault template is a guess about who you are. Seanwiki's interview asks 3–5 questions — what you build, why you record, what output you want — and bakes the answers into `CLAUDE.md` and `AGENTS.md` so every AI session starts with full context.

The kickoff prompt itself is something I've refined over a long stretch of running Obsidian + Claude together. At this point, it's the best one I've written. You can edit it any time in the app's **Prompt Setting** — and your edits stick across project creations, not just one-off.

---

## Download

### Step 1 — Check your Mac's chip

Apple menu → **About This Mac** → look at "Chip":

- Says **Apple M1 / M2 / M3 / M4** → you want the **Silicon** build.
- Says **Intel** → you want the **Intel** build.

If you grab the wrong one it'll still run via Rosetta, but slower and with worse battery.

### Step 2 — Grab the files

Latest version: **v2.0.0**. From [Releases](https://github.com/IT-Yun/seanwiki-releases/releases/latest), download the files for your architecture into the same folder.

Each architecture ships **two formats** — grab whichever you prefer (they're the same app):

- **`.dmg`** — the classic "open it, drag the app into Applications" installer. Easiest if you just want it running.
- **`.zip`** — the same app, zipped up. Use this one if you want to run the verify script below first.

| Architecture | `.dmg` (drag-install) | `.zip` (verify-first) | Signature |
|---|---|---|---|
| **Apple Silicon** (M1–M4) | `Seanwiki.Silicon-2.0.0-arm64.dmg` (~140 MB) | `Seanwiki.Silicon-2.0.0-arm64-mac.zip` (~135 MB) | matching `…​.sig` (89 B) |
| **Intel** | `Seanwiki.Intel-2.0.0.dmg` (~140 MB) | `Seanwiki.Intel-2.0.0-mac.zip` (~140 MB) | matching `…​.sig` (89 B) |

The signature file is tiny (89 bytes) — grab it together with the binary so verification works.

Inside the zip (or the mounted `.dmg`) is a single app, named per architecture:

- Apple Silicon → **`Seanwiki Silicon.app`**
- Intel → **`Seanwiki Intel.app`**

(The chip is baked into the name on purpose — so if you ever have both on one machine you can tell them apart. Everywhere below, "the Seanwiki app" means whichever of those two you downloaded.)

#### Or download straight from the Terminal (one block, no browser)

If you'd rather not click around, paste this. It auto-detects your chip, downloads the matching `.zip` + `.sig`, and verifies the signature in one go:

```bash
# 1) pick the right file for your Mac's chip
#    (hw.optional.arm64 == 1 means Apple Silicon — correct even inside a Rosetta shell)
if [ "$(sysctl -in hw.optional.arm64 2>/dev/null)" = "1" ]; then
  FILE="Seanwiki.Silicon-2.0.0-arm64-mac.zip"
else
  FILE="Seanwiki.Intel-2.0.0-mac.zip"
fi
BASE="https://github.com/IT-Yun/seanwiki-releases/releases/download/v2.0.0"

# 2) download the app + its signature into the current folder
curl -L -o "$FILE"     "$BASE/$FILE"
curl -L -o "$FILE.sig" "$BASE/$FILE.sig"

echo "Downloaded $FILE  ($(du -h "$FILE" | cut -f1))"
```

(Have the GitHub CLI? `gh release download v2.0.0 -R IT-Yun/seanwiki-releases -p "Seanwiki.*"` grabs every asset — pick the arch you want, or pass `-p "*Silicon*"` / `-p "*Intel*"` to narrow it.)

Then verify it (Step 3), unzip, and drag the app into `/Applications/`.

### Step 3 — Verify before installing

This step takes ten seconds and protects you from a tampered binary. Clone this repo (or just download the two files in `scripts/`), then point the script at the file you downloaded:

```bash
cd <wherever-you-downloaded-the-file>
# Apple Silicon:
bash <path-to>/scripts/verify-release.sh "Seanwiki.Silicon-2.0.0-arm64-mac.zip"
# Intel:
bash <path-to>/scripts/verify-release.sh "Seanwiki.Intel-2.0.0-mac.zip"
```

The script auto-finds the matching `.sig` (it must sit in the same folder). You should see:

```
→ Verifying: Seanwiki.Silicon-2.0.0-arm64-mac.zip

  computed SHA-256: 8b3c0a613cc54bff0664d650f01b86edd4566a9e9af21113a70a9547f8507cdb

→ Verifying ed25519 signature against published public key
  ✓ ed25519 signature VERIFIED

✓ Verification complete. Safe to drag into /Applications/.
```

**If the signature does NOT verify, delete the file and re-download.** Don't install it. Either the file is corrupted in transit, or someone tampered with it. Neither is your problem to fix — just grab a fresh copy.

#### Published SHA-256 (v2.0.0)

If you'd rather eyeball the hash yourself, run `shasum -a 256 <file>` and compare against this table:

| File | SHA-256 |
|---|---|
| `Seanwiki.Silicon-2.0.0-arm64-mac.zip` | `8b3c0a613cc54bff0664d650f01b86edd4566a9e9af21113a70a9547f8507cdb` |
| `Seanwiki.Silicon-2.0.0-arm64.dmg` | `bd67fec938dc1a833a1487ee305c72fa5999f63853c2e54b98470e8a21c271b1` |
| `Seanwiki.Intel-2.0.0-mac.zip` | `a49ac024181627dc68eb90fd2c8379179ce7c243ab8667c1156dc72d2ba2ca55` |
| `Seanwiki.Intel-2.0.0.dmg` | `79d2c63ea74789e7e6a5aaed8d2156ddb1311ba691d1a8818823b3d502b51396` |

The public key (`scripts/seanwiki-pubkey.txt`) is:

```
nzi9RYywbRu//kXHVt8aNI0w5U2i2g/YZI0u65QsNc8=
```

This is the only key I sign with. If a future release verifies against a different key, **it's not from me.**

### Step 4 — Install

**From the `.dmg`:** double-click it → a window opens showing the app and an `Applications` shortcut → drag the app onto `Applications`. Done. Eject the disk image afterward.

**From the `.zip`:** double-click it to extract (or `unzip "Seanwiki.Silicon-2.0.0-arm64-mac.zip"` in Terminal) → you get the app → drag it into `/Applications/`.

Either way the app you're dragging is `Seanwiki Silicon.app` (Apple Silicon) or `Seanwiki Intel.app` (Intel).

### Step 5 — First launch (IMPORTANT — Gatekeeper workaround)

The build is ad-hoc signed today (Developer ID signing will land when distribution scales), so the first launch hits Gatekeeper with this error:

> **"Apple could not verify 'Seanwiki Silicon' is free of malware that may harm your Mac or compromise your privacy."**

(On an Intel Mac it says "Seanwiki Intel" instead.) This is **expected** for an ad-hoc signed app — it's not a real malware warning, just an "I don't know who this developer is" warning. Pick the path that matches your macOS:

**Option A — macOS Sequoia (15.0 and newer) — the Privacy & Security unlock**

The old right-click → Open trick was removed in Sequoia. Use the new flow:

1. Double-click the app → see the "could not verify" dialog
2. Click **Done** (do **NOT** click "Move to Trash" — that deletes the app)
3. Open  → **System Settings** → **Privacy & Security**
4. Scroll all the way down to the **Security** section. You'll see a line like: *"Seanwiki Silicon was blocked from use because it is not from an identified developer."* with an **Open Anyway** button next to it. Click **Open Anyway**.
5. A confirmation dialog appears → click **Open Anyway** again → authenticate with Touch ID or your login password.
6. The app launches. Every future double-click opens it normally — you only do this once.

> If you don't see the "Open Anyway" button, you skipped step 1 — macOS only shows it right after you've *tried* to open the app and been blocked. Double-click the app once, click Done, then go back to Privacy & Security.

**Option B — macOS Sonoma (14) or older**

1. Right-click (or Control-click) the app → **Open**
2. Dialog appears → click **Open**
3. Done. (Future double-clicks work normally.)

**Option C — Terminal one-liner (works on any macOS, fastest)**

Strip Apple's quarantine flag directly. This is the same thing Privacy & Security does, just from the command line:

```bash
# Apple Silicon:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Silicon.app"
# Intel:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Intel.app"
```

Then just double-click the app — no dialog at all. (`xattr -cr "<path>"` also works; it clears *all* extended attributes instead of just the quarantine one.)

> **Why does this happen at all?** macOS tags every file downloaded from the internet with a `com.apple.quarantine` flag. For apps signed with a paid Apple Developer ID, Gatekeeper checks the signature and lets it through. This build is *ad-hoc* signed (no paid cert yet), so Gatekeeper can't identify the developer and blocks it — until you explicitly approve it once via any of the three options above. None of this means the app is unsafe; it means Apple hasn't been paid to vouch for it. That's exactly why every release is independently signed with my own ed25519 key (Step 3) — so you can verify it's really from me without trusting Apple's chain at all.

### Step 6 — What you see

The empty-state screen shows two cards: **Obsidian** and **Claude Code**. Click each card to open their official download pages. Both are free, both install in a minute.

Once both are installed, hit **`+ New project`** in the top right and follow the prompts.

---

## After install — what the first 10 minutes look like

1. **Pick a category.** Five defaults: Build Your Own App / Enterprise / Homework / General Project / Website. Pick the closest. You can change rules later.
2. **Point at a folder.** Either let the app open Obsidian and pick a vault there, or pick an existing folder in Finder. The folder will become your project root.
3. **The interview starts in a terminal.** Claude asks 3–5 short questions. Answer them honestly. The more honest, the more the vault is shaped to you.
4. **Files appear on disk in real-time.** As you answer, Claude writes `CLAUDE.md`, `AGENTS.md`, `core-context.md`, the `raw/` subfolders, `.claude/skills/`. You can watch it all happen in Finder.
5. **At the end you get one line:** "Setup complete — 7 deliverables on disk. Ready for anything."

Now you can do whatever you came here to do. Drop screenshots into `inbox/`. Ask questions via `/query`. Open files in Obsidian. Everything is just markdown.

---

## Updating

Same flow as install. Download the new `.zip` and `.sig`, verify with the script, drag the new `.app` into `/Applications/` (replacing the old one — macOS asks "Replace?" → say yes).

The app does **not** check for updates on its own. It will not nag you. It will not phone home to ask "is there a new version?" By design.

How will you know about a new version? Whatever channel you used to find this one — LinkedIn, the GitHub Releases page, word of mouth. Pull updates the same way.

---

## Issues / feedback

Open an issue on this repo, or DM me on LinkedIn. I'd rather hear bugs early than have you ship around them.

If something feels off in the philosophy itself — a rule that's too rigid, a default you'd flip — say so. Strong opinions, loosely held.

---

## License

[MIT](LICENSE) © Seung yun Lee.

The source repo is private for now. Happy to discuss opening it once the surface stabilises and the rough edges are sanded.

---

<sub>Architectural cues — JSON-file state, git-worktree workers, manual signed updates — were loosely informed by [Octo](https://github.com/anthropics/octo) and OMC.</sub>
