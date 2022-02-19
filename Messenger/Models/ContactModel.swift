//
//  UserModel.swift
//  Messenger
//
//  Created by Misha Samoylov on 11.02.2022.
//

import Foundation
import RealmSwift

// Объявляем модель Realm
class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var isMale = true
}

// Доступ к БД Realm только из этого файла (контроль доступа)
fileprivate let realm = try! Realm()

// Заполняем данными модель и записываем в БД Realm
func initContacts() {
    var contacts: [Contact] = []
    
    contacts.append(Contact(value: ["name": "Максим", "surname": "Степанов", "isMale": true]))
    contacts.append(Contact(value: ["name": "Ева", "surname": "Козловская", "isMale": false]))
    contacts.append(Contact(value: ["name": "Алексей", "surname": "Павлов", "isMale": true]))
    contacts.append(Contact(value: ["name": "Владимир", "surname": "Леонтьев", "isMale": true]))
    
    contacts.append(Contact(value: ["name": "Александра", "surname": "Галкина", "isMale": false]))
    contacts.append(Contact(value: ["name": "Дарья", "surname": "Коновалова", "isMale": false]))
    contacts.append(Contact(value: ["name": "Полина", "surname": "Громова", "isMale": false]))
    
    // Persist your data easily
    try! realm.write {
        for contact in contacts {
            realm.add(contact)
        }
    }
}

func getContactsCount() -> Int {
    let results = realm.objects(Contact.self)
    return results.count
}

func getContacts() -> [Contact] {
    let results = realm.objects(Contact.self).sorted(byKeyPath: "name")
    
    // Переводим результат в обычный массив Swift
    let array = Array(results)
    return array
}

// Очищаем БД Realm
func clearAllContacts() {
    try! realm.write {
        realm.deleteAll()
    }
}
