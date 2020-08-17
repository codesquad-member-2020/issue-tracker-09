# 구현 화면

## OAuth 로그인

![IssueTrackerOAuth](https://user-images.githubusercontent.com/48466830/90402059-dc7e2100-e0d9-11ea-888c-4c42030e51b8.gif)

## Label 생성

![IssueTrackerCreateLabel](https://user-images.githubusercontent.com/48466830/90402043-d720d680-e0d9-11ea-8d32-0cd965f5e1d4.gif)

## MileStone 편집

![IssueTrackerEditMileStone](https://user-images.githubusercontent.com/48466830/90402053-db4cf400-e0d9-11ea-8e24-706b507c9510.gif)

## 셀 삭제

![IssueTrackerDeleteItems](https://user-images.githubusercontent.com/48466830/90402052-dab45d80-e0d9-11ea-8420-6d12416ea399.gif)



# 트러블 슈팅



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

* 상속하지 않는 클래스는 final 명시
* 함수 내부 return 은 줄바꿈으로 구분해주기
* Internal property는 타입 명시
* 클래스, 구조체 첫줄 띄우기
* computed proprety는 return을 명시한다.
* PR생성은 번갈아가면서, 머지는 항상 작성하지 않는 사람이한다.

#### 페어 중 일어나는 모든 분쟁은 사다리로 해결한다.

Label -> 레이블이라고 읽고 명시한다.