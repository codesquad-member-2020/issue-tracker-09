# issue-tracker-09
이슈 트래커 - 9팀

## 그라운드 룰

- 스크럼 시간 : 오전 11시 (유동적으로 조정)
- 스크럼 마스터 : 스크럼 HackMD 링크 공유 및 wiki 업로드
- 링크 : [9팀 그라운드룰](https://github.com/codesquad-member-2020/issue-tracker-09/wiki/%EC%8A%A4%ED%81%AC%EB%9F%BC) , [BE - 요구사항 기술서](https://docs.google.com/spreadsheets/d/1kR8xTf31N9dRLI5Jf-A0xH6b5_vAceIPOU2kl4YK0AY/edit?usp=sharing), [API 명세서](https://github.com/codesquad-member-2020/issue-tracker-09/wiki/API-명세서), [API 포맷](https://docs.google.com/spreadsheets/d/1wi9wreNqXpQay3zbV8c5xKfuwmqc34AqN-yhB3a_tmE/edit#gid=0)

<br />

### 커밋 메세지

| 타입     | 설명                                         |
| -------- | -------------------------------------------- |
| feat     | 새로운 기능 추가                             |
| fix      | 버그 수정                                    |
| docs     | 문서 수정                                    |
| refactor | 코드 리팩토링                                |
| style    | 코드 포맷팅 (코드 변경이 없는 경우)          |
| test     | 테스트 코드 작성                             |
| chore    | 소스 코드를 건들지 않는 작업 |

```
[#issue] Feat : API 개발
```
<br />

### Issue 관리

* [클래스명] Issue 제목

```
[BE] 배포
```
<br />

### Git branch rule

- deploy: 배포용 브랜치
- dev: 개발 브랜치
- 작업을 시작할 때: 자신의 클래스 개발 브랜치에서 feat/<클래스>-기능명 으로 브랜치 생성
    - ex) feat/iOS-...
- review를 위해 리뷰 브랜치를 생성한다.
    - ex) be-review
- 이슈 단위로 개발한다.
- 작업이 완료되었으면, 작업하던 브랜치에서 개발 브랜치(dev)로 Pull Request를 생성한다.
- 머지를 완료했으면 기능(feature)브랜치는 github과 local git에 모두 삭제한다.
- Pull request 시 상대방은 assignee에 할당하고, 할당받은 사람은 해당 pull request를 확인 후, merge 한다.
- dev 브랜치로 merge 될 때, PR 메시지로 해당하는 issue를 닫아준다.
  - 예시: Resolve #1, Closed #1..
- default branch는 dev으로 설정한다.

<br>

### 프로젝트 협업 요구사항

프로젝트 협업은 짝 프로그래밍만 하는 게 아니다. 서로 어떻게 협업할 것인가 상의한다.
같은 클래스끼리는 화면 단위 혹은 폴더, 기능 단위로 전혀 협업 포인트가 없이 분업하지 않는다.
같은 클래스 페어는 반드시 마일스톤 혹은 화면 단위로 협업하고 완성하고 난 이후 다음 단계(화면)를 진행한다.
더이상 나눌 수 없는 작은 작업 단위로 할 일(TASK)을 나누고, TASK 단위로 분업한다.
만약 할 일을 작게 나누기 어렵거나 우선순위, 의존성이 있는 작업은 짝 프로그래밍을 권장한다.
할 일(TASK)을 나누는 것은 매일 혹은 마일스톤 시작 시점마다 진행한다. 프로젝트 초반에 모든 할 일을 나누지 않아도 된다.
할 일 목록을 이슈로 등록하고 담당자가 관리한다.
