## 2부 실습 (20~30분 + @)

### 실습 목표(완료 체크리스트)

- [ ] **Merge conflict**를 의도적으로 만들고, 직접 해결해서 **merge 커밋까지** 완료
- [ ] **Push rejected (non-fast-forward)** 를 의도적으로 만들고, **merge 방식(`git pull`)**으로 해결
- [ ] **stash**로 작업을 임시 보관하고, 브랜치를 전환/복구까지 수행
- [ ] 실수로 커밋을 “날린 것처럼” 만든 뒤, **reflog**로 복구

---

### 실습 운영 방식(추천)

- 2인 1조(또는 3인 1조): **Alice/Bob 역할**로 분리해서 진행
- 강사 진행 팁:
  - 중간중간 “지금 `git status` 결과만 채팅에 올려주세요”라고 요청하면 디버깅이 빨라짐
  - 막히는 팀은 **원인 파악 순서**만 잡아줘도 대부분 해결됨
    1. `git status` 2) `git log --oneline --graph --decorate -10` 3) `git remote -v`

#### 도움 요청 템플릿(실습생에게 안내)

아래 3개를 복붙해서 보내주세요(가능하면 “무슨 의도로 뭘 하다가 막혔는지” 한 줄 추가):

```bash
git status
git log --oneline --graph --decorate -10
git remote -v
```

#### 실습이 꼬였을 때(리셋)

가장 빠른 해결은 **원격(GitHub) 기준으로 로컬을 초기화**하는 겁니다(마지막 수단):

```bash
git fetch --all --prune
git checkout main
git reset --hard origin/main
git clean -fd
```

---

### 실습 0) 환경 세팅 (3~5분)

- 터미널 2개 준비(탭 2개)
- 아래 문서의 Setup 실행:
  - `docs/git-collab-lecture/03-terminal-demo-scripts.md`

---

### 실습 1) Merge Conflict 해결 (7~10분)

#### 미션

- Alice/Bob가 같은 파일의 같은 줄을 수정해 충돌을 만든다.
- 충돌 파일을 열어 마커를 해석하고, 최종 결과를 “팀 합의”대로 만든다.
- 해결 후 `git add` → `git commit`까지 완료한다.

#### 권장 충돌 포인트(Flutter 코드)

- 파일: `lib/constants/string.dart`
- 라인: `AppString.appName`

#### 힌트(정답 아님)

- 충돌 났을 때 할 일:
  - `git status`로 충돌 파일 확인
  - 파일을 열어 `<<<<<<<` / `=======` / `>>>>>>>` 부분을 직접 정리
  - `git add <file>`로 “해결 완료” 표시

#### 성공 판정(스스로 확인)

```bash
git status
git log --oneline --graph --decorate -5
```

---

### 실습 2) Push Rejected 해결 (7~10분)

#### 미션

- (권장) `main`은 보호되어 있을 수 있으니, **`dev` 브랜치에서 실습**한다.
- Alice가 먼저 원격(dev)을 앞서게 만든다.
- Bob은 뒤쳐진 상태에서 push 해서 rejected를 만든다.
- 아래 방식으로 해결한다:
  - `git pull` → `git push`

#### 힌트

- rejected는 “내가 틀림”이 아니라 “원격이 더 앞섬”이다.
- 해결은 “원격을 먼저 가져오고 → 내 커밋을 그 위에 올리고 → push”

> 심화(옵션): 다음 단계에서 `pull --rebase`를 소개할 수 있으나, 본 실습에서는 다루지 않습니다.

#### 성공 판정(스스로 확인)

```bash
git status
git log --oneline --graph --decorate -5
```

---

### 실습 3) Stash 활용 (5~7분)

#### 미션

- 커밋하기 애매한 변경사항(WIP)을 만든다.
- `stash`로 치우고 브랜치를 전환한다.
- 다시 돌아와 stash를 적용한다.
- 가능하면 `stash branch`까지 해본다.

---

### 실습 4) 복구(restore/revert/reset/reflog) (5~10분)

#### 미션

- 파일 실수 수정 후 `restore`로 되돌린다.
- 잘못된 커밋을 만든 뒤 `revert`로 “공유 브랜치에 안전한” 되돌리기를 해본다.
- `reset --hard`로 커밋을 날린 것처럼 만든 뒤, `reflog`로 커밋을 찾아 복구한다.

#### 주의(강조)

- **공유 브랜치(main 등)** 에서는 `reset --hard`로 히스토리를 바꾸는 행동을 금지(원칙)
- 공유 브랜치에서 되돌릴 때는 보통 `revert`가 안전하다.

---

### 실습 마무리(1분)

- 오늘 배운 “사고 대응 루틴” 한 줄 정리:
  - “막히면 **`status → log(graph) → remote`** 순서로 확인한다”
