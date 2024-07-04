//
//  ContentView.swift
//  LocalApp
//
//  Created by 황규상 on 7/4/24.
//

import SwiftUI

struct ContentView: View {
    @State var changeColor = false
    @State var message = ""
    
    var placeHolder: LocalizedStringKey = "placeholder-label"
    
    let date = Date()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full // full, long, medium, short
        dateFormatter.timeStyle = .full
        return dateFormatter
    }()
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("greeting-label \(message)"))  // 로컬라이즈된 문자열 키를 사용하여 텍스트를 표시
            
            // Text, Button 는 LocalizedStringKey 를 직접 넣을 수 있다.
            Text("greeting-label \(message)")
            Button("button-label") {
                changeColor.toggle()
            }
            TextField(placeHolder, text: $message)
            Text(date, formatter: dateFormatter)
        }
        .padding()
        .background(changeColor ? Color.red : Color.yellow)
    }
}

// 한국어로 기본 프리뷰 설정
#Preview("기본 - 한국어") {
    ContentView()
}

// MARK: 언어 미리보기 설정
// 영어로 프리뷰 설정
#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

// 프랑스어로 프리뷰 설정
#Preview("French") {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}

// 스페인어로 프리뷰 설정
#Preview("Spanish") {
    ContentView()
        .environment(\.locale, .init(identifier: "es"))
}
