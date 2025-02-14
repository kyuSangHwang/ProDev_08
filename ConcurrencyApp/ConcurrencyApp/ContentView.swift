//
//  ContentView.swift
//  ConcurrencyApp
//
//  Created by 황규상 on 7/1/24.
//

import SwiftUI

enum Response {
    case success
}

struct ContentView: View {
    @State var message = ""
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate()
                callFunction()
                let endTime = NSDate()
                message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds"
            }
            Spacer()
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
        .padding()
    }
    
    /// 비동기 작업 수행 함수 (현재 20초 동안 대기한 후 성공 응답 반환)
    /// - Returns: `Response.success` 반환
    func doSomething() async throws -> Response {
        Thread.sleep(forTimeInterval: 20)
        print("sleep done.")
        return Response.success
    }
    
    /// `doSomething` 함수를 비동기적으로 호출하고 그 결과를 처리
    func callFunction() {
        Task(priority: .high) {
            do {
                _ = try await doSomething()
            } catch {
                //
            }
        }
    }
}

#Preview {
    ContentView()
}
