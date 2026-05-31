[English](README.md) · **한국어**

# Seanwiki

> Obsidian + Claude — 두 도구를 하나의 vault 로 묶어 만드는 *내 정보 백과사전*.

여기는 Seanwiki **release 전용** 레포. 소스 코드는 비공개로 두고, 이 레포는 서명된 바이너리를 다운받고·검증하고·이 도구의 철학을 읽으라고 만든 공간이야.

---

## Seanwiki 가 뭐냐면

폴더 하나를 구조화된 Obsidian vault 로 만들고, 그 위에 Claude Code 를 얹는 macOS 앱.

5분짜리 인터뷰가 vault 를 **너 자신** 에 맞춰 깎아 — 네가 하는 일, 네 도메인, 네 규칙 — 답변 전부를 `CLAUDE.md` / `AGENTS.md` 에 박아넣어서, 이 vault 를 건드리는 모든 AI 가 매번 같은 규칙을 따르도록 강제해.

인터뷰 끝나면 vault 안에 이런 게 생겨:

- `inbox/` — 드롭존. 뭐든 던져넣어.
- `raw/` — **불변** 원본 박스. 여기 들어간 파일은 어떤 AI 도 절대 수정 못 함.
- `wiki/` — Claude 가 `raw/` 위에서 해석을 쓰는 공간. 인용은 전부 `[[wikilink]]`.
- `.claude/skills/` — 카테고리별 슬래시 커맨드 (`/ingest`, `/query`, `/lint`).

`inbox/` 에 스크린샷 던지면 → Claude 가 OCR + 시각 분석 → 적절한 `raw/` 하위로 이동 + `wiki/log.md` 에 한 줄 로그. 분류 마음에 안 들면? `CLAUDE.md` 룰만 다시 쓰면 끝.

---

## 왜 이렇게 만들었나 — 절대 양보 안 하는 5가지

### 1. 자동 업데이트 절대 없음. 예외 없음.

자동 업데이트는 내가 절대 안 열어두는 백도어다. 내 GitHub 계정이 피싱당하거나 서명 키가 새는 순간, 자동 업데이터가 깔린 앱들엔 악성 바이너리가 그대로 밀려들어가. 수동 업데이트면 **언제** 받을지 본인이 정하고, **뭘** 받았는지 본인이 검증한다.

릴리즈마다 `ed25519` detached 서명 + SHA-256 동봉. 스크립트 한 번 돌리면 yes/no 가 나와. 몰래 버전 갈아끼기 없음.

### 2. 100% 로컬. vault 는 절대 외부로 안 나간다.

너의 vault 는 디스크 위 평범한 마크다운 파일일 뿐. 텔레메트리 없음. 라이선스 체크 없음. "익명 사용 통계" 따위 없음. 네가 직접 스위치를 켜기 전엔 어떤 것도 네 컴퓨터를 떠나지 않아.

이걸 Obsidian 위에 지은 이유 자체가 데이터 가용성 때문이야 — Seanwiki 가 내일 사라져도 너의 vault 는 그냥 마크다운이라서 다른 에디터에서도 열려.

### 3. 외부 통신 디폴트 OFF. 채널별로 개별 opt-in.

Telegram 브릿지? 기본 OFF. 플러그인 자동 설치? 기본 OFF. 외부 API 호출? 기본 OFF. 각각이 스위치고, 본인이 켜고 싶을 때만 켜는 구조 — chat-id 화이트리스트 같은 안전장치 동반.

앱의 디폴트 상태는 "고립". 바깥 세상엔 opt-**in** 하는 거지, opt-**out** 하는 게 아니다.

### 4. `raw/` 는 불변. AI 가 절대 원본을 못 건드린다.

AI 가 내 노트 위에서 동작할 때 가장 큰 실패 모드는, "정리해줄게요" 하고 원본을 슬쩍 수정해버리는 것. Seanwiki 는 vault 를 두 반으로 자른다 — `raw/` 는 영원히 너의 것이고, `wiki/` 만 AI 가 쓸 수 있어.

덕분에 `wiki/` 안 모든 주장은 `raw/` 안 그대로의 출처로 추적이 돼. 몰래 수정 없음. 변형 없음.

### 5. 인터뷰. 템플릿이 아니라.

일반 템플릿은 "네가 이런 사람일 거다" 라는 추측이야. Seanwiki 의 인터뷰는 **너에 대해** 3~5개 물어봐 — 뭘 만드는지, 왜 기록하는지, 어떤 결과물 원하는지 — 답변을 `CLAUDE.md` 와 `AGENTS.md` 에 박아 넣어서, 이후 모든 AI 세션이 풀 컨텍스트로 시작하도록 만들어.

kickoff 프롬프트 자체는 내가 Obsidian + Claude 를 오래 붙여 쓰면서 계속 다듬어온 결과물이고, 지금 시점에선 내가 만든 것 중 가장 좋은 프롬프트야. 본인 도메인에 맞게 더 빡세게 다듬고 싶으면 앱의 **Prompt Setting** 에서 바로 수정 가능.

---

## 다운로드

1. [Releases](https://github.com/IT-Yun/seanwiki-releases/releases) 에서 본인 칩에 맞는 빌드 다운로드.
   - **Apple Silicon** (M1/M2/M3/M4): `Seanwiki Silicon-<version>-arm64-mac.zip`
   - **Intel**: `Seanwiki Intel-<version>-mac.zip`
   - 모르면 Apple 메뉴 → About This Mac → Chip 확인.
2. 같은 이름의 `.sig` 파일도 다운 (89바이트 — ed25519 서명).
3. 압축 풀고 → `Seanwiki.app` 을 `/Applications/` 로 드래그.
4. 첫 실행: 우클릭 → **열기**. 현재는 ad-hoc 서명 상태. 배포가 커지면 Developer ID 로 전환 예정.

## 설치 전 검증

```bash
git clone https://github.com/IT-Yun/seanwiki-releases.git
cd seanwiki-releases
bash scripts/verify-release.sh <다운받은-zip-경로>
```

성공 시:

```
  computed SHA-256: <hex>
  ✓ ed25519 signature VERIFIED
✓ Verification complete. Safe to drag into /Applications/.
```

서명 검증이 **실패하면** 파일 지우고 다시 받아. 절대 설치하지 마.

공개키 (`scripts/seanwiki-pubkey.txt`):

```
nzi9RYywbRu//kXHVt8aNI0w5U2i2g/YZI0u65QsNc8=
```

내가 서명할 때 쓰는 유일한 키. 미래 릴리즈가 다른 키로 검증되면 **내가 만든 게 아니야.**

## 업데이트

같은 흐름 반복 — 새 `.zip` 받아서 검증 → 기존 `.app` 을 `/Applications/` 에서 교체. 앱 자체는 자동으로 업데이트 체크 안 함. 의도된 설계.

## 이슈 / 피드백

여기 이슈로 올리거나 LinkedIn DM. 빙빙 돌려서 우회하느니 빨리 듣고 싶어.

## 라이선스

[MIT](LICENSE) — 앱 자체는 정신적으로 오픈소스. 소스 레포는 현재 비공개고, 표면이 안정화되면 공개 논의 가능.

---

<sub>구조 일부 — JSON 파일 기반 state, git-worktree 워커 격리, 수동 서명 업데이트 — 은 [Octo](https://github.com/anthropics/octo) · OMC 의 패턴을 일부 참고했음.</sub>
