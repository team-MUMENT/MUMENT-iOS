# ๐ง MUMENT
> ์์์ 3๋ถ์ด๋ฉด ๋๋์ง๋ง, ๊ทธ ์ฌ์ด์ ๋ ์ค๋ ๊ฐ๋๋ก!

> ์์์ด ์ฃผ๋ ์ฌ์ด์ ๋์น๊ณ  ์ถ์ง ์์ ๋น์ ์ ์ํด,
์์ ๊ฐ์์ ์์ฝ๊ฒ ๊ธฐ๋กํ๊ณ , ๋ค์ ๊บผ๋ด ๋ณด๊ณ , ์๋กญ๊ฒ ๋ฐ๊ฒฌํ๋ ์๋น์ค, MUMENT์๋๋ค.

![Slice 1](https://user-images.githubusercontent.com/25932970/178215255-216c0fd6-64c6-41e8-8a77-5d576da9af88.png)


# ๐  ํ๋ก์ ํธ ์ธํ
- ๋ฏธ๋๋ฉ ํ๊ฒ: iOS 15.0
- ๋์ ๊ธฐ๊ธฐ: iPhone 13 mini, iPhone SE 2, iPhone 13 pro

# ๐จโ๐งโ๐ง Contributors

| <img src="https://user-images.githubusercontent.com/25932970/178222831-d502f771-9fe7-4226-ab30-17bf65fda284.png" width="500"> | <img src="https://user-images.githubusercontent.com/25932970/178222838-74be261e-c205-4b14-b510-16424581a3f2.png" width="500"> | <img src="https://user-images.githubusercontent.com/25932970/178222820-74521ed0-b683-4277-8335-a3cb08c9c915.png" width="500"> |
| :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: |
|                                         [dev-madilyn](https://github.com/dev-madilyn)                                         |                                          [jimin-kiim](https://github.com/jimin-kiim)                                          |                                         [daminoworld](https://github.com/daminoworld)                                         |


## ๐ค ์ญํ  ๋ถ๋ด
### ์ ์ ๋น
- ํ๋ก์ ํธ ์ด๊ธฐ ์ธํ
    - ๋ผ์ด๋ธ๋ฌ๋ฆฌ ์ถ๊ฐ (SPM)
    - ํด๋๋ง, ๊ฐ Scene๋ณ ๊ทธ๋ฃน ์์ฑ ๋ฐ TabBarController ์ ์ฉํ์ฌ ์ด๊ธฐ ์ธํ
- ๊ธฐ๋กํ๊ธฐ ํญ
    - ๊ณก ์ ํ ๋ฐํ์ํธ
        - ์ต๊ทผ ๊ฒ์ํ ๊ณก: UserDefault๋ฅผ ์ด์ฉํ์ฌ struct โ Data โ struct ํํ๋ก set/get
        - ๊ณก ๊ฒ์: SearchBar, TableView
    - ํํฐ ์ ํ: CollectionView flowlayout ์ด์ฉํ์ฌ left alignment ๊ตฌํ
    - ๊ธ ์์ฑ: TextView ์ ํ ์ ScrollView๋ฅผ ์๋ก ๋์ด์ฌ๋ ค ์์ฑ ๋ทฐ๊ฐ ๊ฐ๋ ค์ง์ง ์๋๋ก ๊ตฌํ, ์์ฑ ์ค์ธ ๊ธ์ ์ RxCocoa ์ฌ์ฉํ์ฌ ๊ตฌํ
    - ์๋ฃ POST
- ํ - ๊ฒ์ํ๊ธฐ
    - ์ต๊ทผ ๊ฒ์ํ ๊ณก:  UserDefault๋ฅผ ์ด์ฉํ์ฌ struct โ Data โ struct ํํ๋ก set/get
    - ๊ณก ๊ฒ์: SearchBar, TableView
    - ํด๋น ๊ณก ์์ธ๋ณด๊ธฐ ํ์ด์ง๋ก ์ฐ๊ฒฐ
- ํ๋ก์ฐ ์ฐ๊ฒฐ ๋ฐ ๋ฐ์ดํฐ ์ ๋ฌ
    - ํ - ๋ฎค๋ฉํธ ์์ธ๋ณด๊ธฐ, ๊ณก ์์ธ๋ณด๊ธฐ
    - ๊ณก ์์ธ๋ณด๊ธฐ - ๋ฎค๋ฉํธ ์์ธ๋ณด๊ธฐ
- Empty View
    - ๊ณก ์์ธ๋ณด๊ธฐ
    - ๋ณด๊ดํจ
- ํ ์คํธ ๋ฉ์์ง ๊ตฌํ: ViewController Extension์ผ๋ก ์ฌ์ฉ ๊ฐ๋ฅํ๊ฒ ๊ตฌํ
- ์ปค์คํ ์๋ฟ์ฐฝ ๊ตฌํ
### ๊น์ง๋ฏผ
ํ ๋ทฐ(ํ์ด๋ธ ๋ทฐ)

- ์คํฐํค ํค๋(scrollViewDidScroll, scrollView.contentOffset์ ์ด์ฉํด ์คํฌ๋กค์ ๋ฐ๋ผ UI ๋ณํ ์ ์ฉ_์คํฌ๋กค ์ ํค๋์ ์ ๋ถ๋ถ์ ์ฌ๋ผ์ง๊ณ  ์๋ซ๋ถ๋ถ์ ๊ณ ์ ๋จ)
- ๋ฐฐ๋(์ปฌ๋ ์ ๋ทฐ)
- ์ค๋์ ๋ฎค๋ฉํธ(์นด๋ ์ปดํฌ๋ํธํ)
- ๋ค์ ๋ค์ ๊ณก์ ๋ฎค๋ฉํธ(์ปฌ๋ ์ ๋ทฐ)
- ๋๋ค ํ๊ทธ๋ณ ๋ฎค๋ฉํธ(์ปฌ๋ ์ ๋ทฐ)

๊ณก ์์ธ๋ณด๊ธฐ(ํ์ด๋ธ ๋ทฐ)

- ๋ค๋น๋ฐ(์ปดํฌ๋ํธํ_์คํฌ๋กค ์ ๋ค๋น๋ฐ ๊ฐ์ด๋ฐ ๋ถ๋ถ์ ๊ณก ์ ๋ชฉ์ด ํ์ดํ๋ก ๋ค์ด๊ฐ.)
- ์น์ ํค๋(์ ๋ ฌ ๊ธฐ์ค ์ ํ ๋ฒํผ ์ปดํฌ๋ํธํ) & ์น์ ์(์นด๋ ์ปดํฌ๋ํธํ)

๋ฎค๋ฉํธ ์์ธ๋ณด๊ธฐ(์คํฌ๋กค ๋ทฐ)

- ๋ค๋น๋ฐ(์ปดํฌ๋ํธํ)
- ๋ฎค๋ฉํธ ์นด๋(๊ณก ์ ๋ณด, ํ๊ทธ๋ถ๋ถ์ ์ปดํฌ๋ํธํ)
- ํ์คํ ๋ฆฌ ๋ทฐ ์ด๋ ๋ฒํผ

๋ฎค๋ฉํธ ํ์คํ ๋ฆฌ ๋ทฐ(ํ์ด๋ธ ๋ทฐ)

- ์น์ ํค๋(๊ณก ์ ๋ณด, ์ ๋ ฌ ๊ธฐ์ค ์ ํ ๋ฒํผ ์ปดํฌ๋ํธํ)
    
    

์ปดํฌ๋ํธํํ UI

- ์ฌ๋ฌ ์ข๋ฅ์ ์นด๋์ ๊ณตํต์ ์ผ๋ก ๋ค์ด๊ฐ๋ ํ๊ทธ
    - ๊ธฐ๋ณธ์ ์ธ ํํ์ ์ฌ์ฉ๋  ๋ฐฉ์์ด ๊ฐ๊ธฐ์ ์ธ ๊ฐ์ง ํ๊ทธ๋ฅผ ํ๋์ ํด๋์ค๋ก ๊ด๋ฆฌํ๋ ๋ฉ์๋ ํ์ฉ์ ๋ฐ๋ผ ์์ ํด ์ฌ์ฉํ  ์ ์๋๋ก ํจ.
- ์นด๋
    - ๊ธฐ๋ณธ์ ์ธ ํ ์์์ ์จ๋ฒ ์ด๋ฏธ์ง์ ํํธ ๋ฒํผ์ ์ ๋ฌด์ ๋ฐ๋ผ ์ข๋ฅ๊ฐ ๋๋์ด ๊ธฐ๋ณธ ํ ํด๋์ค๋ฅผ ๋ง๋  ๋ค ์ด๋ฅผ ์์, ๋ณํํ์ฌ ์ฌ์ฉํจ.
- ์ ๋ ฌ ๊ธฐ์ค ์ ํ ๋ฒํผ
    - ํด๋ฆญ ์ ๋ค๋ฅธ ํ๋๋ ์ ํ๋์ง ์์ ๊ฑธ๋ก ๋ฐ๋๋ ๊ธฐ๋ฅ๊ณผ ๊ธฐ๋ณธ์ ์ธ UI๊ฐ ๋์ผํ์ฌ ์ปดํฌ๋ํธ๋ก ๋ง๋ค์ด ์ฌ์ฉํจ.
- ๋ค๋น๋ฐ
    - ํ์ํ  ๊ฒฝ์ฐ ์๋จ ํ์ดํ์ ์ค์ ํ๋ ๊ธฐ๋ฅ๊ณผ ๋ค๋ก ๊ฐ๊ธฐ ๋ฒํผ์ ๊ธฐ๋ฅ๊ณผ UI๊ฐ ๋์ผํ์ฌ ์ปดํฌ๋ํธํํ์ฌ ์ฌ์ฉํจ.
    

ํ๋ก์ฐ ์ฐ๊ฒฐ๊ณผ ์ด๋ฅผ ์ํ ๋ทฐ ํด๋ฆญ ์ด๋ฒคํธ ์ฒ๋ฆฌ

- protocol, delegate๋ฅผ ์ด์ฉํด UIButton ํน์ ๊ทธ ์ธ View ํฐ์น ๊ฐ์ง ์ ๋ทฐ์ปจํธ๋กค๋ฌ์์ ํ๋ฉด ์ ํ์ ์ํํ๋๋ก ํ์๋ค.
- ํฐ์น ๊ฐ์ง๋ tapGestureRecognizer์ UIButton์ ์ต์คํ์ ์ฝ๋๋ก ์ถ๊ฐํ press๋ฅผ ์ด๋ฆ์ผ๋ก ํ๋ ํจ์๋ฅผ ์ด์ฉํด ์ฒ๋ฆฌํ์๋ค.

### ๊น๋ด์ธ

- **๋ณด๊ดํจ ํญ ์๋จ ํญ ํ๋ฉด ์ ํ**
    - SegmentControl์ ์ด์ฉํด ๋๊ฐ์ ๋ทฐ ์ปจํธ๋กค๋ฌ ์ ํ
    - UIPageViewController๋ก ์ค์์ดํ๋ฅผ ์ด์ฉํ ๋ทฐ ์ปจํธ๋กค๋ฌ ์ ํ
- **๊ฐ ํญ๋ด์์ ๋ฆฌ์คํธ ๋ทฐ, ๊ทธ๋ฆฌ๋ ๋ทฐ ์ ํ**
    - ๊ฐ ์๋จ ํญ์ ์ปฌ๋ ์ ๋ทฐ ์์
    
    ๋ฆฌ์คํธ ํํ, ๊ทธ๋ฆฌ๋ ํํ์ ์์ 
    
    ๋ฒํผ์ ํตํด ์ ํ ์์ผ์ฃผ๊ธฐ
    
- **๋ฐํ์ํธ ํํฐ**
    - ํญ์ ํํฐ ๋ฒํผ ํด๋ฆญ์
    
        ํํฐ๋ฅผ ์ ํํ  ์ ์๋ ๋ฐํ์ํธ๋ฅผ ๋์์ฃผ๊ธฐ
    
    - ๊ฐ ํํฐ ํ๊ทธ๋ฅผ ์ปฌ๋ ์ ๋ฒํผ์ ์ด์ฉํ์ฌ ์ ๋ ฌ ๋ฐ ๋ค์ค ์ ํ ๊ธฐ๋ฅ ๊ตฌํ
        - ์ปฌ๋ ์ ๋ทฐ๋ฅผ ์ผ์ชฝ์ผ๋ก ์ ๋ ฅ ์์ผ์ฃผ๋ ์ปค์คํ flowLayout์ ์ฌ์ฉํด ์ ๋ ฌ์ํค๊ณ  ์คํฌ๋กค์ disableํ์ฌ ์ฌ์ฉ
    - ์ ํ๋ ํ๊ทธ๋ฅผ ํ๋จ ๋ฐ์ ์ถ๊ฐํด ๋ณด์ฌ์ฃผ๊ธฐ
        - ์ ํ๋ ํํฐ๊ฐ ์์๋๋ ํ๋จ๋ฐ์ ์ปจํ์ด๋ view ๋์ด๋ฅผ 0์ผ๋ก ์คฌ๋ค๊ฐ ์ ํ์ด ๋์์๋ ๋์ ์ผ๋ก ํ๋จ๋ฐ์ ํํฐ๊ฐ ์ถ๊ฐ ๋๋๋ก ๊ตฌํ
    - ์ ํ๋ ํ๊ทธ์ ์ญ์  ๊ธฐ๋ฅ ๋ฐ UI ์๋ฐ์ดํธ ๊ตฌํ
        - ํ๋จ stackView์์ ์ญ์ ์ ์ปฌ๋ ์๋ทฐ์๋ ๊ฐ์ ํํฐ ๋ฒํผ์ด ์ ์ฉ๋๋๋ก ๋ก์ง ๊ตฌํ

# ๐โ๐จ Library

|                     ๋ผ์ด๋ธ๋ฌ๋ฆฌ                      |                   ์ฉ๋                    |
| :-------------------------------------------------: | :---------------------------------------: |
|    [SnapKit](https://github.com/SnapKit/SnapKit)    |      ์ฝ๋ ๋ฒ ์ด์ค UI ์์ ์๊ฐ ์ต์ํ      |
|       [Then](https://github.com/devxoul/Then)       | ํด๋ก์ ๋ฅผ ํตํด ์ธ์คํด์ค์ ๋ํ ์ฒ๋ฆฌ ๊ฐ๊ฒฐํ |
| [Alamofire](https://github.com/Alamofire/Alamofire) |           ๋คํธ์ํน ์์ ๋จ์ํ            |
|   [RxSwift](https://github.com/ReactiveX/RxSwift)   |    RxCocoa๋ฅผ ์ด์ฉํด ๋น๋๊ธฐ ์ฒ๋ฆฌ ์ฉ์ดํ    |



# ๐ฅ Code Convention
> [๋ฎค๋ฉํธ ์์์ ์ ์ฒด Code Convention์ ๋ณด๊ณ  ์ถ๋ค๋ฉด?!](https://www.notion.so/Code-Convention-f5b103a299114616b99d3c071f041d34)

- ํจ์ : `lowerCamelCase`, `๋์ฌ + ๋ชฉ์ ์ด` ํํ
- ๋ณ์, ์์ : `lowerCamelCase`
- ํด๋์ค : `UpperCamelCase`
- ์ฝ์ด ์ฌ์ฉ ๋ฒ์

  `TableView -> TV`

  `TableViewCell -> TVC`

  `CollectionView -> CV`

  `CollectionViewCell -> CVC`

  `ViewController -> VC`

  `identifier -> id`

  
- ์ฃผ์

    `\\`-> MARK, TODO ์ฃผ์

    `\\\`-> ๋ฌธ์ํ ์ฃผ์
- MARK ๊ตฌ๋ฌธ
    - 10์ค ์ด์์ ๋ชจ๋  ํ์ผ์์๋ MARK ๊ตฌ๋ฌธ์ ์ฌ์ฉํฉ๋๋ค.
    - ํด๋นํ๋ MARK ๊ตฌ๋ฌธ๋ง ์ฌ์ฉํฉ๋๋ค.
    ```
    // MARK: - Protocols ์ฌ๋งํ๋ฉด ํ์ผ๋ก ๋นผ์.

    // MARK: - Properties
    // MARK: - @IBOutlet Properties
    // MARK: - Initialization
    // MARK: - View Life Cycle
    // MARK: - UI
    // MARK: - Functions
    // MARK: - @IBAction Properties 

    // MARK: - Extension๋ช
    // MARK: - Network
    ```


# ๐ Git Flow
> [๋ฎค๋ฉํธ ์์์ Git Convention ์ ์ฒด ๋ณด๊ธฐ](https://www.notion.so/Git-Convention-6117195b56d5464eb4ecd25fec0f3ac1)

<details>
<summary>๋ฎค๋ฉํธ ์์์ ์ ์ฒด Git Flow๊ฐ ๊ถ๊ธํ๋ค๋ฉด?!</summary>
<div markdown="1">
 
![๋ฎค๋ฉํธ ์์์ ์ ์ฒด Git Flow๊ฐ ๊ถ๊ธํ๋ค๋ฉด?!](https://user-images.githubusercontent.com/25932970/178236698-e033bb5b-266b-4360-983f-0c6b7818d91b.png)
 </details>
 
## ์์ ์์
```
1. Issue ์์ฑ
2. Branch ์์ฑ
3. ์์, commit
4. push
5. PR ์์ฑ
6. ์ฝ๋ ๋ฆฌ๋ทฐ (24์๊ฐ ์ด๋ด)
7. ๋ ๋ช(๊ถ์ฅ), ํ ๋ช(์ต์) Approve ๋ฐ์์ ๊ฒฝ์ฐ ์ํ merge
8. Delete Branch
```
## Commit Convention
`ํ์: ์ค๋ช #์ด์ ๋ฒํธ`

```
  Feat: ์๋ก์ด ์ฃผ์ ๊ธฐ๋ฅ ์ถ๊ฐ
  Add: ํ์ผ ์ถ๊ฐ, ์์ ์ถ๊ฐ
  Fix: ๋ฒ๊ทธ ์์ 
  Del: ์ธ๋ชจ์๋ ์ฝ๋ ์ญ์ 
  Refactor: ์ฝ๋ ๋ฆฌํฉํ ๋ง
  Mod: ์คํ ๋ฆฌ๋ณด๋, Xib ํ์ผ ์์ 
  Move: ํ๋ก์ ํธ ๊ตฌ์กฐ ๋ณ๊ฒฝ
  Rename: ํ์ผ, ํด๋์ค, ๋ณ์๋ช ๋ฑ ์ด๋ฆ ๋ณ๊ฒฝ
  Docs: Wiki, README ํ์ผ ์์ 
  Chore: ๊ทธ ์ธ
```
## Branch

- ๊ฐ์ฅ ์ฒ์์ ๋ถ๋ ๋ถ๋ฅ ์์ญ์์๋, ์ปค๋ฐ ์ปจ๋ฒค์์ ์๋ฉ๊ณผ ๋์ผํ๊ฒ ์์ฑํฉ๋๋ค.

### Branch Naming

> `๋ถ๋ฅ` /`#์ด์ ๋ฒํธ` - `์์ํ  ๋ทฐ` - `์์ธ ์์ ๋ด์ญ`
> 

```swift
chore/#3-Project-Setting
feat/#3-HomeView-UI
fix/
refactor/#1-

```


## Merge

- ๋ณธ์ธ์ `PR`์ ๋ณธ์ธ์ด `Merge`ํฉ๋๋ค.
- ์ต๋ํ ๋นจ๋ฆฌ, ์ต๋ 24์๊ฐ ์ด๋ด์ ์ฝ๋ ๋ฆฌ๋ทฐ๋ฅผ ๋ฑ๋กํฉ๋๋ค.
- ์ต์ ํ๋ฅผ ์์ฃผ ํ์!
- Approve๋ฅผ ์ต์ 1๋ชํํ ๋ฐ์์ผ Merge๊ฐ ๊ฐ๋ฅํฉ๋๋ค.
    - 2๋ช์ด ์ต๋ํ Approve ์ค ์ ์๋๋ก ํฉ์๋ค!
- ์ฝ๋ ๋ฆฌ๋ทฐ๋ฅผ ํ๋ฉด์ ํ์์ ์ธ ์์  ์ฌํญ์ ๋ฐ๊ฒฌํ  ๊ฒฝ์ฐ, `Approve` ๋์  `Request Changes`๋ฅผ ์ฃผ์ด ์์ ์ ์๊ตฌํฉ๋๋ค.
    - ํด๋น `PR` ์์์๋, ์์  ์ฌํญ์ ๋ฐ์ํ์ฌ ์๋ก `commit`์ ์ถ๊ฐํ ํ, ํด๋น `PR`์ `push`ํ์ฌ `Re-request review`๋ฅผ ์์ฒญํฉ๋๋ค.
        1. `Request Changes`: ์ปจ๋ฒค์ 
        2. `Approve`: ์ผ๋จ OK! ๋ก์ง, ๋ฆฌํฉํ ๋ง ๊ฐ๋ฅํ ๋ถ๋ถ, ๋ ๋์ ์ฝ๋๋ฅผ ์ํ ์ ์ ๋ฑ
- ๋ชจ๋  ์์์ด ์๋ฃ๋์ด `Merge`๊ฐ ๋ ๊ฒฝ์ฐ, ํด๋น `PR` ํ๋จ์ `Delete Branch`๋ฅผ ์ ํํ์ฌ ์์์ด ๋๋ `Branch`๋ฅผ ์ญ์ ํฉ๋๋ค.
 
# ๐ Foldering Convention
```
.
โโโ Application
โย ย  โโโ AppDelegate.swift
โย ย  โโโ SceneDelegate.swift
โโโ Global
โย ย  โโโ Base
โย ย  โย ย  โโโ BaseNVC.swift
โย ย  โย ย  โโโ BaseVC.swift
โย ย  โโโ Extensions
โย ย      โโโ UIViewController+.swift
โย ย      โโโ ๊ธฐํ Extension ํ์ผ.swift
โโโ Info.plist
โโโ Network
โย ย  โโโ APIEssentials
โย ย  โย ย  โโโ APIConstants.swift
โย ย  โย ย  โโโ GenericResponse.swift
โย ย  โย ย  โโโ NetworkConstants.swift
โย ย  โโโ APIManagers
โย ย  โย ย  โโโ BaseAPI.swift
โย ย  โโโ Bases
โย ย  โย ย  โโโ NetworkResult.swift
โย ย  โย ย  โโโ TargetType.swift
โย ย  โโโ EventLogger.swift
โย ย  โโโ Services
โโโ Resources
โย ย  โโโ Assets.xcassets
โย ย  โโโ Colorsets.xcassets
โย ย  โโโ Fonts
โย ย      โโโ NotoSans-SemiBold.ttf
โโโ Sources
 ย ย  โโโ Components
 ย ย  โย ย  โโโ DefaultNavigationView.swift
 ย ย  โโโ MumentTabBarController.swift
 ย ย  โโโ Scenes
 ย ย      โโโ Home
 ย ย      โย ย  โโโ HomeVC.swift
 ย ย      โย ย  โโโโ Model
 ย ย      โย ย   ย ย  โโโ CarouselModel.swift
 ย ย      โโโ Storage
 ย ย      โโโ Write
```

# ๐ค ์ด๋ ค์ ๋ ์  & ๊ทน๋ณต ๊ณผ์ 
## ์ ์ ๋น

์ต๊ทผ ๊ฒ์ํ ๊ณก์ ์ ์ฅํ๋ ๊ธฐ๋ฅ ๊ตฌํ์์, ์ต๊ทผ "๊ฒ์์ด"๊ฐ ์๋ ์ต๊ทผ ๊ฒ์ํ "๊ณก"์ ๋ก์ปฌ์ ์ ์ฅํด์ผ ํ๋ ๊ธฐ๋ฅ์ด ์์์ต๋๋ค. ๊ณก ์์ฒด๋ struct ๋ฐฐ์ด๋ก ๊ด๋ฆฌํ๋๋ฐ, UserDefaults์ ํด๋น ๋ฐฐ์ด์ ์ ์ฅํ๋ ค๊ณ  ํ๋๊น ์ ๋๋ ์ค๋ฅ๊ฐ ์์์ต๋๋ค.
Swift ๊ณต์๋ฌธ์ UserDefaults์์,
> A default object must be a property listโthat is, an instance of (or for collections, a combination of instances of) NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. If you want to store any other type of object, you should typically archive it to create an instance of NSData.
    
์ฌ๊ธฐ์ ๋์ ์๋ ํ์์ด ์๋๋ฉด Data ํ์์ผ๋ก ์์นด์ด๋น/์ธ์์นด์ด๋นํ์ฌ set/get์ ํด์ผ ํ์์ต๋๋ค. ๊ทธ๋์ JSONEncoder๋ฅผ ์ด์ฉํ์ฌ struct array๋ฅผ ์ธ์ฝ๋ฉํ ํ, Data ํ์์ผ๋ก UserDefaults์ ์ ์ฅํ์์ต๋๋ค. ์ด ๊ฐ์ ๊บผ๋ด์ฌ ๋์๋ Data ํ์์ด๋ผ JSONDecoder๋ฅผ ์ด์ฉํ์ฌ ๋์ฝ๋ฉํ ํ struct array์ธ์ง if let ๋ฐ์ธ๋ฉ์ผ๋ก ํ์ธํ ํ, ๋ฐ์ดํฐ๊ฐ ์ ๋๋ก ๋ค์ด์จ๋ค๋ฉด ํด๋น ๊ฐ์ returnํ๋ ํจ์๋ฅผ ๋ง๋ค์ด ์ฌ์ฉํ์์ต๋๋ค.

## ๊น์ง๋ฏผ

 ๊ตฌํ์ ์์ด ๊ฐ์ฅ ์ด๋ ค์์ ๊ฒช์ ๋ถ๋ถ์ ํ ๋ทฐ์ ๋ฐฐ๋(์บ๋ก์ฌ ๋ทฐ)์์ต๋๋ค. ์ฐธ๊ณ ํ๊ธฐ ์ํด ์ฐพ์๋ ์ฝ๋๋ค์ ๋ฏ์  ๋ถ๋ถ์ด ๋ง์ ์ฒ์์ ๋ฌด์์ ์ด๋ป๊ฒ ์์ ํด์ผ ํ ์ง ์ ํ ๊ฐ์ ์ก์ง ๋ชปํ์ง๋ง, ์ฝ๋๋ฅผ ํ ์ค์ฉ ์ฐจ๊ทผ์ฐจ๊ทผ ์ดํดํ๊ณ  ๋ง์ ์ฐ์ต์ ํด๋ด์ผ๋ก์จ ํ์ํ ์ง์์ ์ตํ๊ณ  ๋งก์ ๊ธฐ๋ฅ์ ๊ตฌํํ  ์ ์์์ต๋๋ค.
 ์ด ์ธ์๋ ๋ผ์ด๋ธ๋ฌ๋ฆฌ Snapkit, Then์ ์ด์ฉํ ์ฝ๋๋ฒ ์ด์ค, ํ์ด๋ธ๋ทฐ์ ์ปฌ๋ ์๋ทฐ๊ฐ ์ค์ฒฉ๋ ๋ทฐ๋ค์์ protocol์ ์ด์ฉํด API์์ ๋ถ๋ฌ์จ ๋ฐ์ดํฐ ์ ์ฉํ๋ ๊ฒ ๋ฑ ์ฒ์ ๋์ ํด ๋ฏ์  ๋ถ๋ถ๋ค์ด ๋ง์์ง๋ง ํ์๋ค์ ๋์๊ณผ ํจ๊ป ์ค์ค๋ก ์ฐฌ์ฐฌํ ์ดํดํ๋ ์๊ฐ์ ๊ฐ์ง์ผ๋ก์จ ์ ์ง์์ ์ต์ํด์ง๊ณ , ๋ฐฐ์ด ๊ฒ๋ค์ ๋์ฑ ๋ค์ํ๊ฒ ํ์ฉํ  ์ ์๊ฒ ๋์์ต๋๋ค.
 ์๋ก ๋ฐฐ์ด ๊ฒ์ ์ ๊ทน์ ์ผ๋ก ๊ณต์ ํ๊ณ  ๊ฐ๋ฅด์ณ์ฃผ๋ ํ ๋ฌธํ ๋๋ถ์ ๋ค๋ฅธ ํ์๋ค์ด ๋งก์ ๊ธฐ๋ฅ ๊ตฌํ ๋ฐฉ๋ฒ ์ญ์ ํจ๊ป ๋ฐฐ์ฐ๋ฉด์ ํผ์ ๊ณต๋ถํ๋ ๊ฒฝ์ฐ๋ณด๋ค ํจ์ฌ ๋ง์ ์ง์์ ๋ฐฐ์ธ ์ ์์์ผ๋ฉฐ ๋ด๊ฐ ์๊ฒ ๋ ๊ฒ์ ํ์ธ์๊ฒ ์ค๋ชํ๋ ์๊ฐ์ ๊ฐ์ง์ผ๋ก์จ ์์ฑํ ์ฝ๋๋ฅผ ๋์ฑ ํ์คํ ์ดํดํ  ์ ์์์ต๋๋ค. ์ฝ๋๋ฆฌ๋ทฐ ๋ฌธํ๋ ์๋ก์ ์ฝ๋๋ฅผ ์ฝ๊ณ  ์ดํดํ๋ ๋ฅ๋ ฅ์ ๊ธฐ๋ฅผ ์ ์๊ฒ ํด์ฃผ์์ผ๋ฉฐ ํ๋ฐํ ํผ๋๋ฐฑ์ ํตํด ๋ ๋์ ์ฝ๋๋ก ํ๋ก์ ํธ๋ฅผ ์์ฑํด๋๊ฐ ์ ์์์ต๋๋ค.

    
## ๊น๋ด์ธ

 ๊ธฐ๋ณธ์ ์ผ๋ก ๊ฐ๋ฐ์ ์ผ๋ก ํ์์ ์งํํ ๊ฒฝํ์ด ๊ฑฐ์ ์์๊ณ , ๊นํ๋ธ ๊ฐ์ ํด ์ฌ์ฉ์ ์ต์ํ์ง ์์ ์ฒ์์ ํ๋ก์ ํธ๋ฅผ ์์ํ  ๋ ์ข ํท๊ฐ๋ ธ์ง๋ง, ๊ทธ๋ด๋๋ง๋ค ํ์๋ค์ด ์น์ ํ ์ ์๋ ค์ฃผ๊ณ , ์ ์ด๋์ฃผ์ด ์ ์ ์ํ  ์ ์๊ฒ ๋์์ต๋๋ค. ์ฌํ๊น์ง iOS ๊ฐ๋ฐ์ ๋ํ์ฌ ์ธ๋ฏธ๋์์ ๋ฐฐ์ด ๋ด์ฉ๊ณผ ๊ณผ์ ๋ฅผ ํตํ ๊ธฐ๋ณธ์ ์ธ ๋ด์ฉ๋ง ์๊ณ  ์๋ ์์ค์ด์์ง๋ง ์ฑ์ผ ์ด๋ฐ์๋ ๊ฐ์ธ์ ์ธ ์ผ์ ์ด ๋ชฐ๋ ค์์ด ํ์ํ ๊ฐ๋ฐ ์ฐ์ต์ ๋ง์ ์๊ฐ์ ๋ด์ง ๋ชปํด ์์ฌ์ ์ต๋๋ค. ๋๋ฌธ์ ๋ณธ๊ฒฉ์ ์ผ๋ก ๊ฐ๋ฐ์ ์์ํ์ ๋ ์ค์ ๋ก ๊ฐ๋ฐ์ ํ๋ ๊ณผ์ ์์ ๋ชจ๋ฅด๋๊ฒ๋ ๋ง๊ณ , ์ ์๋๋ ๋ถ๋ถ์ด ๋ง์๋ ๊ฒ ๊ฐ์ต๋๋ค. ๊ทธ๋ด๋ ํ์๋ค์ด ์น์ ํ๊ฒ ์ฐพ์์ฃผ๊ณ  ์จ์ค ๊ฐ๋ฐ ๋ ํผ๋ฐ์ค๋ฅผ ๋ณด๋ฉด์ ๋ง์ด ๋ฐฐ์ ๊ณ , ๋ชจ๋ฅด๋ ๊ฒ๋ค์ ํ์๋ค์๊ฒ ์ง๋ฌธํ๋ฉด ๋๋ฌด ์น์ ํ๊ฒ ์ ์๋ ค์ฃผ์ด ๊ฐ๋ฐ์ ํ๋๋ฐ ํฐ ๋์์ด ๋์๋๊ฒ ๊ฐ์ต๋๋ค. ์ด๋ฒ ์ฑ์ผ ๋๋ถ์ ํ ํ๋ก์ ํธ๋ฅผ ์ด๋ค์์ผ๋ก ์งํํ๋์ง ์ ์ฒด์ ์ธ ํ๋ก์ฐ์ ๋ํด ๋ณด๋ค ์ ์ดํด ํ  ์ ์์๊ณ , ๋จ์ํ ๊ฐ๋ฐ์ ์ธ ๊ฒ ๋ฟ ์๋๋ผ ์ํต ๋ฐฉ์ ๋ฑ์ ์ด๋ป๊ฒ ํด์ผํ๋์ง๋ ๋ง์ด ๋ฐฐ์ธ ์ ์์์ต๋๋ค.
