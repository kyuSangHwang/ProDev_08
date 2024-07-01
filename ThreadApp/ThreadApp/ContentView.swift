//
//  ContentView.swift
//  ThreadApp
//
//  Created by 황규상 on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var message = ""
    @State var results = ""
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate() // 시작 시간 기록
                
                // 데이터 가져오기 및 처리
                let fetchedData = fetchSomethingFromServer()
                let processedData = processData(fetchedData)
                let firstResult = calculateFirstResult(processedData)
                let secondResult = calculateSecondResult(processedData)
                
                // 처리 결과 요약
                let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                results = resultsSummary
                
                let endTime = NSDate() // 종료 시간 기록
                message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds" // 메시지에 소요된 시간 표시
            }
            
            TextEditor(text: $results) // 결과를 보여주는 텍스트 에디터
            Slider(value: $sliderValue)
            Text("Message = \(message)") // 완료 메시지 표시
        }
    }
    
    /// 서버에서 데이터를 가져오는 함수
    /// - Returns: 1초 대기 후 가져온 데이터 반환
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi there"
    }
    
    /// 데이터를 처리하는 함수
    /// - Parameter data: 서버에서 가져온 데이터
    /// - Returns: 2초 대기 후 데이터를 대문자로 변환하여 반환
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    /// 첫 번째 결과를 계산하는 함수
    /// - Parameter data: 대문자로 변환한 데이터
    /// - Returns: 3초 대기 후 데이터의 문자 개수를 계산하여 메시지로 반환
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    /// 두 번째 결과를 계산하는 함수
    /// - Parameter data: 대문자로 변환한 데이터
    /// - Returns: 4초 대기 후 데이터에서 "E"를 "e"로 대체하여 반환
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
}

#Preview {
    ContentView()
}
