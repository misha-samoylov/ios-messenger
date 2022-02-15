//
//  TabViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 12.02.2022.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let iconContacts = UITabBarItem(title: "Контакты", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        let iconChat = UITabBarItem(title: "Сообщения", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        let iconSettings = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        let contactsVC = ContactsViewController()
        let settingsVC = SettingsViewController()
        let chatVC = ChatViewController()
        
        let navContacts = UINavigationController()
        navContacts.viewControllers = [contactsVC]
        navContacts.tabBarItem = iconContacts
        
        let navChat = UINavigationController()
        navChat.viewControllers = [chatVC]
        navChat.tabBarItem = iconChat
        
        let navSettings = UINavigationController()
        navSettings.viewControllers = [settingsVC]
        navSettings.tabBarItem = iconSettings
        
        self.viewControllers = [navContacts, navChat, navSettings]
    }
}
