## GitHub 기반 실습 세팅 가이드(강사용)

### 목표

- 로컬 bare repo 대신 **GitHub 저장소**를 원격으로 사용해 실습한다.
- 실습생이 헷갈리지 않게 **main은 PR로만**, 직접 push는 **dev(연습용) 브랜치**에서만 허용한다.

---

### 1) 저장소 구성(권장)

- 저장소 1개: 예) `git_teamwork`(Flutter 프로젝트)
- 브랜치 2개 운영:
  - **`main`**: PR 머지만 허용(가능하면 보호 설정)
  - **`dev`**: push rejected 실습용으로 “직접 push 허용”

---

### 2) 권한/설정(권장)

#### Collaborators

- 실습생을 저장소 Collaborator(Write 이상)로 초대(조직/교육 환경에 따라 조정)

#### Branch protection(선택이지만 추천)

- `main` 보호 설정 추천:
  - “Require a pull request before merging”
  - “Require approvals”(가능하면 1)
  - (선택) “Require conversation resolution”
  - (선택) “Do not allow force pushes”

> 실습이 목적이면, 너무 빡빡한 규칙은 오히려 진행을 막습니다.  
> **핵심은 main 보호 + dev는 자유** 정도만 잡아도 충분합니다.

---

### 3) 강사용 “초기 커밋/브랜치” 준비 순서(터미널)

> 아래는 “강사가 한 번만” 준비하면 됩니다.  
> **이 Flutter 프로젝트(repo)** 를 그대로 쓰거나, 교육용으로 별도 repo를 만들어도 됩니다.

#### A안(추천): 이 Flutter 프로젝트를 “교육용 repo”로 그대로 사용

1. GitHub에 repo를 올려둔다(이미 있다면 스킵)
2. `dev` 브랜치만 준비한다(연습용)

```bash
git checkout main
git pull
git checkout -b dev
git push -u origin dev
```

#### B안(조직/교육 환경): 템플릿으로 새 repo를 파서 진행

- “Use this template” 또는 repo 복제 후, 위와 동일하게 `dev` 브랜치만 준비하면 됩니다.

---

### 4) 실습생 안내(가장 단순한 규칙)

- **main에는 push하지 않는다**(PR로만)
- “push rejected”는 **`dev`에서만** 실습한다(여긴 직접 push 허용)
