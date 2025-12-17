## PPT 가이드 — “어떤 내용/이미지”를 넣으면 좋은가

### 톤/구성 원칙(권장)

- 슬라이드는 **원리 + 판단 기준**만 담고, 명령어는 라이브/실습 문서로 넘긴다.
- 그래프(커밋 다이어그램) 중심으로 “상태를 읽는 법”을 보여준다.
- 각 섹션 끝에 **체크리스트 1줄**로 기억을 고정한다.

---

### 1) 오프닝(1~2장)

- **슬라이드: 오늘의 목표**
  - 충돌 / push rejected / stash / 복구
  - “막히면 `status → log(graph) → remote`”
- **슬라이드: 협업 기본 흐름**
  - clone → branch → commit → push → PR → review → merge → pull

이미지/도식 추천:

- 한 줄짜리 파이프라인 도식(아이콘 없이 텍스트만으로도 충분)

---

### 2) Merge Conflict(2~3장)

- **슬라이드: 충돌이 나는 조건**
  - “같은 파일의 같은 부분을 동시에 수정”
- **슬라이드: 충돌 마커 읽는 법**
  - `<<<<<<<` / `=======` / `>>>>>>>` 의미
- **슬라이드: 해결 전략**
  - ours/theirs 선택
  - 둘 다 살려 재구성(가장 흔함)
  - 근본 예방: PR 작게 / 작업 구역 합의

이미지 추천:

- 실제 충돌 파일 스크린샷(마커가 잘 보이게)
- 간단한 커밋 그래프(두 브랜치가 갈라졌다가 merge로 합쳐지는 그림)
- (GitHub 실습용) PR 화면 스크린샷:
  - “This branch has conflicts…” 배너
  - (가능한 경우) “Resolve conflicts” 버튼

---

### 3) Push Rejected(Non-fast-forward)(2~3장)

- **슬라이드: rejected의 의미**
  - “원격이 더 앞서 있다”
- **슬라이드: 해결 루트(본 강의 기본)**
  - `git pull` 후 `git push`

이미지 추천:

- `origin/main`이 앞서 있는 커밋 그래프(내 로컬이 뒤쳐진 그림)
- (GitHub 실습용) 터미널 rejected 메시지 스크린샷( `non-fast-forward` 가 보이게 )

> 심화(옵션 슬라이드 1장): 팀이 선형 히스토리를 원할 때만 `pull --rebase`를 소개하고,  
> 본 강의(실습생 대상)에서는 기본 흐름을 merge로 고정하는 편이 안정적입니다.

---

### (추가 추천) GitHub 설정 화면 1장

- Branch protection 규칙(main)
  - “Require a pull request before merging”
  - “Require approvals”
  - (선택) force push 금지
    이미지 추천:
- GitHub repo Settings → Branches → Branch protection rules 화면 캡처

---

### 4) 브랜치 & Stash(2장)

- **슬라이드: 브랜치 최소 규칙**
  - 네이밍: `feature/`, `fix/`, `hotfix/`
  - PR은 작게, 자주 push
  - main 보호 + 리뷰
- **슬라이드: stash는 “서랍”**
  - 치우기 / untracked 포함 / stash에서 브랜치 만들기(3개만)

이미지 추천:

- stash stack을 표현한 간단한 그림(스택 2~3개)
- 브랜치 네이밍 예시 표(3~5줄)

---

### 5) 복구(restore/revert/reset/reflog)(2장)

- **슬라이드: 복구 치트시트 표**
  - 언제 쓰는지 / 공유 브랜치 안전 여부 / 위험도
- **슬라이드: reflog = 최후의 보험**
  - “커밋이 사라진 것처럼 보여도 흔적은 남는다”

이미지 추천:

- 치트시트 표(다음 문서 `05-cheatsheet.md` 표 재사용)
- reflog에서 커밋 해시를 찾는 예시 화면(텍스트 캡처로 충분)

---

### 6) 실습 안내(1장)

- 오늘 미션 체크리스트(4개)
- 막힐 때 제출할 것: `git status` / `git log --graph --oneline --decorate -10`
