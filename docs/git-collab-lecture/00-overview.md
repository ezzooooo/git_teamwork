## Git 협업 특강 (2회차) 개요

### 목표

- **충돌(merge conflict)** 이 왜/언제 발생하는지 이해하고, 당황하지 않고 해결한다.
- **Push rejected (non-fast-forward)** 를 원인별로 구분하고, 팀 규칙에 맞는 방식으로 해결한다.
- **브랜치 운영 최소 규칙**(네이밍/PR/리뷰/보호 브랜치)을 합의 가능한 형태로 정리한다.
- 실수했을 때 **복구(restore/revert/reset/reflog)** 로 빠르게 되돌린다.

### 권장 대상/난이도

- Git을 “혼자”는 써봤는데, 팀 협업에서 충돌/거절이 자주 나는 분
- PR/리뷰/브랜치 규칙을 팀에서 아직 합의하지 못한 분

### 전체 구성(권장 타임박싱)

- **1부: 이론 + 라이브 코딩 + Q&A (45분)**
- **2부: 실습 시간 (20~30분 + @)**

### 사전 준비(참가자)

- 터미널 2개(또는 탭 2개) 준비: Alice/Bob 역할 분리
- 기본 명령 확인:
  - `git --version`
  - `git config --global user.name`
  - `git config --global user.email`

### 강사가 준비하면 좋은 것

- 충돌 마커(`<<<<<<<`, `=======`, `>>>>>>>`)가 보이는 예시 화면
- push rejected(Non-fast-forward) 상황 커밋 그래프 1장
- “복구 치트시트” 표 1장(restore/revert/reset/reflog)

### 오늘의 팀 협업 원칙(슬라이드 1장)

- **작업 시작 전**: `git status`가 깨끗한지 확인하고, 원격 최신화(`pull`) 후 시작
- **main(또는 develop) 직접 커밋 금지**: 브랜치에서 작업 → PR → 리뷰 → 머지
- **작게 자주**: 커밋/PR 크기를 줄이면 충돌과 리뷰 비용이 급감

### 팀 정책 결정 포인트(강의 중 합의 유도)

- **기본 정책(권장)**: 실습생 대상 강의에서는 **merge 방식(`git pull`)을 기본**으로 고정
- **머지 전략**: merge commit / squash / rebase merge 중 무엇을 기본으로 할지
- **브랜치 전략**: trunk-based(main 중심) vs develop 중심(Git Flow 변형) 중 현재 팀에 맞는 것

> 심화(옵션): 팀이 “히스토리 선형(깔끔함)”을 강하게 원하면 `pull --rebase`를 도입할 수 있으나,  
> 초반에는 **merge로 통일**하는 편이 학습/실습 난이도가 낮습니다.

### 참고 링크(마지막 슬라이드용)

- Git 소개(위키): https://ko.wikipedia.org/wiki/%EA%B9%83_(%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4)
- Pro Git(무료, 한국어): https://git-scm.com/book/ko/v2
- Pro Git 저장소: https://github.com/progit/progit2
- Learn Git Branching(실습형): https://learngitbranching.js.org/?locale=ko
- GUI 도구(선택): https://www.sourcetreeapp.com / https://www.gitkraken.com / https://github.com/apps/desktop?locale=ko-KR
