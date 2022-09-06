//
//  SettingsView.swift
//  Notes WatchKit Extension
//
//  Created by Fábio Carvalho on 06/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Slider(value: Binding(get: {
                value
                
            }, set: { newValue in
                value = newValue
                update()
                
            }), in: 1...4, step: 1)
                .tint(.accentColor)
            
        } //:VStack
    }
    
    func update() {
        lineCount = Int(value)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
