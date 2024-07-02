//
//  ContentView.swift
//  ReadWriteApp
//
//  Created by 황규상 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let placeHolder = "텍스트를 입력하세요."
    @State var createText = "텍스트를 입력하세요."
    @State var displayText = ""
    
    @FocusState var textFieldFocus: Bool
    var body: some View {
        VStack {
            Text("Write")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            TextEditor(text: $createText)
                .border(Color.gray, width: 0.5)
                .foregroundStyle(placeHolder == createText ? .gray : .black)
                .focused($textFieldFocus)
                .onChange(of: textFieldFocus) {
                    if textFieldFocus, placeHolder == createText {
                        createText = ""
                    } else if !textFieldFocus, createText.isEmpty {
                        createText = placeHolder
                    }
                }
            
            HStack {
                Spacer()
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    
                    do {
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("File writing error")
                    }
                }) {
                    Text("Write File")
                }
                
                Spacer()
                
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File reading error")
                    }
                }) {
                    Text("Read File")
                }
                Spacer()
            }
            .padding()
            
            Text("Read")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            TextEditor(text: $displayText)
                .border(Color.gray, width: 0.5)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
