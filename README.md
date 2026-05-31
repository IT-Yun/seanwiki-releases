**English** · [한국어](README.ko.md)

# Seanwiki

> Obsidian + Claude, fused into your personal knowledge encyclopedia.

A macOS app that ties Obsidian and Claude Code into a single vault — so the AI you talk to is reading from, and writing back into, the same knowledge base you already trust.

This is the **release-only** repo. The source lives privately for now. This repo exists so you can download signed binaries, verify them, read the philosophy behind the tool, and decide whether it's for you.

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

From [Releases](https://github.com/IT-Yun/seanwiki-releases/releases), download **two files** of the matching architecture:

| You want | File |
|---|---|
| The app (Apple Silicon) | `Seanwiki Silicon-<version>-arm64-mac.zip` (~135 MB) |
| The signature (Apple Silicon) | `Seanwiki Silicon-<version>-arm64-mac.zip.sig` (89 B) |
| The app (Intel) | `Seanwiki Intel-<version>-mac.zip` (~140 MB) |
| The signature (Intel) | `Seanwiki Intel-<version>-mac.zip.sig` (89 B) |

(If you'd rather have a `.dmg` than a `.zip`, both are provided. Same flow.)

### Step 3 — Verify before installing

This step takes ten seconds and protects you from a tampered binary. Clone this repo or download the two files in `scripts/`, then:

```bash
cd <wherever-you-downloaded-the-zip>
bash <path-to>/scripts/verify-release.sh "Seanwiki Silicon-0.1.1-arm64-mac.zip"
```

You should see:

```
→ Verifying: Seanwiki Silicon-0.1.1-arm64-mac.zip

  computed SHA-256: ac1a6a17e34b8c460f7de709ffd62bf64da45605104aa58797288299d11612b1

→ Verifying ed25519 signature against published public key
  ✓ ed25519 signature VERIFIED

✓ Verification complete. Safe to drag into /Applications/.
```

**If the signature does NOT verify, delete the file and re-download.** Don't install it. Either the file is corrupted in transit, or someone tampered with it. Neither is your problem to fix — just grab a fresh copy.

The public key (`scripts/seanwiki-pubkey.txt`) is:

```
nzi9RYywbRu//kXHVt8aNI0w5U2i2g/YZI0u65QsNc8=
```

This is the only key I sign with. If a future release verifies against a different key, **it's not from me.**

### Step 4 — Install

```bash
unzip "Seanwiki Silicon-0.1.1-arm64-mac.zip"
```

You'll get `Seanwiki.app`. Drag it into `/Applications/`.

### Step 5 — First launch

Gatekeeper will block the first launch because the build is ad-hoc signed (Developer ID signing will land when distribution scales). Workaround:

1. Open Finder → Applications.
2. **Right-click** Seanwiki.app → **Open**.
3. Dialog appears saying "Apple cannot verify this developer." Click **Open** anyway.

You only need to do this once. After that double-clicking works normally.

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
