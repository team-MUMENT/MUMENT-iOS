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


## 🤔 역할 분배
| 정정빈 | 김지민 | 김담인 |
| --- | --- | --- |
| 프로젝트 세팅 | 홈 탭 | 보관함 탭 |
| 기록하기 탭 | 🍎 | 🍎 |
| 🍎 | 🍎 | 🍎 |

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
