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
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Animal.name, ascending: true)],
        animation: .default)
    private var animals: FetchedResults<Animal>
    var body: some View {
        VStack {
            TextField("Enter pet name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter pet breed", text: $petBreed)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                coreDM.savePet(name: petName, breed: petBreed)
                petName = ""
                petBreed = ""
            }
            
            List {
                ForEach(animals, id: \.self) { pet in
                    VStack(alignment: .leading) {
                        Text(pet.name ?? "-")
                        Text(pet.breed ?? "-")
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let pet = animals[index]
                        coreDM.deletePet(animal: pet)
                    }
                })
            } 
        }
        .padding()
    }
}

#Preview {
    ContentView(coreDM: CoreDataManager())
}
