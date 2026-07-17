# 코드 스멜 카탈로그 (Fowler & Beck, Refactoring 3장 기준)

각 스멜: 감지 신호 → 추천 리팩토링. 기법명은 Fowler 책의 표준 명칭.

## 목차
1. Duplicated Code / 2. Long Method / 3. Large Class / 4. Long Parameter List
5. Divergent Change / 6. Shotgun Surgery / 7. Feature Envy / 8. Data Clumps
9. Primitive Obsession / 10. Switch Statements / 11. Parallel Inheritance Hierarchies
12. Lazy Class / 13. Speculative Generality / 14. Temporary Field / 15. Message Chains
16. Middle Man / 17. Inappropriate Intimacy / 18. Alternative Classes with Different Interfaces
19. Incomplete Library Class / 20. Data Class / 21. Refused Bequest / 22. Comments

---

## 1. Duplicated Code (중복 코드)
스멜 순위 1위. 같은 코드 구조가 두 곳 이상에 존재.

**감지 신호**
- 같은 클래스의 두 메서드에 동일한 표현식
- 형제 서브클래스들에 같은/비슷한 코드
- 서로 무관한 클래스에 같은 로직
- 복사-붙여넣기 후 일부만 수정한 흔적 (변수명만 다르고 구조 동일)

**추천 리팩토링**
- 같은 클래스 내: **Extract Method** 후 양쪽에서 호출
- 형제 서브클래스 간: **Extract Method** + **Pull Up Method/Field**. 비슷하지만 다르면 공통 부분만 추출 후 **Form Template Method**. 알고리즘만 다르면 **Substitute Algorithm**
- 무관한 클래스 간: **Extract Class**로 공통 컴포넌트를 만들거나, 메서드가 원래 속할 곳 하나를 정해 다른 쪽이 호출

## 2. Long Method (긴 메서드)
**감지 신호**
- 메서드 내용을 설명하려고 주석 블록이 붙어 있음 (주석 = 추출 후보 표시)
- 조건문/루프가 깊게 중첩됨
- 임시 변수와 파라미터가 많아 흐름 추적이 어려움
- 핵심 판단 기준은 줄 수가 아니라 **"메서드가 하는 일(what)과 방법(how) 사이의 의미적 거리"** — 이름만 보고 내용을 짐작할 수 없으면 길다

**추천 리팩토링**
- 기본: **Extract Method** (주석이 붙은 블록, 조건식, 루프 본문이 추출 후보)
- 임시 변수가 추출을 방해하면: **Replace Temp with Query**
- 파라미터가 많으면: **Introduce Parameter Object**, **Preserve Whole Object**
- 그래도 안 되면: **Replace Method with Method Object**
- 조건식: **Decompose Conditional**

## 3. Large Class (거대 클래스)
**감지 신호**
- 인스턴스 변수가 지나치게 많음
- 공통 접두사/접미사를 가진 변수 묶음 (depositAmount, depositCurrency → 컴포넌트 후보)
- 일부 변수는 특정 상황에서만 사용됨
- 수백 줄 메서드가 여럿, 클래스 내부에도 중복 존재

**추천 리팩토링**
- **Extract Class** (연관 변수 묶음별로), 서브클래스가 자연스러우면 **Extract Subclass**
- 클라이언트 사용 패턴별로 **Extract Interface**를 뽑아보면 분리 아이디어가 나옴
- GUI 클래스라면 **Duplicate Observed Data**로 도메인 객체 분리

## 4. Long Parameter List (긴 파라미터 목록)
**감지 신호**
- 파라미터 4개 이상이면 의심, 호출부마다 순서 헷갈림
- 한 객체에서 꺼낸 값들을 낱개로 넘김
- 새 데이터가 필요할 때마다 시그니처가 계속 바뀜

**추천 리팩토링**
- 이미 아는 객체에게 물어서 얻을 수 있으면: **Replace Parameter with Method**
- 한 객체에서 나온 값 묶음: **Preserve Whole Object**
- 논리적 객체 없이 흩어진 값들: **Introduce Parameter Object**
- 예외: 호출 대상이 큰 객체에 의존하면 안 되는 경우엔 낱개 전달이 정당함

## 5. Divergent Change (발산적 변경)
한 클래스가 서로 다른 이유로 각기 다른 방식으로 자주 수정됨.

**감지 신호**
- "DB가 바뀌면 이 3개 메서드, 새 금융상품이 생기면 저 4개 메서드를 고쳐야 해" 같은 상황
- 한 클래스 안에 서로 무관한 변경 축이 2개 이상

**추천 리팩토링**
- 변경 원인별로 묶어 **Extract Class**. 목표는 "한 종류의 변경 = 한 클래스"

## 6. Shotgun Surgery (산탄총 수술)
Divergent Change의 반대: 한 종류의 변경에 여러 클래스를 조금씩 고쳐야 함.

**감지 신호**
- 하나의 개념(예: 할인 정책)이 여러 클래스에 흩어져 있음
- 수정할 때 "빠뜨린 곳 없나?" 불안함

**추천 리팩토링**
- **Move Method** + **Move Field**로 변경 지점을 한 클래스로 모음
- 적합한 클래스가 없으면 새로 만들고, **Inline Class**로 흩어진 행동을 흡수

## 7. Feature Envy (기능 욕심)
메서드가 자기 클래스보다 다른 클래스에 더 관심이 많음.

**감지 신호**
- 다른 객체의 getter를 대여섯 번 호출해 값을 계산
- 메서드 본문에서 `other.getX()`, `other.getY()`가 `this` 참조보다 많음

**추천 리팩토링**
- **Move Method**로 데이터가 있는 곳으로 이동
- 일부만 욕심내면 **Extract Method** 후 그 부분만 **Move Method**
- 여러 클래스 데이터를 쓰면 데이터가 가장 많은 클래스로
- 예외: Strategy, Visitor, Self Delegation 패턴은 의도적으로 이 규칙을 깬다 (변경을 한곳에 모으기 위해). 패턴 적용으로 보이면 스멜로 보고하지 않음

## 8. Data Clumps (데이터 뭉치)
**감지 신호**
- 같은 3~4개 데이터가 여러 클래스의 필드, 여러 메서드의 파라미터로 반복 등장 (예: start, end, step)
- 판별 테스트: 그중 하나를 지우면 나머지가 의미를 잃는가? 그렇다면 객체로 태어나야 할 뭉치

**추천 리팩토링**
- 필드로 나타나면: **Extract Class**
- 파라미터로 나타나면: **Introduce Parameter Object**, **Preserve Whole Object**
- 객체가 생기면 Feature Envy 탐색으로 이어가 행동도 옮김

## 9. Primitive Obsession (기본 타입 집착)
**감지 신호**
- 돈(숫자+통화), 범위(상한+하한), 전화번호, 우편번호 같은 개념을 원시 타입/문자열로 처리
- 타입 코드 (int/string 상수로 종류 구분)
- 배열의 인덱스로 서로 다른 의미의 값을 꺼내 씀

**추천 리팩토링**
- **Replace Data Value with Object**
- 타입 코드: 행동에 영향 없으면 **Replace Type Code with Class**, 조건문이 있으면 **Replace Type Code with Subclasses** 또는 **Replace Type Code with State/Strategy**
- 필드 묶음: **Extract Class**, 파라미터: **Introduce Parameter Object**, 배열: **Replace Array with Object**

## 10. Switch Statements (switch 문)
**감지 신호**
- 같은 switch/if-else 체인(같은 값 기준 분기)이 프로그램 여러 곳에 흩어짐 — 새 case 추가 시 전부 찾아 고쳐야 함
- 타입 코드 기준 분기

**추천 리팩토링**
- **Extract Method**로 switch 추출 → **Move Method**로 타입 코드를 가진 클래스로 → **Replace Type Code with Subclasses/State-Strategy** → **Replace Conditional with Polymorphism**
- 단일 메서드의 소수 case이고 변경 가능성 낮으면 다형성은 과잉 — **Replace Parameter with Explicit Methods**, null case는 **Introduce Null Object**

## 11. Parallel Inheritance Hierarchies (평행 상속 계층)
**감지 신호**
- 한 계층에 서브클래스를 만들 때마다 다른 계층에도 만들어야 함
- 두 계층의 클래스명 접두사가 나란히 대응됨

**추천 리팩토링**
- 한 계층 인스턴스가 다른 계층 인스턴스를 참조하게 하고, **Move Method** + **Move Field**로 한쪽 계층을 소멸시킴

## 12. Lazy Class (게으른 클래스)
**감지 신호**
- 밥값을 못하는 클래스: 리팩토링으로 축소됐거나, 계획만 있고 구현 안 된 클래스
- 메서드 한두 개짜리 껍데기

**추천 리팩토링**
- 서브클래스면 **Collapse Hierarchy**, 아니면 **Inline Class**

## 13. Speculative Generality (추측성 일반화)
**감지 신호**
- "언젠가 필요할 것"이라며 넣은 훅, 추상 클래스, 미사용 파라미터
- 테스트 코드만 사용하는 메서드/클래스
- 실제 구현이 하나뿐인 인터페이스/추상 계층

**추천 리팩토링**
- 추상 클래스: **Collapse Hierarchy**, 불필요한 위임: **Inline Class**
- 미사용 파라미터: **Remove Parameter**, 난해한 추상명: **Rename Method**
- 테스트만 쓰는 코드는 테스트와 함께 삭제

## 14. Temporary Field (임시 필드)
**감지 신호**
- 특정 상황에서만 값이 설정되는 인스턴스 변수
- 복잡한 알고리즘의 중간값을 파라미터 대신 필드에 저장 (알고리즘 밖에서는 무의미)

**추천 리팩토링**
- **Extract Class**로 변수들과 관련 코드를 모아 메서드 객체(method object)로
- 유효하지 않은 경우의 조건문은 **Introduce Null Object**로 제거

## 15. Message Chains (메시지 체인)
**감지 신호**
- `a.getB().getC().getD()` 같은 연쇄, 또는 임시 변수 연쇄
- 클라이언트가 중간 객체들의 구조에 결합됨 — 중간 관계가 바뀌면 클라이언트도 수정

**추천 리팩토링**
- **Hide Delegate** (단, 모든 지점에 적용하면 Middle Man 양산 — 균형 필요)
- 대안: 체인 결과를 쓰는 코드를 **Extract Method** → **Move Method**로 체인 아래로 내려보냄

## 16. Middle Man (중개자)
**감지 신호**
- 클래스 인터페이스의 절반 이상이 다른 클래스로 단순 위임

**추천 리팩토링**
- **Remove Middle Man**으로 실제 객체와 직접 대화
- 위임 메서드가 소수면 **Inline Method**, 추가 행동이 있으면 **Replace Delegation with Inheritance**
- Message Chains와 반대 방향의 스멜 — 둘 사이 균형점을 찾는 것이 목표

## 17. Inappropriate Intimacy (부적절한 친밀)
**감지 신호**
- 두 클래스가 서로의 private 부분(내부 필드, 구현 세부)에 지나치게 개입
- 양방향 참조
- 서브클래스가 부모 내부를 과도하게 알고 있음

**추천 리팩토링**
- **Move Method** + **Move Field**로 분리, **Change Bidirectional Association to Unidirectional**
- 공통 관심사는 **Extract Class**로 안전한 곳에, 또는 **Hide Delegate**로 중개
- 상속 문제면 **Replace Inheritance with Delegation**

## 18. Alternative Classes with Different Interfaces
**감지 신호**
- 같은 일을 하는 메서드가 클래스마다 다른 시그니처

**추천 리팩토링**
- **Rename Method**로 통일 → **Move Method**로 프로토콜이 같아질 때까지 행동 이동 → 중복이 생기면 **Extract Superclass**

## 19. Incomplete Library Class (불완전한 라이브러리 클래스)
**감지 신호**
- 라이브러리 클래스에 필요한 메서드가 없는데 수정 불가

**추천 리팩토링**
- 메서드 한두 개: **Introduce Foreign Method**
- 다량의 추가 행동: **Introduce Local Extension**

## 20. Data Class (데이터 클래스)
**감지 신호**
- 필드 + getter/setter만 있고 행동이 없음
- 다른 클래스들이 이 클래스의 데이터를 꺼내 세부 조작 (조작 로직이 밖에 있음)
- public 필드

**추천 리팩토링**
- public 필드: 즉시 **Encapsulate Field**, 컬렉션 필드: **Encapsulate Collection**
- 변경되면 안 되는 필드: **Remove Setting Method**
- getter/setter 사용처를 찾아 **Move Method**(안 되면 **Extract Method** 후 이동)로 행동을 데이터 클래스 안으로
- 이후 **Hide Method**로 getter/setter 은닉

## 21. Refused Bequest (거부된 유산)
**감지 신호**
- 서브클래스가 물려받은 메서드/데이터 대부분을 안 씀
- **강한 신호**: 구현 재사용은 하면서 부모의 인터페이스는 지원하지 않으려 함

**추천 리팩토링**
- 혼란을 일으키는 경우에만: 형제 클래스를 만들어 **Push Down Method/Field**
- 인터페이스 거부(강한 경우): **Replace Inheritance with Delegation**
- 주의: 원저자들은 "열에 아홉은 무시해도 될 약한 스멜"이라 평가 — 실제 문제를 일으킬 때만 보고

## 22. Comments (주석)
주석 자체는 좋은 것. 문제는 **나쁜 코드의 탈취제로 쓰인 주석**.

**감지 신호**
- 코드 블록이 무엇을 하는지 설명하는 주석 (→ 그 블록은 메서드 추출 후보)
- 빽빽한 주석 아래 이 카탈로그의 다른 스멜들이 숨어 있음

**추천 리팩토링**
- 블록 설명 주석: **Extract Method** (주석 내용을 메서드 이름으로)
- 추출했는데도 설명이 필요: **Rename Method**
- 시스템 상태 규칙 서술: **Introduce Assertion**
- 정당한 주석: "왜" 그렇게 했는지, 확신이 없는 부분의 표시 — 이런 주석은 스멜이 아님
