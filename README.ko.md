<div align="center">

# Seanwiki

**Obsidian과 Claude Code를 하나로 묶은, 나만의 지식 백과사전.**

Obsidian과 Claude Code를 하나의 vault로 연결하는 macOS 앱입니다.
내가 대화하는 AI가, 내가 이미 신뢰하는 그 노트들을 직접 읽고 거기에 다시 정리해 넣습니다.

<p>
  <a href="https://github.com/IT-Yun/seanwiki-releases/releases/latest"><img alt="최신 릴리즈" src="https://img.shields.io/github/v/release/IT-Yun/seanwiki-releases?logo=github&label=release&color=2C2E3B"></a>
  <a href="LICENSE"><img alt="라이선스: MIT" src="https://img.shields.io/github/license/IT-Yun/seanwiki-releases?color=blue"></a>
  <img alt="플랫폼: macOS" src="https://img.shields.io/badge/platform-macOS-000000?logo=apple&logoColor=white">
  <a href="https://github.com/IT-Yun/seanwiki-releases/releases"><img alt="다운로드 수" src="https://img.shields.io/github/downloads/IT-Yun/seanwiki-releases/total?logo=github&color=success"></a>
  <a href="https://github.com/IT-Yun/seanwiki-releases/stargazers"><img alt="스타" src="https://img.shields.io/github/stars/IT-Yun/seanwiki-releases?style=social"></a>
</p>

<p>
  <img alt="Electron" src="https://img.shields.io/badge/Electron-2C2E3B?logo=electron&logoColor=9FEAF9">
  <img alt="React" src="https://img.shields.io/badge/React-20232A?logo=react&logoColor=61DAFB">
  <img alt="TypeScript" src="https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white">
  <img alt="Claude" src="https://img.shields.io/badge/Claude_Code-D97757?logo=anthropic&logoColor=white">
  <img alt="Obsidian" src="https://img.shields.io/badge/Obsidian-7C3AED?logo=obsidian&logoColor=white">
</p>

<br>

<img alt="Seanwiki 스크린샷" src="docs/screenshot.png" width="820">

<br><br>

[English](README.md) · **한국어**

</div>

> 이 저장소는 **배포(릴리즈) 전용**입니다. 소스 코드는 당분간 비공개로 두고, 이곳에서는
> 서명된 설치 파일을 받고, 검증하고, 이 도구의 설계 철학을 읽어보고, 나에게 맞는지 판단할 수 있습니다.
> 쓸 만해 보인다면 ⭐ 하나가 다른 사람들이 이 프로젝트를 발견하는 데 큰 도움이 됩니다.

---

## 왜 만들었나

오랫동안 저에게는 서로 연결되지 않는 두 가지 습관이 있었습니다.

첫 번째는 **Obsidian**이었습니다. 회의 노트, 스크린샷, 반쯤 정리된 아이디어, 북마크만 해두고 읽지 않은 논문까지 전부 여기에 쌓았습니다. vault는 수천 개의 마크다운 파일로 불어났고, 결국 다시 들여다보지 않는 *생각의 무덤*이 되었습니다.

두 번째는 **Claude**였습니다. 모든 대화가 매번 백지에서 시작했습니다. 맥락을 붙여넣고, 답을 받고, 탭을 닫습니다. 다음 날 비슷한 질문을 하려면 같은 맥락을 또 붙여넣어야 했습니다. 똑똑하지만, *저에 대한 기억*은 전혀 없었습니다.

각각은 훌륭했지만 따로 놀 때는 의미가 없었습니다. 둘 사이를 잇는 다리가 없었기 때문입니다.

**Seanwiki는 이 둘을 서로 다른 두 도구가 아니라 하나의 '두 번째 뇌'로 다루기 시작했을 때 나온 결과물입니다.** Obsidian vault는 장기 기억이 되고, Claude는 그 기억을 읽고, 그 위에 정리해 넣고, 전체 구조를 일관되게 유지하는 추론 엔진이 됩니다.

시작할 때 진행하는 인터뷰는 선택이 아니라 핵심입니다. 인터뷰는 AI에게 "내가 누구인지", "무엇을 기록하고 싶은지", "어떤 결과물을 원하는지"를 가르치고, 그 답을 `CLAUDE.md`와 `AGENTS.md`에 새겨 둡니다. 그래서 이후 모든 세션이 같은 맥락을 그대로 이어받습니다. 더 이상 매번 나를 처음부터 설명할 필요가 없습니다.

---

## Seanwiki는 실제로 어떤 도구인가

약 135 MB짜리 macOS 앱입니다. 드래그 한 번으로 설치되고, 백그라운드 서비스나 데몬, 메뉴바 아이콘 같은 것은 기본적으로 전혀 없습니다.

처음 실행하면 **Obsidian**과 **Claude Code** 두 개의 카드가 보입니다. 각각 눌러 설치하면 됩니다(둘 다 무료이고, 둘 다 로컬에서 동작합니다). 준비 과정은 이게 전부입니다.

**`+ 새 프로젝트`** 를 누르고, 카테고리를 고르고, 폴더를 지정한 뒤, 터미널에서 3~5개의 질문에 답합니다. 6분 뒤면 vault가 다음과 같은 모습이 됩니다.

```
<vault>/
├── CLAUDE.md              ← 매 AI 턴마다 자동으로 읽히는 나의 규칙
├── AGENTS.md              ← 같은 규칙의 cross-AI 버전 (Codex / Cursor / Aider도 따름)
├── 나의 핵심 맥락.md       ← 인터뷰 답변으로 채워지는 정체성 파일
│
├── inbox/                 ← 드롭존. 무엇이든 일단 던져 넣는 곳.
├── raw/                   ← 불변 원본 보관소. AI가 절대 수정하지 못함.
│   ├── benchmarks/
│   ├── inspiration/
│   ├── research/
│   └── ...
│
├── wiki/                  ← Claude의 해석본이 쌓이는 공간
│   ├── index.md           ← 목차 (페이지마다 한 줄)
│   └── log.md             ← 의미 있는 작업이 한 줄씩 기록되는 로그
│
├── Output/                ← 최종 결과물 (초안 / PDF / 내보내기)
│
└── .claude/skills/        ← 직접 수정할 수 있는 슬래시 커맨드
    ├── ingest/SKILL.md    ← inbox 정리 → 분류 → raw/로 이동 → wiki/ 갱신
    ├── query/SKILL.md     ← wiki에 질문하면 [[wikilink]] 인용과 함께 답변
    ├── lint/SKILL.md      ← 상태 점검 (고아 페이지 / 깨진 링크)
    └── <카테고리별 추가 커맨드>
```

### 실제로 매일 어떻게 쓰는가

**스크린샷을 찍습니다.** 그냥 `inbox/`로 끌어다 놓기만 하면 됩니다. Claude가 이미지를 읽고 내용을 파악해(예: "경쟁사 가격표 같다") `raw/benchmarks/competitor-pricing-<slug>.png`로 옮기고, `wiki/log.md`에 그 사실을 한 줄로 기록합니다. 나는 파일을 던져 넣기만 했을 뿐입니다.

**wiki에 질문합니다.** Claude Code에서 `/query "인증 흐름은 어떻게 결정했더라?"` 라고 물으면, Claude가 `wiki/index.md`를 읽고 관련 페이지를 찾아 `[[wikilink]]` 인용과 함께 답합니다. 모든 주장은 정확한 `raw/` 원본까지 추적할 수 있고, 지어낸 맥락은 없습니다.

**규칙을 바꾸고 싶습니다.** `CLAUDE.md`를 열어 규칙을 고쳐 쓰고 저장하면 됩니다. 그 시점부터 모든 Claude 세션이 새 규칙을 따릅니다. 다시 프롬프트를 짤 필요도, 재학습도 없습니다. 설정 언어는 오직 마크다운 하나입니다.

**나만의 슬래시 커맨드를 만들고 싶습니다.** `.claude/skills/`에 새 `SKILL.md` 파일을 만들고, 그 커맨드가 무엇을 해야 하는지 마크다운으로 적어 저장하면 됩니다. 다음 실행부터 Claude가 알아서 인식합니다.

이 시스템은 전부 파일입니다. 평범한 마크다운 파일이죠. 그래서 Seanwiki가 내일 사라지더라도 vault는 다른 어떤 에디터에서든 그대로 동작합니다.

---

## 절대 타협하지 않는 5가지 원칙

### 1. 업데이트는 오직 수동으로. 예외는 없습니다.

자동 업데이트는 제가 절대 열어두지 않는 뒷문입니다. 제 GitHub 계정이 탈취되거나 서명 키가 유출되는 순간, 자동 업데이트 기능은 모든 설치 환경에 악성 바이너리를 조용히 밀어 넣을 수 있습니다. 수동 업데이트라면 **언제** 받을지, **무엇을** 받았는지를 사용자가 직접 정하고 검증합니다.

모든 릴리즈에는 `ed25519` 분리 서명과 SHA-256 해시가 함께 제공됩니다. 스크립트를 한 번 실행하면 통과 여부를 바로 알려줍니다. 몰래 버전이 바뀌는 일도, "자는 사이에 알아서 업데이트됐다"는 일도 없습니다.

### 2. 100% 로컬. vault는 절대 외부로 나가지 않습니다.

텔레메트리도, 라이선스 확인도, "익명 사용 통계"도 없습니다. 사용자가 직접 스위치를 켜기 전에는 어떤 것도 컴퓨터 밖으로 나가지 않습니다.

자체 포맷이 아니라 Obsidian 위에 만든 이유가 바로 이것입니다. Seanwiki가 사라지더라도 vault는 그저 마크다운이라, 다른 에디터에서 열 수 있고 grep으로 검색할 수 있으며 git으로 버전 관리할 수도 있습니다. 데이터가 도구보다 오래 살아남도록 설계했습니다.

### 3. 외부 통신은 기본 꺼짐. 채널별로 따로 켭니다.

Telegram 연동도, 플러그인 자동 설치도, 외부 API 호출도 모두 기본값은 '꺼짐'입니다. 각각이 별도의 스위치이고, 필요할 때만 직접 켜는 구조이며, chat-id 화이트리스트 같은 안전장치가 함께 붙습니다.

앱의 기본 상태는 '외부와 단절'입니다. 바깥세상과는 필요할 때 스스로 '연결하는' 것이지, 켜져 있는 것을 '끄는' 방식이 아닙니다.

### 4. `raw/`는 불변. AI는 원본을 절대 건드리지 않습니다.

AI가 내 노트를 다룰 때 가장 위험한 상황은, "정리해 드릴게요" 하면서 원본을 슬쩍 고쳐 버리는 것입니다. 그런 동작은 절대 넣지 않았습니다.

Seanwiki는 vault를 둘로 나눕니다. `raw/`는 영원히 사용자의 것이며, 한 번 들어간 파일은 어떤 AI 프로세스도 수정할 수 없습니다. AI가 쓸 수 있는 곳은 `wiki/`뿐이고, `wiki/`의 모든 주장은 `[[wikilink]]` 인용을 통해 `raw/`의 원본까지 그대로 추적할 수 있습니다.

덕분에 모든 해석을 직접 검증할 수 있습니다. 어떤 해석이 마음에 들지 않으면 원본은 그대로 둔 채 `wiki/` 페이지만 고쳐 쓰면 됩니다. 원본이 나도 모르게 바뀌어 무엇이 달라졌는지 알 수 없게 되는 상황은 애초에 생기지 않습니다.

### 5. 템플릿이 아니라, 인터뷰.

일반적인 템플릿은 "당신은 아마 이런 사람일 것이다"라는 추측에 불과합니다. Seanwiki의 인터뷰는 3~5가지를 직접 묻습니다. 무엇을 만드는지, 왜 기록하는지, 어떤 결과물을 원하는지를요. 그리고 그 답을 `CLAUDE.md`와 `AGENTS.md`에 새겨, 이후 모든 AI 세션이 완전한 맥락에서 시작하게 합니다.

처음의 kickoff 프롬프트는 제가 Obsidian과 Claude를 오랫동안 함께 쓰며 다듬어 온 결과물이고, 지금까지 제가 만든 것 중 가장 좋은 버전입니다. 본인 분야에 맞게 더 손보고 싶다면 앱의 **Prompt Setting**에서 바로 수정할 수 있고, 한 번 고치면 다음 프로젝트를 만들 때도 그 버전이 그대로 적용됩니다.

---

## 다운로드

### 1단계 — 내 Mac의 칩 확인

Apple 메뉴 → **이 Mac에 관하여** → "칩" 항목을 확인합니다.

- **Apple M1 / M2 / M3 / M4** → **Silicon** 빌드
- **Intel** → **Intel** 빌드

잘못 받으면 Rosetta를 거쳐 실행은 되지만, 더 느리고 배터리도 더 많이 씁니다.

### 2단계 — 파일 받기

최신 버전은 **v2.0.0**입니다. [Releases](https://github.com/IT-Yun/seanwiki-releases/releases/latest)에서 내 아키텍처에 맞는 파일을 같은 폴더로 내려받습니다.

아키텍처마다 **두 가지 포맷**이 올라가 있습니다. 둘은 완전히 같은 앱이니 편한 쪽으로 받으면 됩니다.

- **`.dmg`** — "더블클릭 → 앱을 Applications로 드래그"하는 전통적인 설치 이미지입니다. 바로 실행하고 싶다면 이 쪽.
- **`.zip`** — 같은 앱을 압축한 파일입니다. 아래 검증 스크립트를 먼저 돌려보고 싶다면 이 쪽.

| 아키텍처 | `.dmg` (드래그 설치) | `.zip` (검증 후 설치) | 서명 |
|---|---|---|---|
| **Apple Silicon** (M1–M4) | `Seanwiki.Silicon-2.0.0-arm64.dmg` (~140 MB) | `Seanwiki.Silicon-2.0.0-arm64-mac.zip` (~135 MB) | 짝이 되는 `…​.sig` (89 B) |
| **Intel** | `Seanwiki.Intel-2.0.0.dmg` (~140 MB) | `Seanwiki.Intel-2.0.0-mac.zip` (~140 MB) | 짝이 되는 `…​.sig` (89 B) |

`.sig` 파일은 89바이트밖에 안 되니, 본체 파일과 **같은 폴더에** 함께 받아 두어야 검증이 됩니다.

zip(또는 마운트한 `.dmg`) 안에는 앱 하나가 들어 있고, 이름은 아키텍처마다 다릅니다.

- Apple Silicon → **`Seanwiki Silicon.app`**
- Intel → **`Seanwiki Intel.app`**

(칩 이름을 일부러 파일명에 넣어 두었습니다. 한 Mac에 둘 다 있어도 구분되도록요. 아래에서 "Seanwiki 앱"은 둘 중 내가 받은 쪽을 가리킵니다.)

#### 또는 터미널에서 바로 받기 (브라우저 없이 한 번에)

클릭이 번거롭다면 아래를 붙여넣으세요. 칩을 자동으로 감지해 맞는 `.zip`과 `.sig`를 현재 폴더로 받습니다.

```bash
# 1) 내 Mac 칩에 맞는 파일 자동 선택
#    (hw.optional.arm64 == 1 이면 Apple Silicon — Rosetta 셸 안에서도 정확함)
if [ "$(sysctl -in hw.optional.arm64 2>/dev/null)" = "1" ]; then
  FILE="Seanwiki.Silicon-2.0.0-arm64-mac.zip"
else
  FILE="Seanwiki.Intel-2.0.0-mac.zip"
fi
BASE="https://github.com/IT-Yun/seanwiki-releases/releases/download/v2.0.0"

# 2) 앱 + 서명 파일을 현재 폴더로 다운로드
curl -L -o "$FILE"     "$BASE/$FILE"
curl -L -o "$FILE.sig" "$BASE/$FILE.sig"

echo "받음: $FILE  ($(du -h "$FILE" | cut -f1))"
```

(GitHub CLI가 있다면 한 번에: `gh release download v2.0.0 -R IT-Yun/seanwiki-releases -p "Seanwiki.*"` — 특정 아키텍처만 받으려면 `-p "*Silicon*"` 또는 `-p "*Intel*"`)

받은 뒤에는 검증(3단계) → 압축 풀기 → 앱을 `/Applications/`로 드래그합니다.

### 3단계 — 설치 전 검증

10초면 끝나는 단계로, 변조된 바이너리로부터 나를 지키는 마지막 방어선입니다. 이 저장소를 clone하거나 `scripts/` 안의 두 파일만 받은 뒤, 받은 파일을 스크립트에 넘깁니다.

```bash
cd <파일-받은-폴더>
# Apple Silicon:
bash <verify-스크립트-경로>/scripts/verify-release.sh "Seanwiki.Silicon-2.0.0-arm64-mac.zip"
# Intel:
bash <verify-스크립트-경로>/scripts/verify-release.sh "Seanwiki.Intel-2.0.0-mac.zip"
```

스크립트는 같은 폴더에 있는 짝 `.sig`를 자동으로 찾습니다. 성공하면 다음과 같이 출력됩니다.

```
→ Verifying: Seanwiki.Silicon-2.0.0-arm64-mac.zip

  computed SHA-256: 8b3c0a613cc54bff0664d650f01b86edd4566a9e9af21113a70a9547f8507cdb

→ Verifying ed25519 signature against published public key
  ✓ ed25519 signature VERIFIED

✓ Verification complete. Safe to drag into /Applications/.
```

**서명 검증에 실패하면 파일을 지우고 다시 받으세요. 설치하면 안 됩니다.** 전송 중 손상되었거나 누군가 변조한 것인데, 둘 다 사용자가 해결할 문제가 아닙니다. 새로 받으면 됩니다.

#### 공개 SHA-256 (v2.0.0)

스크립트 없이 해시만 직접 비교하고 싶다면 `shasum -a 256 <파일>`을 실행해 아래와 대조하세요.

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

제가 서명에 사용하는 유일한 키입니다. 앞으로의 릴리즈가 다른 키로 검증된다면 **제가 만든 것이 아닙니다.**

### 4단계 — 설치

**`.dmg`로 설치:** 더블클릭하면 창이 열리며 앱과 `Applications` 바로가기가 보입니다 → 앱을 `Applications` 위로 드래그하면 끝입니다. 끝나면 디스크 이미지는 추출(eject)하세요.

**`.zip`으로 설치:** 더블클릭으로 압축을 풀거나(터미널에서는 `unzip "Seanwiki.Silicon-2.0.0-arm64-mac.zip"`) 앱이 나오면 `/Applications/`로 드래그합니다.

어느 쪽이든 드래그하는 앱은 `Seanwiki Silicon.app`(Apple Silicon) 또는 `Seanwiki Intel.app`(Intel)입니다.

### 5단계 — 첫 실행 (중요 — Gatekeeper 우회)

현재는 ad-hoc 서명이라(Developer ID 서명은 배포 규모가 커지면 도입할 예정입니다) 첫 실행 때 Gatekeeper가 다음과 같은 메시지로 앱을 막습니다.

> **"Apple이(가) 'Seanwiki Silicon'에 Mac에 손상을 입히거나 사용자의 개인정보를 침해할 수 있는 악성 소프트웨어가 없음을 확인할 수 없습니다."**

(Intel Mac이면 "Seanwiki Intel"로 표시됩니다.) ad-hoc 서명 앱에서는 **정상적인** 동작입니다. 진짜 악성코드 경고가 아니라 "이 개발자가 누구인지 확인할 수 없다"는 경고입니다. macOS 버전에 맞춰 아래 셋 중 하나를 따르세요.

**옵션 A — macOS Sequoia (15.0 이상) — 개인정보 보호 및 보안에서 허용**

Sequoia부터는 예전의 '우클릭 → 열기' 방법이 사라졌습니다. 새 절차는 이렇습니다.

1. 앱을 더블클릭하면 "확인할 수 없음" 창이 뜹니다.
2. **완료**를 누릅니다. (절대 **"휴지통으로 이동"을 누르지 마세요.** 앱이 삭제됩니다.)
3.  → **시스템 설정** → **개인정보 보호 및 보안**을 엽니다.
4. **맨 아래까지 스크롤**해 **보안** 섹션을 봅니다. *"Seanwiki Silicon은(는) 확인된 개발자의 것이 아니므로 차단되었습니다"* 같은 문구 옆에 **확인 없이 열기** 버튼이 있습니다. 이 버튼을 누릅니다.
5. 확인 창이 한 번 더 뜨면 **확인 없이 열기**를 다시 누르고 Touch ID 또는 로그인 암호로 인증합니다.
6. 앱이 실행됩니다. 이후로는 더블클릭만으로 평범하게 열립니다. 이 과정은 딱 한 번만 하면 됩니다.

> **확인 없이 열기** 버튼이 보이지 않는다면 1번을 건너뛴 것입니다. macOS는 앱을 *한 번 열려고 시도해 차단된 직후에만* 이 버튼을 보여줍니다. 앱을 다시 한 번 더블클릭하고 완료를 누른 다음, 개인정보 보호 및 보안으로 돌아가세요.

**옵션 B — macOS Sonoma (14) 이하**

1. 앱을 우클릭(또는 Control+클릭) → **열기**
2. 창이 뜨면 → **열기**
3. 끝입니다. (이후로는 더블클릭으로 열립니다.)

**옵션 C — 터미널 한 줄 (모든 macOS 공통, 가장 빠름)**

Apple의 quarantine 플래그를 직접 제거하는 방법입니다. 개인정보 보호 및 보안에서 하는 것과 똑같은 동작을 명령어로 하는 것뿐입니다.

```bash
# Apple Silicon:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Silicon.app"
# Intel:
xattr -dr com.apple.quarantine "/Applications/Seanwiki Intel.app"
```

그다음 앱을 더블클릭하면 창 없이 바로 열립니다. (`xattr -cr "<경로>"`도 동작하지만, 이쪽은 quarantine만이 아니라 *모든* 확장 속성을 지웁니다.)

> **왜 이런 일이 생기나요?** macOS는 인터넷에서 받은 모든 파일에 `com.apple.quarantine` 플래그를 붙입니다. 유료 Apple Developer ID로 서명된 앱이면 Gatekeeper가 서명을 확인하고 통과시킵니다. 이 빌드는 *ad-hoc* 서명이라(아직 유료 인증서가 없습니다) Gatekeeper가 개발자를 식별하지 못해 막는 것이고, 위 세 방법 중 하나로 한 번 직접 허용하면 풀립니다. 앱이 위험하다는 뜻이 전혀 아니라, Apple에 보증 비용을 내지 않았다는 뜻일 뿐입니다. 그래서 릴리즈마다 제 ed25519 키로 따로 서명합니다(3단계). Apple의 신뢰 체계에 기대지 않고도, 이게 정말 제가 만든 것인지 직접 검증할 수 있도록요.

### 6단계 — 처음 보이는 화면

처음 화면에는 **Obsidian**과 **Claude Code** 두 개의 카드가 있습니다. 각각 누르면 공식 다운로드 페이지가 열립니다. 둘 다 무료이고, 각각 1분이면 설치됩니다.

둘 다 설치했으면 오른쪽 위의 **`+ 새 프로젝트`** 를 누르고 안내를 따라가면 됩니다.

---

## 설치 후 — 첫 10분의 흐름

1. **카테고리 선택.** 기본 5종(앱 만들기 / 업무·기업 / 학교 과제 / 일반 프로젝트 / 웹사이트) 중 가장 가까운 것을 고릅니다. 규칙은 나중에 바꿀 수 있습니다.
2. **폴더 지정.** 앱에서 Obsidian을 열어 vault를 고르거나, Finder에서 기존 폴더를 선택합니다. 그 폴더가 프로젝트의 루트가 됩니다.
3. **터미널에서 인터뷰 시작.** Claude가 3~5개의 짧은 질문을 합니다. 솔직하게 답할수록 vault가 나에게 더 잘 맞게 만들어집니다.
4. **파일이 실시간으로 생성됨.** 답하는 동안 Claude가 `CLAUDE.md`, `AGENTS.md`, `나의 핵심 맥락.md`, `raw/` 하위 폴더, `.claude/skills/`까지 모두 작성합니다. Finder에서 그 과정을 그대로 지켜볼 수 있습니다.
5. **마지막에 한 줄로 마무리:** "✅ 셋업 완료 — 7개 산출물 생성됨. 이제 무엇이든 시작하세요."

이제 원래 하려던 일을 하면 됩니다. `inbox/`에 스크린샷을 떨어뜨리고, `/query`로 질문하고, Obsidian에서 파일을 엽니다. 전부 그냥 마크다운입니다.

---

## 업데이트

설치와 똑같은 흐름입니다. 새 `.zip`과 `.sig`를 받아 스크립트로 검증한 뒤, 새 `.app`을 `/Applications/`로 드래그합니다(기존 앱 덮어쓰기 — macOS가 "바꾸시겠습니까?"라고 물으면 예).

앱은 **스스로 업데이트를 확인하지 않습니다.** 알림도 띄우지 않고, "새 버전이 있나요?"라고 외부에 묻지도 않습니다. 의도된 설계입니다.

그럼 새 버전은 어떻게 알 수 있을까요? 이 버전을 알게 된 그 경로(LinkedIn, GitHub Releases 페이지, 입소문)를 통해서입니다. 다음 업데이트도 같은 방식으로 받으면 됩니다.

---

## 이슈 / 피드백

이 저장소에 이슈를 남기거나 LinkedIn으로 DM 주세요. 문제를 우회하기보다 일찍 듣는 편이 좋습니다.

설계 철학 자체에서 어색한 부분(너무 엄격한 규칙, 바꾸고 싶은 기본값 등)이 보이면 알려 주세요. 의견은 분명하게, 그러나 언제든 바꿀 수 있게 열어 두고 있습니다.

---

## 라이선스

[MIT](LICENSE) © Seung yun Lee

소스 저장소는 현재 비공개입니다. 표면이 안정되고 거친 부분이 다듬어지면 공개를 논의할 수 있습니다.

---

<div align="center">

Seanwiki가 시간을 아껴 주었다면, ⭐ 하나가 다른 사람들이 이 프로젝트를 발견하는 데 도움이 됩니다.

<sub>구조 일부 — JSON 파일 기반 상태 관리, git-worktree 워커 격리, 수동 서명 업데이트 —
는 [Octo](https://github.com/anthropics/octo)와 OMC의 패턴을 일부 참고했습니다.</sub>

</div>
