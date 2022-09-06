//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Fábio Carvalho on 06/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add new note", text: $text)
                Button {
                    guard text.isEmpty == false else { return }
                    
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(.plain)
                .foregroundColor(.accentColor)
                
            } //: HStack
            
            Spacer()
            
            if notes.count > 0 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i+1)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                                    .disableAutocorrection(true)
                                
                            }
                        } //: HStack
                    } //: ForEach
                    .onDelete(perform: delete)
                    
                }//: List
                
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                
                Spacer()
            }
            
        } //: VStack
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
    
    func save() {
        DispatchQueue.main.async {
            do {
                let data = try JSONEncoder().encode(notes)
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                try data.write(to: url)
                
            } catch {
                print("Could not save data")
            }
        }
    }
    
    func load() {
        do {
            let url = getDocumentDirectory().appendingPathComponent("notes")
            let data = try Data(contentsOf: url)
            
            notes = try JSONDecoder().decode([Note].self, from: data)
            
        } catch {
            print("No data file found")
        }
    }
    
    func delete(offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        save()
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
