import UIKit

// 전통적인 함수 정의: `descriptiveName`라는 이름의 함수를 정의.
func descriptiveName() {
    print("Run!")
}

// 전통적인 함수 실행: 정의한 `descriptiveName` 함수를 호출.
descriptiveName()

print("")

func multipleBy2 (x: Int) -> Int {
    return x * 2
}

print(multipleBy2(x: 5))
print(multipleBy2(x: 18))

// Closure 상수: 클로저를 상수 y에 저장.
let y = { (x: Int) -> Int in return x * 2 }

print(y(5))
print(y(18))

print("\n클로저 인풋, 아웃풋 인자 생략")

// 클로저 인풋, 아웃풋 인자 생략: 타입 추론을 사용하여 입력 및 출력 타입을 생략.
let z = { x in return x * 2 }

print(z(5))
print(z(18))

print("\nreturn 키워드 생략")

// return 키워드 생략: 표현식이 단일 문장일 때 return 키워드를 생략할 수 있음.
let w = { x in x * 2 }

print(w(5))
print(w(18))

print("\n인풋 arguments 이름 생략")

// 인풋 arguments 이름 생략: 단일 인자를 사용하여 클로저를 단순화.
let v = { $0 * 2 }

print(v(5))
print(v(18))

func addNumbers (x: Int, y: Int) -> Int {
     return x + y
 }

 // 인풋 인자 타입 생략
 let a = { (x, y) -> Int in return x + y }

 print(a(4,5))
 print(a(17,19))

 // return 타입 생략
 let b = { (x: Int, y: Int) in return x + y }

 print(b(4,5))
 print(b(17,19))

 let c = { (x: Int, y: Int) in x + y }

 print(c(4,5))
 print(c(17,19))

 // 모호성이 있는 경우, 매개변수의 데이터 유형을 명시적으로 정의해야함.
 let d = { $0 as Int + $1 as Int }

 print(d(4,5))
 print(d(17,19))

// 데이터로서의 클로저
 print("-----------------")
 print(d(4,5))
 print(d(1, d(4,5)))
