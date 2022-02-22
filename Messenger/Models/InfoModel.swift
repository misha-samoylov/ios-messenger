//
//  InfoModel.swift
//  Messenger
//
//  Created by Misha Samoylov on 21.02.2022.
//

import Foundation

struct InfoModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
