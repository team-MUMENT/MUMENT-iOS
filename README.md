# 🎧 MUMENT
> 음악은 3분이면 끝나지만, 그 여운은 더 오래 가도록!

> 음악이 주는 여운을 놓치고 싶지 않은 당신을 위해,
음악 감상을 손쉽게 기록하고, 다시 꺼내 보고, 새롭게 발견하는 서비스, MUMENT입니다.

![Slice 1](https://user-images.githubusercontent.com/25932970/178215255-216c0fd6-64c6-41e8-8a77-5d576da9af88.png)


# 🛠 프로젝트 세팅
- 미니멈 타겟: iOS 15.0
- 대응 기기: iPhone 13 mini, iPhone SE 2, iPhone 13 pro

# 👨‍👧‍👧 Contributors

| <img src="https://user-images.githubusercontent.com/25932970/178222831-d502f771-9fe7-4226-ab30-17bf65fda284.png" width="500"> | <img src="https://user-images.githubusercontent.com/25932970/178222838-74be261e-c205-4b14-b510-16424581a3f2.png" width="500"> | <img src="https://user-images.githubusercontent.com/25932970/178222820-74521ed0-b683-4277-8335-a3cb08c9c915.png" width="500"> |
| :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: |
|                                         [dev-madilyn](https://github.com/dev-madilyn)                                         |                                          [jimin-kiim](https://github.com/jimin-kiim)                                          |                                         [daminoworld](https://github.com/daminoworld)                                         |


## 🤔 역할 분담
### 정정빈
- 프로젝트 초기 세팅
    - 라이브러리 추가 (SPM)
    - 폴더링, 각 Scene별 그룹 생성 및 TabBarController 적용하여 초기 세팅
- 기록하기 탭
    - 곡 선택 바텀시트
        - 최근 검색한 곡: UserDefault를 이용하여 struct → Data → struct 형태로 set/get
        - 곡 검색: SearchBar, TableView
    - 필터 선택: CollectionView flowlayout 이용하여 left alignment 구현
    - 글 작성: TextView 선택 시 ScrollView를 위로 끌어올려 작성 뷰가 가려지지 않도록 구현, 작성 중인 글자 수 RxCocoa 사용하여 구현
    - 완료 POST
- 홈 - 검색하기
    - 최근 검색한 곡:  UserDefault를 이용하여 struct → Data → struct 형태로 set/get
    - 곡 검색: SearchBar, TableView
    - 해당 곡 상세보기 페이지로 연결
- 플로우 연결 및 데이터 전달
    - 홈 - 뮤멘트 상세보기, 곡 상세보기
    - 곡 상세보기 - 뮤멘트 상세보기
- Empty View
    - 곡 상세보기
    - 보관함
- 토스트 메시지 구현: ViewController Extension으로 사용 가능하게 구현
- 커스텀 알럿창 구현
### 김지민
홈 뷰(테이블 뷰)

- 스티키 헤더(scrollViewDidScroll, scrollView.contentOffset을 이용해 스크롤에 따라 UI 변화 적용_스크롤 시 헤더의 윗 부분은 사라지고 아랫부분은 고정됨)
- 배너(컬렉션 뷰)
- 오늘의 뮤멘트(카드 컴포넌트화)
- 다시 들은 곡의 뮤멘트(컬렉션 뷰)
- 랜덤 태그별 뮤멘트(컬렉션 뷰)

곡 상세보기(테이블 뷰)

- 네비바(컴포넌트화_스크롤 시 네비바 가운데 부분에 곡 제목이 타이틀로 들어감.)
- 섹션 헤더(정렬 기준 선택 버튼 컴포넌트화) & 섹션 셀(카드 컴포넌트화)

뮤멘트 상세보기(스크롤 뷰)

- 네비바(컴포넌트화)
- 뮤멘트 카드(곡 정보, 태그부분은 컴포넌트화)
- 히스토리 뷰 이동 버튼

뮤멘트 히스토리 뷰(테이블 뷰)

- 섹션 헤더(곡 정보, 정렬 기준 선택 버튼 컴포넌트화)
    
    

컴포넌트화한 UI

- 여러 종류의 카드에 공통적으로 들어가는 태그
    - 기본적인 형태와 사용될 방식이 같기에 세 가지 태그를 하나의 클래스로 관리하되 메소드 활용에 따라 수정해 사용할 수 있도록 함.
- 카드
    - 기본적인 틀 안에서 앨범 이미지와 하트 버튼의 유무에 따라 종류가 나뉘어 기본 틀 클래스를 만든 뒤 이를 상속, 변형하여 사용함.
- 정렬 기준 선택 버튼
    - 클릭 시 다른 하나는 선택되지 않은 걸로 바뀌는 기능과 기본적인 UI가 동일하여 컴포넌트로 만들어 사용함.
- 네비바
    - 필요할 경우 상단 타이틀을 설정하는 기능과 뒤로 가기 버튼의 기능과 UI가 동일하여 컴포넌트화하여 사용함.
    

플로우 연결과 이를 위한 뷰 클릭 이벤트 처리

- protocol, delegate를 이용해 UIButton 혹은 그 외 View 터치 감지 시 뷰컨트롤러에서 화면 전환을 수행하도록 하였다.
- 터치 감지는 tapGestureRecognizer와 UIButton의 익스텐션 코드로 추가한 press를 이름으로 하는 함수를 이용해 처리하였다.

### 김담인

- **보관함 탭 상단 탭 화면 전환**
    - SegmentControl을 이용해 두개의 뷰 컨트롤러 전환
    - UIPageViewController로 스와이프를 이용한 뷰 컨트롤러 전환
- **각 탭내에서 리스트 뷰, 그리드 뷰 전환**
    - 각 상단 탭의 컬렉션 뷰 위에
    
    리스트 형태, 그리드 형태의 셀을 
    
    버튼을 통해 전환 시켜주기
    
- **바텀시트 필터**
    - 탭의 필터 버튼 클릭시
    
        필터를 선택할 수 있는 바텀시트를 띄워주기
    
    - 각 필터 태그를 컬렉션 버튼을 이용하여 정렬 및 다중 선택 기능 구현
        - 컬렉션 뷰를 왼쪽으로 정력 시켜주는 커스텀 flowLayout을 사용해 정렬시키고 스크롤을 disable하여 사용
    - 선택된 태그를 하단 바에 추가해 보여주기
        - 선택된 필터가 없을때는 하단바의 컨테이너 view 높이를 0으로 줬다가 선택이 되었을떄 동적으로 하단바에 필터가 추가 되도록 구현
    - 선택된 태그의 삭제 기능 및 UI 업데이트 구현
        - 하단 stackView에서 삭제시 컬렉션뷰에도 같은 필터 버튼이 적용되도록 로직 구현

# 👁‍🗨 Library

|                     라이브러리                      |                   용도                    |
| :-------------------------------------------------: | :---------------------------------------: |
|    [SnapKit](https://github.com/SnapKit/SnapKit)    |      코드 베이스 UI 작업 시간 최소화      |
|       [Then](https://github.com/devxoul/Then)       | 클로저를 통해 인스턴스에 대한 처리 간결화 |
| [Alamofire](https://github.com/Alamofire/Alamofire) |           네트워킹 작업 단순화            |
|   [RxSwift](https://github.com/ReactiveX/RxSwift)   |    RxCocoa를 이용해 비동기 처리 용이화    |



# 🖥 Code Convention
> [뮤멘트 아요의 전체 Code Convention을 보고 싶다면?!](https://www.notion.so/Code-Convention-f5b103a299114616b99d3c071f041d34)

- 함수 : `lowerCamelCase`, `동사 + 목적어` 형태
- 변수, 상수 : `lowerCamelCase`
- 클래스 : `UpperCamelCase`
- 약어 사용 범위

  `TableView -> TV`

  `TableViewCell -> TVC`

  `CollectionView -> CV`

  `CollectionViewCell -> CVC`

  `ViewController -> VC`

  `identifier -> id`

  
- 주석

    `\\`-> MARK, TODO 주석

    `\\\`-> 문서화 주석
- MARK 구문
    - 10줄 이상의 모든 파일에서는 MARK 구문을 사용합니다.
    - 해당하는 MARK 구문만 사용합니다.
    ```
    // MARK: - Protocols 웬만하면 파일로 빼자.

    // MARK: - Properties
    // MARK: - @IBOutlet Properties
    // MARK: - Initialization
    // MARK: - View Life Cycle
    // MARK: - UI
    // MARK: - Functions
    // MARK: - @IBAction Properties 

    // MARK: - Extension명
    // MARK: - Network
    ```


# 🌀 Git Flow
> [뮤멘트 아요의 Git Convention 전체 보기](https://www.notion.so/Git-Convention-6117195b56d5464eb4ecd25fec0f3ac1)

<details>
<summary>뮤멘트 아요의 전체 Git Flow가 궁금하다면?!</summary>
<div markdown="1">
 
![뮤멘트 아요의 전체 Git Flow가 궁금하다면?!](https://user-images.githubusercontent.com/25932970/178236698-e033bb5b-266b-4360-983f-0c6b7818d91b.png)
 </details>
 
## 작업 순서
```
1. Issue 생성
2. Branch 생성
3. 작업, commit
4. push
5. PR 작성
6. 코드 리뷰 (24시간 이내)
7. 두 명(권장), 한 명(최소) Approve 받았을 경우 셀프 merge
8. Delete Branch
```
## Commit Convention
`타입: 설명 #이슈 번호`

```
  Feat: 새로운 주요 기능 추가
  Add: 파일 추가, 에셋 추가
  Fix: 버그 수정
  Del: 쓸모없는 코드 삭제
  Refactor: 코드 리팩토링
  Mod: 스토리보드, Xib 파일 수정
  Move: 프로젝트 구조 변경
  Rename: 파일, 클래스, 변수명 등 이름 변경
  Docs: Wiki, README 파일 수정
  Chore: 그 외
```
## Branch

- 가장 처음에 붙는 분류 영역에서는, 커밋 컨벤션의 워딩과 동일하게 작성합니다.

### Branch Naming

> `분류` /`#이슈 번호` - `작업할 뷰` - `상세 작업 내역`
> 

```swift
chore/#3-Project-Setting
feat/#3-HomeView-UI
fix/
refactor/#1-

```


## Merge

- 본인의 `PR`은 본인이 `Merge`합니다.
- 최대한 빨리, 최대 24시간 이내에 코드 리뷰를 등록합니다.
- 최신화를 자주 하자!
- Approve를 최소 1명한테 받아야 Merge가 가능합니다.
    - 2명이 최대한 Approve 줄 수 있도록 합시다!
- 코드 리뷰를 하면서 필수적인 수정 사항을 발견할 경우, `Approve` 대신 `Request Changes`를 주어 수정을 요구합니다.
    - 해당 `PR` 작업자는, 수정 사항을 반영하여 새로 `commit`을 추가한 후, 해당 `PR`에 `push`하여 `Re-request review`를 요청합니다.
        1. `Request Changes`: 컨벤션 
        2. `Approve`: 일단 OK! 로직, 리팩토링 가능한 부분, 더 나은 코드를 위한 제안 등
- 모든 작업이 완료되어 `Merge`가 된 경우, 해당 `PR` 하단의 `Delete Branch`를 선택하여 작업이 끝난 `Branch`를 삭제합니다.
 
# 📁 Foldering Convention
```
.
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Global
│   ├── Base
│   │   ├── BaseNVC.swift
│   │   └── BaseVC.swift
│   └── Extensions
│       ├── UIViewController+.swift
│       └── 기타 Extension 파일.swift
├── Info.plist
├── Network
│   ├── APIEssentials
│   │   ├── APIConstants.swift
│   │   ├── GenericResponse.swift
│   │   └── NetworkConstants.swift
│   ├── APIManagers
│   │   └── BaseAPI.swift
│   ├── Bases
│   │   ├── NetworkResult.swift
│   │   └── TargetType.swift
│   ├── EventLogger.swift
│   └── Services
├── Resources
│   ├── Assets.xcassets
│   ├── Colorsets.xcassets
│   └── Fonts
│       └── NotoSans-SemiBold.ttf
└── Sources
    ├── Components
    │   └── DefaultNavigationView.swift
    ├── MumentTabBarController.swift
    └── Scenes
        ├── Home
        │   ├── HomeVC.swift
        │   └─── Model
        │       └── CarouselModel.swift
        ├── Storage
        └── Write
```
