## 강사용 실습 운영 대본(Runbook) — 실습생 대상, merge 기본

### 목표

- 실습이 “각자 알아서”가 아니라, **미션-체크포인트-제출물** 구조로 굴러가게 만들기
- 막히면 “왜”를 길게 설명하기보다, **상태 확인 → 다음 한 수**를 안내

---

### 추천 운영 방식(가장 안정적인 형태)

- **2인 1조**: Alice/Bob 역할 분리(각자 PC)
  - (강사 데모 옵션) 한 PC에서 폴더 2개로 Alice/Bob을 흉내낼 수도 있음
- 각 미션은 “완료 조건”이 명확해야 함(성공 판정)
- 막히면 리셋을 두려워하지 않기: **원격(GitHub) 기준으로 로컬 초기화 = 가장 빠른 회복**

---

### 시간표(권장, 25분 버전)

- 0:00~0:03 세팅(Setup) + 역할 분리 확인
- 0:03~0:11 미션1: Conflict
- 0:11~0:18 미션2: Push rejected
- 0:18~0:22 미션3: Stash
- 0:22~0:27 미션4: Recover(reflog)
- +@ 막힌 팀/심화(선택)

---

### 시작 멘트(30초)

- “오늘 실습은 **merge 중심**입니다. 정답은 ‘커맨드 암기’가 아니라  
  **막혔을 때 status/log로 상태를 읽는 것**이에요.”
- “도움이 필요하면 아래 3줄만 공유해주세요.”

```bash
git status
git log --oneline --graph --decorate -10
git remote -v
```

---

### 공통 체크포인트(강사가 주기적으로 확인)

- Alice/Bob 모두:
  - 지금 작업 폴더가 **올바른 Git repo** 인가?
  - `git remote -v`에서 원격이 **GitHub repo**를 가리키는가?
  - `git status`에서 “어떤 상태인지”를 말로 설명할 수 있나?
  - 지금 브랜치가 뭔지(`git branch --show-current`) 알고 있나?

---

### 미션 0) 세팅(Setup)

#### 참가자에게 안내할 문장

- “터미널 2개 열고, 한쪽은 Alice, 한쪽은 Bob으로만 씁니다.”
- “설치가 꼬였다고 느껴지면 **그냥 Setup을 다시** 실행하세요.”

#### 강사가 보여줄 것

- `docs/git-collab-lecture/07-github-setup.md`에서 **dev 브랜치 준비**
- `docs/git-collab-lecture/03-terminal-demo-scripts.md`에서 **clone 및 PR 생성 흐름**

#### 성공 판정

- Alice/Bob 모두 repo를 clone 했고, `git log --oneline -1`이 정상 출력됨
- `git branch -a`에 `origin/main`, `origin/dev`가 보임(강사가 dev 준비했다면)

---

### 미션 1) Merge Conflict

#### 참가자 안내(핵심)

- “Alice와 Bob이 **같은 줄**을 고치고, Bob이 Alice 브랜치를 merge 하면서 충돌을 해결합니다.”

#### 강사 체크 질문(막혔을 때)

- “지금 `git status`에 CONFLICT가 뜨나요? 어떤 파일이죠?”
- “파일에 `<<<<<<<`가 보이나요? 그 블록을 읽어볼까요?”

#### 성공 판정(제출물)

- `git log --oneline --graph --decorate -5` 캡처
- `lib/constants/string.dart` 최종 내용 캡처(어떤 선택을 했는지)

#### 자주 터지는 실수 & 빠른 처방

- 실수: 충돌 해결했는데 커밋이 안 됨 → `git add <file>`을 안 함
- 실수: 다른 폴더에서 작업함 → `pwd` 확인 후 올바른 폴더로 이동

---

### 미션 2) Push Rejected(Non-fast-forward)

#### 참가자 안내(핵심)

- “`main`은 보호되어 있을 수 있으니 **dev에서 실습**합니다.  
  Alice가 먼저 dev에 push해서 원격을 앞서게 만들고, Bob이 뒤쳐진 상태로 push해서 rejected를 만든 뒤  
  `git pull`로 해결합니다.”

#### 강사 체크 질문

- “rejected 메시지에 `non-fast-forward`가 보이나요?”
- “그럼 원격이 앞선 거예요. 지금 할 일은 `pull`입니다.”

#### 성공 판정(제출물)

- rejected 메시지 캡처 1장 + 해결 후 `git log --oneline --graph --decorate -5` 캡처

#### 자주 터지는 실수 & 처방

- 실수: Bob이 pull 전에 다른 브랜치에 있음 → `git checkout main`
- 실수: 머지 커밋 메시지 에디터(vi)가 떠서 멈춤
  - 안내: `:wq`로 저장 종료(또는 메시지를 입력하고 저장)
  - 대안(강사용): `git -c core.editor=true pull`(환경에 따라)

---

### 미션 3) Stash

#### 참가자 안내(핵심)

- “커밋하기 애매한 변경을 만들고 stash로 치운 다음, 브랜치를 바꿨다가 돌아와서 다시 적용합니다.”

#### 성공 판정(제출물)

- `git stash list` 출력 캡처
- `stash apply/pop` 후 `git status` 캡처

---

### 미션 4) Recover(reflog)

#### 참가자 안내(핵심)

- “일부러 커밋을 날린 것처럼 만든 다음, `reflog`로 커밋 해시를 찾아 복구합니다.”

#### 안전 장치(강사 멘트)

- “이건 **실습용 로컬 저장소**라서 가능한 거고, 실제 공유 브랜치에서는 reset/hard를 함부로 하면 안 됩니다.”

#### 성공 판정(제출물)

- `git reflog -10`에서 복구 대상 커밋이 보이는 캡처
- 복구 후 `git log --oneline -5` 캡처

---

### 실습이 망가졌을 때(가장 빠른 복구)

- “그냥 리셋하고 다시 할게요”를 정상 플로우로 만들어주기:

```bash
git fetch --all --prune
git checkout main
git reset --hard origin/main
git clean -fd
```
