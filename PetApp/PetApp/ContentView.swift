//
//  ContentView.swift
//  PetApp
//
//  Created by 황규상 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var petName: String = ""
    @State var petBreed: String = ""
    @State var petArray: Array = [Animal]()
    
    var body: some View {
        VStack {
            TextField("Enter pet name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter pet breed", text: $petBreed)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                coreDM.savePet(name: petName, breed: petBreed)
                displayPets()
                petName = ""
                petBreed = ""
            }
            
            List {
                ForEach(petArray, id: \.self) { pet in
                    VStack {
                        Text(pet.name ?? "-")
                        Text(pet.breed ?? "-")
                    }
                }
            }
        }
        .padding()
        .onAppear {
            displayPets()
        }
    }
    
    func displayPets() {
        petArray = coreDM.getAllPets()
    }
}

#Preview {
    ContentView(coreDM: CoreDataManager())
}
