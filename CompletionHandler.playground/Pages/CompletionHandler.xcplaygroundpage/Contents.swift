import UIKit

// 에러를 정의하는 열거형: 작업 도중 발생할 수 있는 주요 에러를 정의
enum BigError: Error {
    case powerOutage
    case endOfTheWorld
}

// 응답을 정의하는 열거형: 작업의 성공 또는 실패를 나타냄
enum Response {
    case success
    case failure
}

// 작업 시작 시간 기록
let startTime = NSDate()

/// 비동기 작업을 수행하는 함수
/// - Parameter completion: 작업 완료 후 결과를 처리하는 클로저
func doSomething(completion: (Result<Response, BigError>) -> Void) {
    print("Starting task")
    Thread.sleep(forTimeInterval: 2)
    
    let randomNumber = Int.random(in: 0..<2)
    if randomNumber == 0 { // 랜덤 숫자가 0일 경우, 에러를 반환하고 종료
        completion(.failure(.powerOutage))
        return
    }
    
    completion(.success(.success)) // 랜덤 숫자가 1일 경우, success 반환
}

// doSomething 함수 호출 및 결과 처리
doSomething { result in
    switch result {
    case .success(let response):
        print("Result = \(response)")
    case .failure(let error):
        print("This is the error = \(error)")
    }
    print("Ending task")
}

// 작업 종료 시간 기록, 소요된 시간 출력
let endTime = NSDate()
print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
