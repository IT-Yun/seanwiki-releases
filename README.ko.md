[English](README.md) · **한국어**

# Seanwiki

> Obsidian + Claude — 두 도구를 하나의 vault 로 묶어 만드는 *내 정보 백과사전*.

Obsidian 과 Claude Code 를 하나의 vault 로 묶는 macOS 앱. 네가 대화하는 AI 가 곧 네가 이미 신뢰하는 그 노트들을 읽고, 거기에 다시 써내려가는 구조.

여기는 **release 전용** 레포. 소스 코드는 일단 비공개로 두고, 이 레포는 서명된 바이너리를 다운받고·검증하고·이 도구 뒤에 있는 철학을 읽고·너에게 맞는지 판단하라고 만든 공간이야.

---

## 왜 만들었나

오랫동안 내 안엔 서로 말 안 하는 두 가지 습관이 있었다.

첫 번째는 **Obsidian**. 회의 노트·스크린샷·반쯤 정리된 아이디어·읽다 만 논문, 다 거기에 던져넣었다. vault 는 수천 개 마크다운 파일로 부풀었고, 결국 *내 사고의 묘지* 가 됐다. 다시 안 봐.

두 번째는 **Claude**. 모든 대화가 0 에서 시작했다. 컨텍스트 붙여넣기 → 답변 받기 → 탭 닫기. 내일 또 비슷한 질문 → 같은 컨텍스트 또 붙여넣기. 지능은 진짜지만 *나* 에 대한 기억은 없었어.

각자는 훌륭한데 합쳐졌을 땐 아무것도 아니었다. 둘 사이에 다리가 없었으니까.

**Seanwiki 는 이 둘을 두 개의 도구가 아니라 한 개의 두 번째 두뇌로 보기 시작했을 때 나오는 답이야.** Obsidian vault 는 장기 기억. Claude 는 그걸 읽고, 그 위에 쓰고, 전체 구조를 정직하게 유지하는 추론 엔진.

시작할 때 인터뷰는 옵션이 아니라 본질이야. AI 한테 "네가 누구이고", "뭘 기록하고 싶고", "어떤 결과물을 원하는지" 가르치고, 그 답들을 `CLAUDE.md` / `AGENTS.md` 에 박아넣어서 이후 모든 세션이 같은 컨텍스트를 상속하게 만드는 게 인터뷰의 진짜 의미. 더 이상 매번 너 자신을 설명할 필요가 없어.

---

## Seanwiki 가 실제로 뭐냐면

macOS 앱. 약 135 MB. 드래그로 설치. 백그라운드 서비스·데몬·메뉴바 아이콘 디폴트 0개.

처음 열면 카드 두 개가 떠 — **Obsidian** 과 **Claude Code**. 각각 클릭해서 깔아 (둘 다 무료, 둘 다 로컬 실행). 셋업은 그게 다야.

**`+ 새 프로젝트`** → 카테고리 선택 → 폴더 지정 → 터미널에서 3~5개 질문에 답. 6분 후 너의 vault 가 이렇게 생겨:

```
<vault>/
├── CLAUDE.md              ← 매 AI 턴 자동 읽힘 — 너의 규칙
├── AGENTS.md              ← 같은 규칙, cross-AI 호환 (Codex/Cursor/Aider 도 따름)
├── 나의 핵심 맥락.md       ← 인터뷰 답변 기반 정체성 파일
│
├── inbox/                 ← 드롭존. 뭐든 던져.
├── raw/                   ← 불변 원본 박스. AI 가 절대 수정 못함.
│   ├── benchmarks/
│   ├── inspiration/
│   ├── research/
│   └── ...
│
├── wiki/                  ← Claude 의 해석본이 사는 공간
│   ├── index.md           ← 목차 (페이지당 한 줄)
│   └── log.md             ← 의미 있는 작업 모두 한 줄 로그
│
├── Output/                ← 최종 결과물 (초안·PDF·익스포트)
│
└── .claude/skills/        ← 직접 수정 가능한 슬래시 커맨드
    ├── ingest/SKILL.md    ← inbox 스캔 → 분류 → raw/ 이동 → wiki/ 갱신
    ├── query/SKILL.md     ← wiki 에 질문, [[wikilink]] 인용 포함 답변
    ├── lint/SKILL.md      ← 헬스체크 (고아 페이지·깨진 링크)
    └── <카테고리 extras>
```

### 일상 사용 흐름

**스크린샷 찍는다.** 그냥 `inbox/` 로 드래그. Claude 가 OCR + 시각 분석으로 "이거 경쟁사 가격표네" 인식 → `raw/benchmarks/competitor-pricing-<slug>.png` 로 이동 → `wiki/log.md` 에 한 줄 로그. 너는 파일 던지기만 했어.

**wiki 에 질문한다.** Claude Code 안에서 `/query "auth flow 어떻게 결정했지?"` → Claude 가 `wiki/index.md` 읽고 관련 페이지 찾아서 `[[wikilink]]` 인용 포함 답변. 모든 주장은 정확한 `raw/` 출처로 추적 가능. 환각된 컨텍스트 0.

**규칙 바꾸고 싶다.** `CLAUDE.md` 열어서 규칙 다시 쓰고 저장. 그 시점부터 모든 Claude 세션이 새 규칙을 따라. 재프롬프트·재학습 X. 설정 언어가 마크다운 하나야.

**커스텀 슬래시 커맨드 만들고 싶다.** `.claude/skills/` 에 새 `SKILL.md` 파일 — 그 커맨드가 뭐 해야 하는지 마크다운으로 묘사 → 저장. 다음 실행부터 Claude 가 자동으로 인식.

전체 시스템이 파일이야. 평범한 마크다운 파일. Seanwiki 가 내일 사라져도 너의 vault 는 다른 에디터에서 그대로 동작해.

---

## 절대 양보 안 하는 5가지

### 1. 자동 업데이트 절대 없음. 예외 없음.

자동 업데이트는 내가 절대 안 열어두는 백도어다. 내 GitHub 계정이 피싱당하거나 서명 키가 새는 순간, 자동 업데이터가 깔린 앱들엔 악성 바이너리가 그대로 밀려들어가. 수동 업데이트면 **언제** 받을지 본인이 정하고, **뭘** 받았는지 본인이 검증한다.

릴리즈마다 `ed25519` detached 서명 + SHA-256 동봉. 스크립트 한 번 돌리면 yes/no 가 나와. 몰래 버전 갈아끼기 없음. "자는 사이에 자동으로 업데이트됐어요" 없음.

### 2. 100% 로컬. vault 는 절대 외부로 안 나간다.

텔레메트리 없음. 라이선스 체크 없음. "익명 사용 통계" 따위 없음. 네가 직접 스위치를 켜기 전엔 어떤 것도 네 컴퓨터를 떠나지 않아.

이걸 자체 포맷이 아니라 Obsidian 위에 지은 이유 자체가 이거야 — Seanwiki 가 내일 사라져도 너의 vault 는 그냥 마크다운이라서 다른 에디터에서도 열리고, grep 도 되고, git 커밋도 가능해. 데이터가 도구보다 오래 살아남도록.

### 3. 외부 통신 디폴트 OFF. 채널별로 개별 opt-in.

Telegram 브릿지? 기본 OFF. 플러그인 자동 설치? 기본 OFF. 외부 API 호출? 기본 OFF. 각각이 스위치고, 본인이 켜고 싶을 때만 켜는 구조 — chat-id 화이트리스트 같은 안전장치 동반.

앱의 디폴트 상태는 "고립". 바깥 세상엔 opt-**in** 하는 거지, opt-**out** 하는 게 아니다.

### 4. `raw/` 는 불변. AI 가 절대 원본을 못 건드린다.

AI 가 내 노트 위에서 동작할 때 가장 큰 실패 모드는, "정리해줄게요" 하고 원본을 슬쩍 수정해버리는 것. 그건 절대 출시 안 해.

Seanwiki 는 vault 를 두 반으로 자른다 — `raw/` 는 영원히 너의 것이고, 한 번 들어간 파일은 어떤 AI 프로세스도 수정 못 함. `wiki/` 만 AI 가 쓸 수 있고, `wiki/` 안 모든 주장은 `[[wikilink]]` 인용으로 `raw/` 안 그대로의 출처까지 추적 가능.

덕분에 너는 모든 해석을 감사할 수 있어. 한 해석에 동의 안 하면 원본 안 건드리고 `wiki/` 페이지만 다시 쓰면 돼. 원본이 몰래 변형돼서 뭐가 바뀌었는지 알 수 없는 상태에는 절대 빠질 수 없는 구조.

### 5. 인터뷰. 템플릿이 아니라.

일반 템플릿은 "네가 이런 사람일 거다" 라는 추측이야. Seanwiki 의 인터뷰는 3~5개 물어봐 — 뭘 만드는지, 왜 기록하는지, 어떤 결과물 원하는지 — 답변을 `CLAUDE.md` 와 `AGENTS.md` 에 박아 넣어서, 이후 모든 AI 세션이 풀 컨텍스트로 시작하도록 만들어.

kickoff 프롬프트 자체는 내가 Obsidian + Claude 를 오래 붙여 쓰면서 계속 다듬어온 결과물이고, 지금 시점에선 내가 만든 것 중 가장 좋은 프롬프트야. 본인 도메인에 맞게 더 빡세게 다듬고 싶으면 앱의 **Prompt Setting** 에서 바로 수정 가능 — 그리고 한 번 수정하면 다음 프로젝트 만들 때도 그 버전이 그대로 들어가.

---

## 다운로드

### 1단계 — 본인 Mac 칩 확인

Apple 메뉴 → **About This Mac** → "Chip" 항목 확인:

- **Apple M1 / M2 / M3 / M4** → **Silicon** 빌드
- **Intel** → **Intel** 빌드

잘못 받으면 Rosetta 거쳐서 실행은 되지만 느리고 배터리도 더 먹어.

### 2단계 — 파일 받기

최신 버전: **v2.0.0**. [Releases](https://github.com/IT-Yun/seanwiki-releases/releases/latest) 에서 본인 아키텍처에 맞는 파일을 같은 폴더로 받아.

아키텍처마다 **두 가지 포맷** 이 올라가 있어 — 편한 걸로 받으면 돼 (둘 다 동일한 앱):

- **`.dmg`** — "더블클릭 → 앱을 Applications 로 드래그" 하는 전통적인 설치 이미지. 그냥 바로 실행하고 싶으면 이거.
- **`.zip`** — 같은 앱을 zip 으로 압축한 것. 아래 검증 스크립트를 먼저 돌려보고 싶으면 이거.

| 아키텍처 | `.dmg` (드래그 설치) | `.zip` (검증 후 설치) | 서명 |
|---|---|---|---|
| **Apple Silicon** (M1–M4) | `Seanwiki.Silicon-2.0.0-arm64.dmg` (~140 MB) | `Seanwiki.Silicon-2.0.0-arm64-mac.zip` (~135 MB) | 짝이 되는 `…​.sig` (89 B) |
| **Intel** | `Seanwiki.Intel-2.0.0.dmg` (~140 MB) | `Seanwiki.Intel-2.0.0-mac.zip` (~140 MB) | 짝이 되는 `…​.sig` (89 B) |

`.sig` 파일은 89바이트밖에 안 되니까 본체 파일이랑 **같은 폴더에** 같이 받아둬야 검증이 돼.

zip(또는 마운트한 `.dmg`) 안엔 앱 하나가 들어있고, 이름은 아키텍처별로 달라:

- Apple Silicon → **`Seanwiki Silicon.app`**
- Intel → **`Seanwiki Intel.app`**

(칩 이름을 일부러 파일명에 박아둠 — 한 맥에 둘 다 있어도 구분되게. 아래에서 "Seanwiki 앱" 은 네가 받은 둘 중 하나를 뜻해.)

#### 또는 터미널에서 바로 받기 (브라우저 없이 한 블록)

클릭하기 귀찮으면 이거 붙여넣어. 칩을 자동 감지해서 맞는 `.zip` + `.sig` 를 현재 폴더로 받아:

```bash
# 1) 본인 Mac 칩에 맞는 파일 자동 선택
#    (hw.optional.arm64 == 1 이면 Apple Silicon — Rosetta 셸 안에서도 정확함)
if [ "$(sysctl -in hw.optional.arm64 2>/dev/null)" = "1" ]; then
  FILE="Seanwiki.Silicon-2.0.0-arm64-mac.zip"
else
  FILE="Seanwiki.Intel-2.0.0-mac.zip"
fi
BASE="https://github.com/IT-Yun/seanwiki-releases/releases/download/v2.0.0"

# 2) 앱 + 서명파일을 현재 폴더로 다운로드
curl -L -o "$FILE"     "$BASE/$FILE"
curl -L -o "$FILE.sig" "$BASE/$FILE.sig"

echo "받음: $FILE  ($(du -h "$FILE" | cut -f1))"
```

(GitHub CLI 있으면 한 방에: `gh release download v2.0.0 -R IT-Yun/seanwiki-releases -p "Seanwiki.*"` — 원하는 아키텍처만 받으려면 `-p "*Silicon*"` 또는 `-p "*Intel*"`)

받은 다음 검증(3단계) → 압축 풀기 → 앱을 `/Applications/` 로 드래그.

### 3단계 — 설치 전 검증

10초짜리 단계. 변조된 바이너리로부터 너를 보호하는 마지막 방어선. 이 레포 clone 하거나 `scripts/` 안 두 파일만 받은 후, 받은 파일을 스크립트에 넘겨:

```bash
cd <파일-받은-폴더>
# Apple Silicon:
bash <verify-스크립트-경로>/scripts/verify-release.sh "Seanwiki.Silicon-2.0.0-arm64-mac.zip"
# Intel:
bash <verify-스크립트-경로>/scripts/verify-release.sh "Seanwiki.Intel-2.0.0-mac.zip"
```

스크립트가 같은 폴더의 짝 `.sig` 를 자동으로 찾아. 성공 시 출력:

```
→ Verifying: Seanwiki.Silicon-2.0.0-arm64-mac.zip

  computed SHA-256: 8b3c0a613cc54bff0664d650f01b86edd4566a9e9af21113a70a9547f8507cdb

→ Verifying ed25519 signature against published public key
  ✓ ed25519 signature VERIFIED

✓ Verification complete. Safe to drag into /Applications/.
```

**서명 검증이 실패하면 파일 지우고 다시 받아.** 설치하지 마. 전송 중 손상되었거나 누가 변조한 것 — 둘 다 너의 책임이 아니야. 그냥 다시 받으면 돼.

#### 공개 SHA-256 (v2.0.0)

스크립트 없이 직접 해시만 비교하고 싶으면 `shasum -a 256 <파일>` 돌려서 아래랑 대조:

| 파일 | SHA-256 |
|---|---|
| `Seanwiki.Silicon-2.0.0-arm64-mac.zip` | `8b3c0a613cc54bff0664d650f01b86edd4566a9e9af21113a70a9547f8507cdb` |
| `Seanwiki.Silicon-2.0.0-arm64.dmg` | `bd67fec938dc1a833a1487ee305c72fa5999f63853c2e54b98470e8a21c271b1` |
| `Seanwiki.Intel-2.0.0-mac.zip` | `a49ac024181627dc68eb90fd2c8379179ce7c243ab8667c1156dc72d2ba2ca55` |
| `Seanwiki.Intel-2.0.0.dmg` | `79d2c63ea74789e7e6a5aaed8d2156ddb1311ba691d1a8818823b3d502b51396` |

공개키 (`scripts/seanwiki-pubkey.txt`):

```
nzi9RYywbRu//kXHVt8aNI0w5U2i2g/YZI0u65QsNc8=
```

내가 서명할 때 쓰는 유일한 키. 미래 릴리즈가 다른 키로 검증되면 **내가 만든 게 아니야.**

### 4단계 — 설치

**`.dmg` 로 설치:** 더블클릭 → 창이 열리면서 앱과 `Applications` 바로가기가 보여 → 앱을 `Applications` 위로 드래그. 끝. 끝나면 디스크 이미지는 추출(eject) 해.

**`.zip` 으로 설치:** 더블클릭으로 압축 풀기 (또는 터미널에서 `unzip "Seanwiki.Silicon-2.0.0-arm64-mac.zip"`) → 앱이 나와 → `/Applications/` 로 드래그.

어느 쪽이든 드래그하는 앱은 `Seanwiki Silicon.app` (Apple Silicon) 또는 `Seanwiki Intel.app` (Intel) 이야.

### 5단계 — 첫 실행 (중요 — Gatekeeper 우회 / 개인정보 보호에서 풀기)

현재는 ad-hoc 서명이라 (Developer ID 서명은 배포 규모 커지면 도입) 첫 실행 시 Gatekeeper 가 이런 에러로 막아:

> **"Apple이(가) 'Seanwiki Silicon'에 Mac에 손상을 입히거나 사용자의 개인정보를 침해할 수 있는 악성 소프트웨어가 없음을 확인할 수 없습니다."**

(Intel 맥이면 "Seanwiki Intel" 로 나옴.) ad-hoc 서명 앱이라 **정상**이야. 진짜 악성코드 경고가 아니라 "이 개발자가 누군지 모르겠다" 경고. macOS 버전에 맞춰 셋 중 하나:

**옵션 A — macOS Sequoia (15.0 이상) — 개인정보 보호 및 보안에서 풀기**

Sequoia 부터 옛날 우클릭 → 열기 트릭이 사라졌어. 새 절차:

1. 앱 더블클릭 → "확인할 수 없음" 다이얼로그
2. **완료** 클릭 (절대 **"휴지통으로 이동" 누르지 마** — 앱이 삭제됨)
3.  → **시스템 설정** → **개인정보 보호 및 보안** 열기
4. **맨 아래까지 스크롤** 해서 **보안** 섹션을 봐. *"Seanwiki Silicon은(는) 확인된 개발자의 것이 아니므로 차단되었습니다"* 같은 문구 옆에 **확인 없이 열기** 버튼이 있어. 그거 클릭.
5. 확인 다이얼로그가 또 뜸 → **확인 없이 열기** 한 번 더 → Touch ID 또는 로그인 비밀번호로 인증.
6. 앱이 실행돼. 이후 모든 더블클릭은 평범하게 열림 — 이 과정은 딱 한 번만.

> **확인 없이 열기** 버튼이 안 보이면 1번을 건너뛴 거야 — macOS 는 앱을 *한 번 열려고 시도해서 차단된 직후에만* 이 버튼을 보여줘. 앱을 한 번 더블클릭하고 완료 누른 다음, 다시 개인정보 보호 및 보안으로 가.

**옵션 B — macOS Sonoma (14) 이하**

1. 앱 우클릭 (또는 Control+클릭) → **열기**
2. 다이얼로그 → **열기**
3. 끝. (이후 더블클릭은 평범하게 열림.)

**옵션 C — 터미널 한 줄 (모든 macOS 공통, 제일 빠름)**

Apple 의 quarantine 플래그를 직접 제거. 개인정보 보호 및 보안에서 하는 거랑 똑같은 동작을 커맨드라인에서 하는 것:

```bash
# Apple Silicon:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Silicon.app"
# Intel:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Intel.app"
```

그 다음 앱 더블클릭 → 다이얼로그 없이 바로 열림. (`xattr -cr "<경로>"` 도 동작 — 다만 quarantine 만이 아니라 *모든* 확장 속성을 지워.)

> **왜 이런 게 뜨냐면?** macOS 는 인터넷에서 받은 모든 파일에 `com.apple.quarantine` 플래그를 붙여. 유료 Apple Developer ID 로 서명된 앱이면 Gatekeeper 가 서명을 확인하고 통과시켜. 이 빌드는 *ad-hoc* 서명이라 (아직 유료 인증서 없음) Gatekeeper 가 개발자를 식별 못 해서 막는 거고 — 위 세 방법 중 하나로 네가 한 번 명시적으로 허용해주면 풀려. 앱이 위험하다는 뜻이 전혀 아니야. Apple 이 보증해줄 돈을 안 냈다는 뜻이지. 그래서 릴리즈마다 내 ed25519 키로 따로 서명하는 거야 (3단계) — Apple 의 체인을 신뢰하지 않고도 이게 진짜 내가 만든 건지 네가 직접 검증할 수 있게.

### 6단계 — 처음 보이는 화면

EmptyState 화면에 카드 두 개 — **Obsidian** + **Claude Code**. 각각 클릭하면 공식 다운로드 페이지 열림. 둘 다 무료, 둘 다 1분 안에 설치.

둘 다 깔았으면 우상단 **`+ 새 프로젝트`** 누르고 안내 따라가면 끝.

---

## 설치 후 — 첫 10분 흐름

1. **카테고리 선택.** 기본 5종: 앱 만들기 / 업무·기업 / 학교 과제 / 일반 프로젝트 / 웹사이트. 가장 가까운 거 골라. 규칙은 나중에 바꿀 수 있어.
2. **폴더 지정.** 앱에서 Obsidian 띄워서 vault 고르거나, Finder 로 기존 폴더 선택. 그 폴더가 프로젝트 루트가 돼.
3. **터미널에서 인터뷰 시작.** Claude 가 3~5개 짧은 질문. 성실하게 답해. 성실할수록 vault 가 본인 모양으로 잡혀.
4. **파일들이 실시간으로 디스크에 생성됨.** 답하는 동안 Claude 가 `CLAUDE.md`, `AGENTS.md`, `나의 핵심 맥락.md`, `raw/` 하위 폴더들, `.claude/skills/` 까지 다 써. Finder 에서 그 과정 그대로 볼 수 있어.
5. **마지막에 한 줄 출력:** "✅ 셋업 완료 — 7개 산출물 디스크에 생성됨. 이제 뭐든 시작하세요."

이제 네가 원래 하려던 거 하면 돼. `inbox/` 에 스크린샷 드롭. `/query` 로 질문. Obsidian 에서 파일 열기. 전부 그냥 마크다운.

---

## 업데이트

설치 흐름 그대로 반복. 새 `.zip` 과 `.sig` 받아서 스크립트로 검증 → 새 `.app` 을 `/Applications/` 로 드래그 (기존 거 덮어쓰기 — macOS 가 "교체?" 물어보면 예).

앱은 **자기 혼자 업데이트 체크 안 함**. 알림 안 띄움. "새 버전 있나요?" 외부에 묻지 않음. 의도된 설계.

새 버전 어떻게 알아? 이 버전을 발견한 그 채널 그대로 — LinkedIn, GitHub Releases 페이지, 입소문. 같은 방식으로 다음 업데이트도 가져가면 돼.

---

## 이슈 / 피드백

이 레포 이슈로 올리거나 LinkedIn DM. 빙빙 돌려서 우회하느니 빨리 듣고 싶어.

철학 자체가 이상해 보이는 부분 있으면 — 너무 빡빡한 규칙, 디폴트 뒤집고 싶은 거 — 말해줘. 강한 의견을 갖되, 가볍게 들고 다닐 것.

---

## 라이선스

[MIT](LICENSE) © Seung yun Lee

소스 레포는 현재 비공개. 표면이 안정화되고 거친 부분 다듬어지면 공개 논의 가능.

---

<sub>구조 일부 — JSON 파일 기반 state, git-worktree 워커 격리, 수동 서명 업데이트 — 은 [Octo](https://github.com/anthropics/octo) · OMC 의 패턴을 일부 참고했음.</sub>
