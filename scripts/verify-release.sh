#!/bin/bash
# Verify a downloaded Seanwiki release artifact.
#
# Usage:
#   ./verify-release.sh <path-to-dmg-or-zip> [sha256-from-website] [path-to-sig]
#
# Steps:
#   1. Compute sha256 of the file.
#   2. (Optional) compare against the sha256 the developer published.
#   3. (Optional) verify ed25519 detached signature using the developer's
#      published public key (RELEASE_PUBKEY_B64 env var or seanwiki-pubkey.txt
#      sitting next to this script).
#
# This is what the user runs in their own Terminal before dragging the .app
# into /Applications. The Seanwiki app itself never does auto-update — by
# design (manual = no surprise version swap, no GitHub-takeover scenario).
set -e

FILE="$1"
EXPECTED_SHA="$2"
SIG_PATH="$3"

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  echo "usage: $0 <path-to-dmg-or-zip> [expected-sha256] [path-to-sig]"
  exit 2
fi

echo "→ Verifying: $FILE"
echo ""
ACTUAL=$(shasum -a 256 "$FILE" | awk '{print $1}')
echo "  computed SHA-256: $ACTUAL"

if [ -n "$EXPECTED_SHA" ]; then
  if [ "$ACTUAL" = "$EXPECTED_SHA" ]; then
    echo "  ✓ SHA-256 MATCHES published value"
  else
    echo "  ⚠ SHA-256 MISMATCH"
    echo "      expected: $EXPECTED_SHA"
    echo "      actual:   $ACTUAL"
    echo "    Do NOT install this file. Re-download from the official channel."
    exit 1
  fi
fi

# ed25519 detached signature (optional layer)
PUBKEY_B64="${RELEASE_PUBKEY_B64:-}"
if [ -z "$PUBKEY_B64" ] && [ -f "$(dirname "$0")/seanwiki-pubkey.txt" ]; then
  PUBKEY_B64=$(cat "$(dirname "$0")/seanwiki-pubkey.txt" | tr -d '[:space:]')
fi

if [ -n "$PUBKEY_B64" ]; then
  if [ -z "$SIG_PATH" ] && [ -f "$FILE.sig" ]; then
    SIG_PATH="$FILE.sig"
  fi
  if [ -n "$SIG_PATH" ] && [ -f "$SIG_PATH" ]; then
    echo ""
    echo "→ Verifying ed25519 signature against published public key"
    node -e "
      const fs = require('node:fs');
      const crypto = require('node:crypto');
      const data = fs.readFileSync('$FILE');
      const sigB64 = fs.readFileSync('$SIG_PATH', 'utf-8').trim();
      const sig = Buffer.from(sigB64, 'base64');
      const raw = Buffer.from('$PUBKEY_B64', 'base64');
      if (raw.length !== 32) { console.error('  ⚠ bad pubkey length'); process.exit(1); }
      const prefix = Buffer.from('302a300506032b6570032100', 'hex');
      const spki = Buffer.concat([prefix, raw]);
      const pub = crypto.createPublicKey({ key: spki, format: 'der', type: 'spki' });
      const ok = crypto.verify(null, data, pub, sig);
      if (ok) { console.log('  ✓ ed25519 signature VERIFIED'); }
      else { console.error('  ⚠ ed25519 signature DID NOT verify — refusing'); process.exit(1); }
    "
  else
    echo ""
    echo "  (no .sig file provided — skipping ed25519 check)"
  fi
fi

echo ""
echo "✓ Verification complete. Safe to drag into /Applications/."
