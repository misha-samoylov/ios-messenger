//
//  SettingsViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 10.02.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var tableView = UITableView()
    private var menu: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Настройки"
        self.view.backgroundColor = UIColor.systemBackground
        
        tableView = UITableView(frame: .zero, style: .grouped)
        
        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        menu.append("Профиль")
        menu.append("Данные")
        menu.append("Уведомления и звуки")
        menu.append("Приватность")
        menu.append("Язык")
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return menu.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Общее"
        }
        
        return ""
    }
}
