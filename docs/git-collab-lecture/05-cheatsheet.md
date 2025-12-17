## Git 협업 치트시트 (현업용)

### 0) 막히면 이 순서로 확인

```bash
git status
git log --oneline --graph --decorate -10
git remote -v
```

---

### 1) Merge Conflict 해결 루틴

#### 증상

- `git merge` / `git pull` 중에 “CONFLICT” 메시지

#### 해결 루틴

1. `git status`로 충돌 파일 확인
2. 파일 열고 `<<<<<<<` / `=======` / `>>>>>>>` 구간을 팀 의도대로 정리
3. `git add <file>`로 “해결 완료” 표시
4. `git commit`

---

### 2) Push Rejected(Non-fast-forward) 해결

#### 의미

- “원격에 내가 아직 못 받은 커밋이 있다”

#### 해결(본 강의 기본: merge)

```bash
git pull
git push
```

> 심화(옵션): 팀이 선형 히스토리를 원할 때만 `pull --rebase`를 도입합니다.

---

### 3) stash 3종(최소 세트)

```bash
git stash push -m "wip: message"   # 임시로 치우기
git stash push -u -m "wip: incl u" # untracked 포함
git stash branch feature/x stash@{0} # stash에서 브랜치 만들기
```

---

### 4) 복구 명령, 언제 쓰나 (중요 표)

| 상황                                      | 추천 명령                   | 공유 브랜치(main 등)에서 안전? | 비고                        |
| ----------------------------------------- | --------------------------- | ------------------------------ | --------------------------- |
| 파일만 되돌리고 싶다                      | `git restore <file>`        | O                              | 로컬 변경 되돌림            |
| 이미 올라간(공유된) 커밋을 되돌리고 싶다  | `git revert <commit>`       | O                              | “되돌리는 커밋”이 새로 생김 |
| 커밋을 없었던 일로 만들고 싶다(내 로컬)   | `git reset --soft HEAD~1`   | X(공유 금지)                   | 커밋만 취소, 스테이징 유지  |
| 작업 내용까지 버리고 완전히 되돌리고 싶다 | `git reset --hard <commit>` | X(공유 금지)                   | 매우 위험(히스토리 변경)    |
| 커밋이 사라진 것 같다                     | `git reflog`                | O(조회는)                      | “최후의 보험”               |

---

### 5) 팀 룰(추천 최소안)

- **main(또는 develop) 직접 커밋 금지**: 브랜치 → PR → 리뷰 → 머지
- **PR은 작게**(리뷰 가능 크기): 충돌도 줄고 품질도 올라감
- 작업 시작 전:

```bash
git status
git pull
```
