//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Fábio Carvalho on 06/09/2022.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
