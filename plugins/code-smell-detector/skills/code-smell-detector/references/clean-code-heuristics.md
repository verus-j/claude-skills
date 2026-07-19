# Clean Code 휴리스틱 카탈로그 (Robert C. Martin, Clean Code 17장)

Fowler 카탈로그(`smell-catalog.md`)가 클래스·메서드 **구조**의 리팩토링 신호를 다룬다면, 이 카탈로그는 주석·네이밍·함수·테스트·빌드 환경까지 포함한 더 넓은 **가독성/설계 휴리스틱**이다.

- 두 카탈로그에 모두 있는 항목은 **Fowler 쪽을 대표 스멜로 보고**하고, 이 카탈로그의 ID를 괄호로 병기한다 (예: `Duplicated Code (G5)`).
- 이 카탈로그에만 있는 항목은 ID + 원문 명칭으로 보고한다 (예: `G16 Obscured Intent`). 사용자가 책에서 바로 찾을 수 있다.
- E(환경)·T(테스트) 계열은 소스 파일만 봐서는 일부만 감지된다. 빌드 스크립트나 테스트 코드가 분석 대상에 포함될 때만 적용한다.

## 주석 (Comments)

- **C1 Inappropriate Information** — 변경 이력, 작성자, 수정일, 이슈 번호 등 버전 관리/이슈 트래커가 담아야 할 메타데이터가 주석에 있음. → 삭제. 주석은 코드와 설계에 대한 기술적 노트만.
- **C2 Obsolete Comment** — 코드와 어긋난 오래된 주석. 원래 설명하던 코드에서 멀어져 떠도는 "부유하는 섬". → 갱신하거나 즉시 삭제.
- **C3 Redundant Comment** — 코드가 이미 말하는 것을 반복 (`i++; // increment i`, 시그니처만 되풀이하는 Javadoc). → 삭제. 주석은 코드가 스스로 말하지 못하는 것만 말해야 한다.
- **C4 Poorly Written Comment** — 장황하고, 당연한 얘기를 하고, 문법이 엉망인 주석. → 간결하게 다듬거나 삭제.
- **C5 Commented-Out Code** — 주석 처리된 코드 덩어리. 날이 갈수록 부패하며, 아무도 지우지 못함. → 즉시 삭제 (버전 관리 시스템이 기억한다).

관련: Fowler #22 Comments — "나쁜 코드의 탈취제로 쓰인 주석"(블록 설명 주석)은 Fowler 쪽 처방(Extract Method 등)을 따른다.

## 환경 (Environment)

- **E1 Build Requires More Than One Step** — 빌드에 여러 단계, 비밀 스크립트, 흩어진 아티팩트 수집이 필요함. → 체크아웃 한 번 + 명령 한 번으로 빌드되게.
- **E2 Tests Require More Than One Step** — 전체 테스트를 한 명령(또는 IDE 버튼 하나)으로 못 돌림. → 단일 명령으로 전체 테스트 실행 가능하게.

## 함수 (Functions)

- **F1 Too Many Arguments** — 인수는 0개가 최선, 3개 초과는 회피. → Fowler #4 Long Parameter List 처방 참조.
- **F2 Output Arguments** — 인수를 출력 용도로 사용. 독자는 인수를 입력으로 기대한다. → 상태 변경은 호출된 객체 자신이 하게.
- **F3 Flag Arguments** — boolean 인수는 함수가 두 가지 이상의 일을 한다는 자백. → 함수를 분리.
- **F4 Dead Function** — 아무도 호출하지 않는 메서드. → 삭제 (G9 Dead Code와 동일 계열).

## 일반 (General)

- **G1 Multiple Languages in One Source File** — 한 소스 파일에 여러 언어(Java 안의 XML/HTML/JS 문자열 등)가 뒤섞임. → 추가 언어의 수와 범위를 최소화.
- **G2 Obvious Behavior Is Unimplemented** — 함수 이름에서 당연히 기대되는 동작이 구현되지 않음 (`StringToDay("Monday")`는 되는데 소문자/약어는 안 됨). → 최소 놀람 원칙에 맞게 기대 동작을 구현.
- **G3 Incorrect Behavior at the Boundaries** — 경계·코너 케이스가 검증되지 않음. → 직관을 믿지 말고 모든 경계 조건을 찾아 테스트 작성 (T5와 짝).
- **G4 Overridden Safeties** — 컴파일러 경고 끄기, 실패하는 테스트 꺼두기, serialVersionUID 수동 제어 등 안전장치 무력화. → 안전장치를 복구하고 원인을 해결.
- **G5 Duplication** — DRY 위반. 명백한 복붙 → Extract Method. 반복되는 switch/if-else 체인 → 다형성. 유사 알고리즘 → Template Method / Strategy. → Fowler #1 Duplicated Code 참조.
- **G6 Code at Wrong Level of Abstraction** — 고수준 개념과 저수준 세부가 한 컨테이너에 섞임 (베이스 클래스에 구현 전용 상수, `Stack` 인터페이스의 `percentFull()`). → 저수준 개념을 파생/별도 모듈로 **완전히** 분리. 잘못 놓인 추상화는 거짓말로 때울 수 없다.
- **G7 Base Classes Depending on Their Derivatives** — 베이스 클래스가 파생 클래스 이름을 앎. → 의존 제거해 독립 배포 가능하게 (예외: FSM처럼 파생이 고정되고 항상 함께 배포되는 경우).
- **G8 Too Much Information** — 넓고 깊은 인터페이스, 많은 메서드/인스턴스 변수, protected 남발. → 인터페이스를 작고 빡빡하게. 데이터·유틸 함수·상수·임시 변수를 은닉해 결합도를 낮춤.
- **G9 Dead Code** — 실행되지 않는 코드: 불가능한 조건의 if 본문, 안 던지는 예외의 catch, 안 불리는 유틸, 발생 불가한 switch case. → 정중히 장례 치르고 삭제.
- **G10 Vertical Separation** — 변수·private 함수가 사용처에서 수백 줄 떨어져 정의됨. → 지역 변수는 첫 사용 직전에, private 함수는 첫 호출 바로 아래에.
- **G11 Inconsistency** — 같은 일을 다른 방식·다른 이름으로 처리 (`response` vs `httpResp`, `processVerificationRequest` vs `handleDeletion`). → 한 컨벤션을 정해 유사한 모든 곳에 일관 적용.
- **G12 Clutter** — 구현 없는 기본 생성자, 안 쓰는 변수, 정보 없는 주석 등 잡동사니. → 제거.
- **G13 Artificial Coupling** — 범용 enum/static 함수가 특정 클래스 안에 선언되어, 무관한 모듈 전체가 그 클래스를 알게 됨. → 원래 있어야 할 위치로 이동.
- **G14 Feature Envy** — 다른 클래스의 데이터를 탐하는 메서드. → Fowler #7 참조 (필요악인 경우도 있음: 리포트 포매터가 도메인 객체를 읽는 것은 정당).
- **G15 Selector Arguments** — 동작을 선택하는 boolean/enum/int 인수 (`calculateWeeklyPay(false)`). F3의 일반형. → 선택지별로 함수 분리.
- **G16 Obscured Intent** — 한 줄에 욱여넣은 식, 헝가리안 표기, 매직 넘버로 의도가 가려짐. → 의도가 보이도록 풀어쓰기 (G19, G25와 연계).
- **G17 Misplaced Responsibility** — 코드가 독자가 자연스럽게 기대하는 곳에 있지 않음 (PI 상수는 삼각함수 옆에). → 함수 이름이 암시하는 곳, 독자가 기대하는 곳으로 이동.
- **G18 Inappropriate Static** — 다형적으로 동작할 가능성이 있는 함수가 static (`HourlyPayCalculator.calculatePay(employee, rate)`). → 인스턴스 메서드로. 의심되면 nonstatic이 기본.
- **G19 Use Explanatory Variables** — 계산 과정이 통짜 식으로 있어 불투명함. → 중간값을 의미 있는 이름의 변수로 분해. 설명 변수는 많을수록 좋다.
- **G20 Function Names Should Say What They Do** — `date.add(5)`처럼 호출만 봐서는 무엇을 하는지 알 수 없음. → `addDaysTo`, `daysLater`처럼 동작이 드러나는 이름으로. 구현을 봐야 이해되는 이름은 교체 대상.
- **G21 Understand the Algorithm** — if와 플래그를 찔러 넣어 "돌아가게만" 만든 코드. → 동작 원리가 자명해질 때까지 리팩토링. 테스트 통과만으로는 "안다"고 할 수 없다.
- **G22 Make Logical Dependencies Physical** — 의존 모듈에 대한 암묵적 가정 (`HourlyReporter`가 PAGE_SIZE=55를 알고 있음). → 명시적으로 물어보게 (`formatter.getMaxPageSize()`).
- **G23 Prefer Polymorphism to If/Else or Switch/Case** — "ONE SWITCH" 규칙: 한 선택 유형당 switch는 최대 하나, 그 switch는 다형 객체를 생성해야 함. → Fowler #10 Switch Statements 참조.
- **G24 Follow Standard Conventions** — 팀/업계 코딩 표준에서 벗어난 코드. → 팀 컨벤션에 맞춤. 코드 자체가 컨벤션의 예시가 되어야 한다.
- **G25 Replace Magic Numbers with Named Constants** — 자기 설명이 안 되는 원시값·토큰 (`86400`, `assertEquals(7777, ...)`의 `"John Doe"`). → 잘 명명된 상수 뒤로 숨김. 예외: `5280`, `Math.PI`, 자명한 수식의 `8`처럼 맥락상 명백한 값.
- **G26 Be Precise** — 통화를 float로, 첫 매치를 유일 매치로 가정, null 가능 반환값 미검사, 동시 갱신 가능성 무시. → 결정을 정밀하게: null 검사, 중복 레코드 검사, 통화는 정수(또는 Money), 락킹.
- **G27 Structure over Convention** — 네이밍 컨벤션에만 의존한 설계 결정. → 강제력 있는 구조로 (switch/case + enum보다 abstract method를 가진 베이스 클래스).
- **G28 Encapsulate Conditionals** — if/while 안의 복잡한 boolean 식. → 의도를 설명하는 함수로 추출 (`if (shouldBeDeleted(timer))`).
- **G29 Avoid Negative Conditionals** — 부정형 조건 (`!buffer.shouldNotCompact()`). → 가능하면 긍정형으로 표현.
- **G30 Functions Should Do One Thing** — 여러 절(section)로 구성되어 여러 일을 하는 함수. → 각각 한 가지 일을 하는 작은 함수들로 분해. → Fowler #2 Long Method 참조.
- **G31 Hidden Temporal Couplings** — 호출 순서가 중요한데 코드가 순서를 강제하지 않음. → 앞 함수의 결과를 다음 함수의 인수로 넘기는 bucket brigade로 순서를 물리적으로 강제.
- **G32 Don't Be Arbitrary** — 이유 없는 임의적 구조 (무관한 public 클래스를 다른 클래스 안에 중첩). 임의로 보이는 구조는 남들이 마음대로 바꾼다. → 구조에 이유를 부여하고 그 이유가 구조로 전달되게.
- **G33 Encapsulate Boundary Conditions** — `+1`/`-1`이 코드 곳곳에 흩어짐 (`level + 1`이 두 번 등장). → `nextLevel` 같은 변수로 캡슐화해 한곳에서 처리.
- **G34 Functions Should Descend Only One Level of Abstraction** — 함수 안 문장들의 추상화 수준이 뒤섞임 (HR 태그의 개념과 HTML 문법 조작이 한 함수에). → 함수 이름보다 한 단계 아래의 동일한 수준으로 정렬. 분리하다 보면 숨어 있던 추상화 경계가 더 드러난다.
- **G35 Keep Configurable Data at High Levels** — 기본값·설정 상수가 저수준 함수에 파묻힘 (`if (port == 0) // use 80 by default`). → 최상위 수준에 상수로 두고 아래로 전달.
- **G36 Avoid Transitive Navigation** — `a.getB().getC().doSomething()` (데메테르 법칙 위반). 모듈이 시스템 전체의 항해 지도를 알게 되어 아키텍처가 경직됨. → Fowler #15 Message Chains 참조.

## Java (J)

- **J1 Avoid Long Import Lists by Using Wildcards** — ⚠️ 원문은 와일드카드 import를 권하지만, 현대 스타일 가이드(Google Java Style 등)와 IDE 관행은 명시적 import를 선호한다. **프로젝트 컨벤션을 우선**하고, 이 항목은 기본적으로 리포트하지 않는다.
- **J2 Don't Inherit Constants** — 상수 접근을 위해 인터페이스를 구현하는 Constant Interface 안티패턴. 상수의 출처가 상속 계층 꼭대기에 숨는다. → `import static`으로 교체.
- **J3 Constants versus Enums** — 종류 구분에 `public static final int` 상수 사용. → enum으로. enum은 메서드와 필드를 가질 수 있어 훨씬 표현력이 높다. → Fowler #9 Primitive Obsession의 타입 코드 처방과 연계.

## 이름 (Names)

- **N1 Choose Descriptive Names** — 이름이 소프트웨어 가독성의 90%. 서술적이지 않은 이름(`x`, `q`, `z`)은 코드를 기호 덩어리로 만든다. → 서술적 이름으로. 의미가 드리프트하면 수시로 재평가.
- **N2 Choose Names at the Appropriate Level of Abstraction** — 구현을 드러내는 이름 (`dial(phoneNumber)` — 전화 연결이 아닌 모뎀도 있음). → 추상화 수준에 맞는 이름으로 (`connect(connectionLocator)`).
- **N3 Use Standard Nomenclature Where Possible** — 기존 관례를 무시한 독자 명명. → 패턴명(`~Decorator`), 언어 관례(`toString`), 프로젝트의 유비쿼터스 언어를 이름에 활용.
- **N4 Unambiguous Names** — `doRename` 안에서 `renamePage`를 호출하는 식의 모호한 이름. → 동작을 구분하는 이름으로 (`renamePageAndOptionallyAllReferences`). 길어도 설명 가치가 우선.
- **N5 Use Long Names for Long Scopes** — 이름 길이는 스코프 길이에 비례해야 함. 5줄 루프의 `i`는 정당하고, 긴 스코프의 짧은 이름은 의미를 잃는다.
- **N6 Avoid Encodings** — `m_`, `f` 접두사, 헝가리안 표기, 서브시스템 접두사(`vis_`). → 제거. 오늘날 환경은 타입/스코프 정보를 이름에 넣지 않아도 제공한다.
- **N7 Names Should Describe Side-Effects** — 이름이 말하는 것보다 많은 일을 하는 함수 (`getOos()`가 없으면 생성까지 함). → 부수 효과까지 드러나게 (`createOrReturnOos`).

## 테스트 (Tests)

- **T1 Insufficient Tests** — "이 정도면 충분해 보인다"로 멈춘 테스트 스위트. → 깨질 수 있는 모든 조건과 계산을 테스트.
- **T2 Use a Coverage Tool!** — 커버리지 도구로 테스트 전략의 구멍(안 다뤄진 모듈·분기)을 찾는다.
- **T3 Don't Skip Trivial Tests** — 사소한 테스트도 작성 비용보다 문서로서의 가치가 크다.
- **T4 An Ignored Test Is a Question about an Ambiguity** — @Ignore/주석 처리된 테스트는 요구사항 모호성에 대한 질문 용도로만 정당하다. 이유 없이 꺼진 테스트는 G4와 같은 스멜.
- **T5 Test Boundary Conditions** — 알고리즘의 중간은 맞히면서 경계를 놓치는 경우가 많다. → 경계 조건 집중 테스트 (G3와 짝).
- **T6 Exhaustively Test Near Bugs** — 버그는 모여 산다. 버그가 나온 함수는 철저히 테스트하면 옆의 버그가 더 나온다.
- **T7 Patterns of Failure Are Revealing** — 테스트 실패의 패턴("5자 초과 입력만 실패")이 진단 단서가 된다. 테스트 케이스를 완전하고 정렬된 상태로 유지할 이유.
- **T8 Test Coverage Patterns Can Be Revealing** — 통과하는 테스트가 실행하는/안 하는 코드를 보면 실패 원인의 단서가 보인다.
- **T9 Tests Should Be Fast** — 느린 테스트는 결국 안 돌리게 되는 테스트다. → 테스트를 빠르게 유지.
