//
//  UserModel.swift
//  Messenger
//
//  Created by Misha Samoylov on 11.02.2022.
//

import Foundation
import RealmSwift

// Объявляем модель Realm
class ContactModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var isMale = true
}

// Доступ к БД Realm только из этого файла (контроль доступа)
fileprivate let realm = try! Realm()

// Заполняем данными модель и записываем в БД Realm
func initContacts() {
    var contacts: [ContactModel] = []
    
    contacts.append(ContactModel(value: ["name": "Максим", "surname": "Степанов", "isMale": true]))
    contacts.append(ContactModel(value: ["name": "Ева", "surname": "Козловская", "isMale": false]))
    contacts.append(ContactModel(value: ["name": "Алексей", "surname": "Павлов", "isMale": true]))
    contacts.append(ContactModel(value: ["name": "Владимир", "surname": "Леонтьев", "isMale": true]))
    
    contacts.append(ContactModel(value: ["name": "Александра", "surname": "Галкина", "isMale": false]))
    contacts.append(ContactModel(value: ["name": "Дарья", "surname": "Коновалова", "isMale": false]))
    contacts.append(ContactModel(value: ["name": "Полина", "surname": "Громова", "isMale": false]))
    
    // Заполняем БД Realm
    try! realm.write {
        for contact in contacts {
            realm.add(contact)
        }
    }
}

func getContactsCount() -> Int {
    let results = realm.objects(ContactModel.self)
    return results.count
}

func getContacts() -> [ContactModel] {
    let results = realm.objects(ContactModel.self).sorted(byKeyPath: "name")
    
    // Переводим результат из БД в обычный массив Swift
    let array = Array(results)
    return array
}

// Очищаем БД Realm
func clearAllContacts() {
    try! realm.write {
        realm.deleteAll()
    }
}
