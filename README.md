# TO-DO List
----
### 할일 목록

#### 기능상세 
- TableView에 할 일을 추가할 수 있습니다.
- TableView에서 할 일을 삭제할 수 있습니다.
- TableView에서 할 일을 재정렬할 수 있습니다. 
- 할 일들을 데이터 저장소에 저장하여 앱을 재실행 하여도 데이터가 유지되게 합니다 

#### 활용기술 
- UItableView
- UIAlertController
- UserDefaults

#### DEMO
![ezgif com-gif-maker](https://user-images.githubusercontent.com/51107183/147636849-30801a58-76e3-4078-82e4-1a6d118b451b.gif)


#### 배운 내용

##### UITableView
>  데이터들 목록 형태로 보여 줄 수 있는 가장 기본적인 UI  컴포넌트

- 여려 개의 Cell을 가지고 있고 하나의 열과 여러 줄의 행을 지니고 있으며, 수직으로 스크롤이 가능 
- 섹션을 이용해 행을 그룹화하여 콘텐츠를 좀 더 쉽게 탐색 할 수 있습니다. 
- 섹션의 헤더와 푸터에 View를 구성하여 추가적인 정보를 표시 할 수 있습니다. 

##### UITaleViewDataSource 
> UITableViewDataSource는 데이터 뷰를 생성하고 수정하는데 필요한 저보를 테이블 뷰 객체에 제공 

<img width="916" alt="스크린샷 2021-12-29 오후 3 01 41" src="https://user-images.githubusercontent.com/51107183/147631997-8d0ba351-4866-4d1d-8228-6f9e1144918e.png">

##### UITableViewDelegate 
> UITableViewDelegate는 테이블 뷰의 시각적인 부분을 설정하고, 행의 액션관리, 엑세서리 뷰 지원 그리고 테이블 뷰의 개별 행 편집을 도와 줍니다 

<img width="957" alt="스크린샷 2021-12-29 오후 3 04 03" src="https://user-images.githubusercontent.com/51107183/147632103-4b63e0a4-3922-4414-a812-9ae7d9fd9cd6.png">

##### UserDefaults
>  런타임 환경에서 동작 하면서 앱이 실행되는동안 기본 저장소에 접근해 데이터를 저장 
