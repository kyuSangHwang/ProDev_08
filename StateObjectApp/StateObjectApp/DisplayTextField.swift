//
//  DisplayTextField.swift
//  StateObjectApp
//
//  Created by 황규상 on 7/2/24.
//

import SwiftUI

struct DisplayTextField: View {
    @EnvironmentObject var creature: AnimalModel
    
    var body: some View {
        HStack {
            Text("Name:")
            TextField("Type a name here", text: $creature.name)
        }
        HStack {
            Text("Breed:")
            TextField("Type a breed here", text: $creature.breed)
        }
        HStack {
            Text("Age:")
            Slider(value: $creature.age, in: 0...20)
        }
        HStack {
            Text("Weight:")
            Slider(value: $creature.weight, in: 0...200)
        }
    }
}
