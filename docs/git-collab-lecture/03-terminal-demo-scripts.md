## 터미널 데모/실습 커맨드 모음 (bash)

> 이 문서는 **복붙용**입니다. macOS 기준으로 작성했고, 모든 예시는 **bash**에서 실행합니다.

### 실습 운영 팁(중요)

- 실습이 꼬이면 가장 빠른 해결은 **환경 리셋(Setup 재실행)** 입니다.
- 도움 요청 시 아래 3개만 공유하면 디버깅이 빠릅니다:

```bash
git status
git log --oneline --graph --decorate -10
git remote -v
```

---

### 0) GitHub 원격으로 실습 환경 만들기(권장)

> 강사용 GitHub 세팅은 `docs/git-collab-lecture/07-github-setup.md`를 참고하세요.  
> 실습에서는 `<REPO_URL>`만 참가자에게 공유하면 됩니다.

#### (선택) 한 컴퓨터에서 Alice/Bob 2명 상황을 재현하고 싶을 때

> 강사용 라이브 데모에 유용합니다(디렉토리 2개로 “두 사용자”를 흉내).

```bash
rm -rf /tmp/git-collab-demo
mkdir -p /tmp/git-collab-demo && cd /tmp/git-collab-demo

git clone <REPO_URL> alice
git clone <REPO_URL> bob

cd /tmp/git-collab-demo/alice
git config user.name "Alice"
git config user.email "alice@example.com"

cd /tmp/git-collab-demo/bob
git config user.name "Bob"
git config user.email "bob@example.com"
```

#### (리셋) 로컬이 꼬였을 때 가장 빠른 복구

> “원격(GitHub)이 기준”이므로, 로컬은 언제든 원격 상태로 되돌리면 됩니다.

```bash
git fetch --all --prune
git checkout main
git reset --hard origin/main
git clean -fd
```

---

### 1) Merge Conflict 만들기 & 해결(GitHub PR로 보여주기)

> 핵심은 “두 개의 PR이 **같은 줄**을 바꾸면, 하나를 먼저 머지했을 때 다른 하나가 충돌난다”를 보여주는 겁니다.

#### Alice 터미널

```bash
cd /tmp/git-collab-demo/alice
git checkout main
git pull
git checkout -b feature/alice-conflict

# IDE에서 수정(충돌 유발: 같은 줄을 바꾸기)
# - 파일: lib/constants/string.dart
# - 변경: AppString.appName 값을 "Hyeonseo's Tasks (Alice)" 같이 바꿔보기

git add lib/constants/string.dart
git commit -m "feat: alice edits appName"
git push -u origin feature/alice-conflict
```

#### Bob 터미널

```bash
cd /tmp/git-collab-demo/bob
git checkout main
git pull
git checkout -b feature/bob-conflict

# IDE에서 수정(충돌 유발: 같은 줄을 바꾸기)
# - 파일: lib/constants/string.dart
# - 변경: AppString.appName 값을 "Hyeonseo's Tasks (Bob)" 같이 바꿔보기

git add lib/constants/string.dart
git commit -m "feat: bob edits appName"
git push -u origin feature/bob-conflict
```

#### GitHub에서 PR 2개 만들기(웹에서)

- PR #1: `feature/alice-conflict` → `main`
- PR #2: `feature/bob-conflict` → `main`

#### 충돌 발생/해결 흐름(추천 데모)

1. PR #1(Alice)을 먼저 merge
2. PR #2(Bob)에서 “This branch has conflicts…”가 뜨는 것을 보여주기
3. 해결은 두 가지 중 택1:
   - **GitHub UI로 해결**: “Resolve conflicts” 버튼(가능한 경우)
   - **로컬에서 해결 후 push**(가장 확실)

#### 로컬에서 충돌 해결(추천)

```bash
cd /tmp/git-collab-demo/bob
git fetch origin
git checkout feature/bob-conflict
git merge origin/main
git status

# lib/constants/string.dart를 열어서 마커(<<<<<<) 해결 후
git add lib/constants/string.dart
git commit -m "merge: resolve conflict with main"
git push
```

---

### 2) Push Rejected(Non-fast-forward) 만들기 & 해결

> GitHub에서는 보통 main이 보호되어 있어서, “push rejected” 실습은 **`dev`(연습용)** 에서 하는 게 가장 깔끔합니다.

#### 사전: `dev` 브랜치가 원격에 존재해야 함(강사가 1회 준비)

- `docs/git-collab-lecture/07-github-setup.md` 참고

#### Alice가 `dev`에 먼저 push해서 원격을 앞서게 만들기

```bash
cd /tmp/git-collab-demo/alice
git checkout dev
git pull

# IDE에서 수정(커밋 A)
# - 파일: lib/main.dart
# - 변경 예: tooltip 문자열을 'Increment (Alice)'로 바꾸기

git add lib/main.dart
git commit -m "chore: alice updates dev"
git push
```

#### Bob이 뒤쳐진 상태에서 push → rejected 만들기

> 포인트: **Bob은 Alice의 push 이후에 pull을 다시 하지 않은 상태**여야 rejected가 납니다.

##### Bob 준비(먼저 실행)

```bash
cd /tmp/git-collab-demo/bob
git checkout dev
git pull
```

##### Alice가 위의 커밋 A를 push 한 뒤, Bob이 커밋 B 만들고 push 시도(여기서 rejected)

```bash
cd /tmp/git-collab-demo/bob

# IDE에서 수정(커밋 B)
# - 파일: lib/main.dart
# - 변경 예: 'Flutter Demo Home Page' 타이틀을 'Flutter Demo Home Page (Bob)'로 바꾸기

git add lib/main.dart
git commit -m "chore: bob updates dev"

git push  # rejected가 정상
```

#### 해결(본 강의 기본: merge)

```bash
git pull
git push
```

> 심화(옵션): 팀에서 선형 히스토리를 원할 때 `pull --rebase`를 도입할 수 있으나, 본 실습에서는 다루지 않습니다.

---

### 3) Stash 3종(치우기 / untracked 포함 / stash에서 브랜치 만들기)

```bash
cd /tmp/git-collab-demo/bob
git checkout -b feature/stash-demo

# IDE에서 WIP 변경 만들기(커밋하지 말기)
# - 파일: lib/main.dart
# - 예: Text('aa')를 Text('wip')로 바꾸기
#
# untracked 파일도 하나 만들기(IDE에서 새 파일 생성 추천)
# - 예: notes.md

git status
git stash push -u -m "wip: stash demo (include untracked)"
git status

git stash list
git stash show -p stash@{0}

# stash에서 브랜치 만들기(강력 추천 데모)
git stash branch feature/from-stash stash@{0}
git status
```

---

### 4) 복구(restore/revert/reset/reflog)

```bash
cd /tmp/git-collab-demo/alice
git checkout main
git pull

# (1) 파일 복구: restore
# IDE에서 실수 변경 만들기(커밋하지 말기)
# - 파일: lib/constants/string.dart
# - 예: appName을 'BROKEN'으로 바꾸기
git status
git restore lib/constants/string.dart
git status

# (2) 공유 브랜치에서 안전한 되돌리기: revert
# IDE에서 변경 후 커밋(나쁜 커밋 만들기)
# - 파일: lib/constants/string.dart
# - 예: appName을 'bad change'로 변경
git add lib/constants/string.dart
git commit -m "feat: bad change"
git log --oneline -5
git revert HEAD

# (3) 로컬에서만 되돌리기: reset --soft
# IDE에서 변경 후 임시 커밋 만들기
# - 파일: lib/main.dart
git add lib/main.dart
git commit -m "tmp: will reset"
git reset --soft HEAD~1

# (4) reflog로 부활(최후의 보험)
git commit -m "tmp: recommit"
git reset --hard HEAD~1
git reflog -10
# 예: git reset --hard <찾은해시>
```

---

### (검증) 내가 성공했는지 빠르게 확인하는 커맨드

```bash
git status
git log --oneline --graph --decorate -10
```
