**English** · [한국어](README.ko.md)

# Seanwiki

> Obsidian + Claude, fused into your personal knowledge encyclopedia.

This is the **release-only** repo for Seanwiki. The source code lives privately; this repo exists so you can download signed binaries, verify them, and read the philosophy behind the tool.

---

## What Seanwiki actually is

A macOS app that turns any folder into a structured Obsidian vault, then drops Claude Code on top.

A 5-minute interview shapes the vault around **you** — your work, your domain, your rules — and writes everything to `CLAUDE.md` / `AGENTS.md` so every AI you ever point at the vault follows the same playbook.

After the interview, your vault has:

- `inbox/` — drop zone. Throw anything in.
- `raw/` — the **immutable** source box. Once a file lands here, no AI edits it. Ever.
- `wiki/` — where Claude writes interpretations on top of `raw/`. Citations use `[[wikilinks]]`.
- `.claude/skills/` — slash commands (`/ingest`, `/query`, `/lint`) tailored to your category.

Drop a screenshot into `inbox/` → Claude OCRs it, classifies it, moves it into the right `raw/` subfolder, and appends one line to `wiki/log.md`. Don't like the classification? Open `CLAUDE.md` and rewrite the rule.

---

## Why I built it this way — the five things I refuse to compromise on

### 1. Manual updates only. No auto-fetch. No exceptions.

Auto-update is a back door I refuse to leave open. If my GitHub account ever gets phished or my signing key leaks, an auto-updater would silently push malicious binaries to every install. With manual updates, **you** decide when, and **you** verify what.

Every release ships with an `ed25519` detached signature + SHA-256. You run one script, it tells you yes or no. No surprise version swaps.

### 2. 100% local. The vault never phones home.

Your vault is just plain markdown files on your disk. No telemetry. No license check. No "anonymous usage stats." Nothing leaves your machine unless you flip a switch.

The whole reason I built this on Obsidian is so the data stays portable — if Seanwiki disappears tomorrow, your vault is still just markdown that you can open in any editor.

### 3. Opt-in network. Every channel, individually.

Telegram bridge? Off by default. Plugin auto-installs? Off by default. External API calls? Off by default. Each one is a switch you flip when you want it, with a chat-id whitelist or equivalent guardrail.

The default state of the app is "isolated." You opt **into** the outside world, not **out of** it.

### 4. `raw/` is immutable. The AI never edits your sources.

The single biggest failure mode of AI-on-your-notes is the AI silently rewriting your originals during some "cleanup" pass. Seanwiki splits the vault into two halves: `raw/` is yours forever, and `wiki/` is where the AI gets to write.

This means every claim in `wiki/` is traceable back to a verbatim source in `raw/`. No quiet edits. No drift.

### 5. The interview, not a template.

A generic vault template is a guess about who you are. Seanwiki's interview asks 3–5 questions about **you** — what you build, why you record, what output you want — and bakes the answers into `CLAUDE.md` and `AGENTS.md` so every AI session starts with full context.

The kickoff prompt itself is something I've refined over a long stretch of running Obsidian + Claude together. At this point, it's the best one I've written. You can edit it any time in **Prompt Setting**.

---

## Download

1. Grab the right build from [Releases](https://github.com/IT-Yun/seanwiki-releases/releases).
   - **Apple Silicon** (M1/M2/M3/M4): `Seanwiki Silicon-<version>-arm64-mac.zip`
   - **Intel**: `Seanwiki Intel-<version>-mac.zip`
   - About-this-Mac → check your chip if unsure.
2. Also grab the matching `.sig` file (89 bytes — the ed25519 detached signature).
3. Unzip → drag `Seanwiki.app` into `/Applications/`.
4. First run: right-click → **Open**. The build is ad-hoc signed today; Developer ID signing will land when distribution scales.

## Verify before installing

```bash
git clone https://github.com/IT-Yun/seanwiki-releases.git
cd seanwiki-releases
bash scripts/verify-release.sh <path-to-downloaded-zip>
```

You should see:

```
  computed SHA-256: <hex>
  ✓ ed25519 signature VERIFIED
✓ Verification complete. Safe to drag into /Applications/.
```

If the signature **doesn't** verify, delete the file and re-download. Don't install.

The public key (`scripts/seanwiki-pubkey.txt`):

```
nzi9RYywbRu//kXHVt8aNI0w5U2i2g/YZI0u65QsNc8=
```

This is the only key I sign with. If a future release verifies against a different key, **it's not from me.**

## Updating

Same flow: download the new `.zip`, verify, drag the new `.app` into `/Applications/` (replacing the old one). The app does not check for updates on its own — by design.

## Issues / feedback

Open an issue here, or DM me on LinkedIn. I'd rather hear bugs early than ship around them.

## License

[MIT](LICENSE) — the app itself is open-source in spirit. Source repo is private today; happy to discuss opening it once the surface stabilises.

---

<sub>Architectural cues — JSON-file state, git-worktree workers, manual signed updates — were loosely informed by [Octo](https://github.com/anthropics/octo) and OMC.</sub>
