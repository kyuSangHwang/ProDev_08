//
//  ContentView.swift
//  ReadWriteApp
//
//  Created by 황규상 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var createText = ""
    @State var displayText = ""
    
    var body: some View {
        VStack {
            Text("Write")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            TextEditor(text: $createText)
                .border(Color.black, width: 1)
            
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
                .border(Color.black, width: 1)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
