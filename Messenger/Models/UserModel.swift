//
//  UserModel.swift
//  Messenger
//
//  Created by Misha Samoylov on 11.02.2022.
//

import Foundation

enum Gender {
    case male
    case female
}

struct User {
    var name: String
    var surname: String
    var gender: Gender
}

var users: [User] = []

func initUsers() -> Void {
    users.removeAll()
    
    users.append(User(name: "Максим", surname: "Степанов", gender: .male))
    users.append(User(name: "Ева", surname: "Козловская", gender: .female))
    users.append(User(name: "Алексей", surname: "Павлов", gender: .male))
    users.append(User(name: "Владимир", surname: "Леонтьев", gender: .male))
    users.append(User(name: "Александра", surname: "Галкина", gender: .female))
    users.append(User(name: "Дарья", surname: "Коновалова", gender: .female))
    users.append(User(name: "Полина", surname: "Громова", gender: .female))
}
