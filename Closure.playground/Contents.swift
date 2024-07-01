import UIKit

// 전통적인 함수 정의
func descriptiveName() {
    print("Run!")
}

// 전통적인 함수 실행
descriptiveName()


func multipleBy2 (x: Int) -> Int {
    return x * 2
}

print(multipleBy2(x: 5))
print(multipleBy2(x: 18))

// Closure 상수
let y = { (x: Int) -> Int in return x * 2 }

print(y(5))
print(y(18))
