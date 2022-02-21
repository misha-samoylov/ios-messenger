//
//  InfoModel.swift
//  Messenger
//
//  Created by Misha Samoylov on 21.02.2022.
//

import Foundation

struct InfoModel: Decodable {
    let userId: Int //    1
    let id: Int //    1
    let title: String //    "delectus aut autem"
    let completed: Bool //    false
}
