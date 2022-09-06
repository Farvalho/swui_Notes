//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Fábio Carvalho on 06/09/2022.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            } //:HStack
            .foregroundColor(.accentColor)
            
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            Spacer()
            } //:ScrollView
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                Spacer()
                Text("\(index)/\(count)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                
            } //:HStack
            .foregroundColor(.secondary)
            
        } //: VStack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData = Note(id: UUID(), text: "Test preview")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
