//
//  ContentView.swift
//  Room
//
//  Created by Baran Barış Kıvılcım on 31.03.2024.
//

import SwiftUI

struct ContentView2: View {
    @State var data: [Home] = [.init(name: "Evren"), .init(name: "Yasar"), .init(name: "Necati")]

    var body: some View {
        VStack {
         
            List(data, id: \.id) { person in
                //Text(person.person.name)
                FakeRow1(model: person.person)
            }
        }
    }
}

struct FakeRow1:View {
    @ObservedObject var model: PersonModel
    var body: some View {
        HStack {
            Text(model.name)
            
            Button {
                model.updateName("cc")
            } label: {
                Text("aaa")
            }

        }
        
    }
}


struct Home {
    var id = UUID().uuidString
    var person: PersonModel
    
    init(name: String) {
        self.person = PersonModel(name: name)
    }
    
    mutating func updateName(_ name:String) {
        person.updateName(name)
    }
}


class PersonModel: ObservableObject {
    var id = UUID().uuidString
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(_ name:String) {
        self.name = name
    }
}
