//
//  ContentView.swift
//  CoreMLImageApp
//
//  Created by 황규상 on 7/9/24.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State var message = ""
    @State var arrayIndex = 0
    @State var image: UIImage = UIImage(named: "cat")!
    
    let photoArray = ["cat", "plane", "banana", "car"]
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            TextEditor(text: $message)
                .padding()
            Button {
                useAI(sentImage: photoArray[arrayIndex])
            } label: {
                Text("Analyze Image")
            }.padding()
            
            HStack {
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                }
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                }
            }
        }
        .padding()
    }
    
    func useAI(sentImage: String) {
        guard let imagePath = Bundle.main.path(forResource: sentImage, ofType: "jpg") else {
            message = "Image not found"
            return
        }
        
        let imageURL = NSURL.fileURL(withPath: imagePath)
        
        let modelFile = try? MobileNetV2(configuration: MLModelConfiguration())
        let model = try! VNCoreMLModel(for: modelFile!.model)
        
        let handler = VNImageRequestHandler(url: imageURL)
        
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
        
        try! handler.perform([request])
    }
    
    func findResults(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            fatalError("Unable to get results")
        }
        
        var bestGuess = ""
        var bestConfidence: VNConfidence = 0
        
        for classification in results {
            if classification.confidence > bestConfidence {
                bestConfidence = classification.confidence
                bestGuess = classification.identifier
            }
        }
    }
}

#Preview {
    ContentView()
}
