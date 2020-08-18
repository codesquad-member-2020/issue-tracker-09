# 구현 화면

### OAuth 로그인

![IssueTrackerOAuth](https://user-images.githubusercontent.com/48466830/90402059-dc7e2100-e0d9-11ea-888c-4c42030e51b8.gif)

### Label 생성

![IssueTrackerCreateLabel](https://user-images.githubusercontent.com/48466830/90402043-d720d680-e0d9-11ea-8d32-0cd965f5e1d4.gif)

### MileStone 편집

![IssueTrackerEditMileStone](https://user-images.githubusercontent.com/48466830/90402053-db4cf400-e0d9-11ea-8e24-706b507c9510.gif)

### 셀 삭제

![IssueTrackerDeleteItems](https://user-images.githubusercontent.com/48466830/90402052-dab45d80-e0d9-11ea-8420-6d12416ea399.gif)



# 트러블 슈팅

- 메모리 이슈

  <img width="260" alt="Screen Shot 2020-08-18 at 18 59 50" src="https://user-images.githubusercontent.com/48466830/90526592-8bd6f880-e1ab-11ea-946d-f01486909048.png">

  Debug Memory Graph를 확인한 결과, 메모리 관련 이슈가 발생했었습니다 해당 이슈를 해결하기 위해서 Set<AnyCancellable>이 언제 해제 되는지 확인하던 중, 클로저에서 self를 강하게 참조하고 있는 코드를 확인했었습니다. 모든 참조를 weak self로 변경하면서 해당 이슈를 해결했습니다.

- IntrinsicContentSize

  <img width="208" alt="Screen Shot 2020-08-18 at 23 11 52" src="https://user-images.githubusercontent.com/48466830/90526624-96918d80-e1ab-11ea-8d82-afb31df5f87e.png">

  Debug View Hierarchy를 확인한 결과, 오토레이아웃을 잘못 설정해서 문제가 발생했었습니다.

  해당 뷰들이 세로 영역에서 동일한 우선순위를 갖고 있어서 발생한 문제였기 때문에 우선순위 값을 변경하면서 해결했습니다.

- 레이블 크기가 같지 않던 문제

  <img width="564" alt="Screen Shot 2020-08-18 at 19 29 34" src="https://user-images.githubusercontent.com/48466830/90526635-98f3e780-e1ab-11ea-98d7-9344fa89e95e.png">

  마지막 뷰의 경우에 위에 뷰와 다른 시점에서 생성되기 때문에 같은 제약사항을 부여해도, 크기가 다르게 설정되었습니다. 프레임값을 가져와서 사용하려고 했지만 올바른 접근이 아니었고, intrinsicContentSize를 사용해서 해결했습니다.

- UITableView Animation

  처음에는 테이블 뷰와 모델을 바인딩할 때, reloadData()를 사용해서 구현했습니다. 모델이 갱신되면 테이블 뷰에 애니메이션이 없이 그냥 갱신만 됐습니다.

  추후 WWDC 영상을 보면서 UITableViewDiffableDataSource에 대해 공부를 하고, 테이블 뷰에 적용했습니다.

# iOS 협업 규칙

#### MARK 순서

0. IBInspectable
1. IBOutlet
2. Properties
3. Lifecycle
4. IBAction
5. Methods
6. Objc

#### 프로퍼티 선언 순서

1. Computed Property
2. Stored Property

#### 접근 제어자 별 선언 순서

1. static
2. private
3. public

#### 기타

* 스토리보드와 코드를 중심적으로 사용한다.
* 스토리보드를 적극적으로 사용하며, 재사용성 또는 스토리보드로 작성할 수 없을 경우 코드로 작성한다

* 상속하지 않는 클래스는 final 명시
* 함수 내부 return 은 줄바꿈으로 구분해주기
* Internal property는 타입 명시
* 클래스, 구조체 첫줄 띄우기
* computed proprety는 return을 명시한다.
* PR생성은 번갈아가면서, 머지는 항상 작성하지 않는 사람이한다.

#### 페어 중 일어나는 모든 분쟁은 사다리로 해결한다.

Label -> 레이블이라고 읽고 명시한다.