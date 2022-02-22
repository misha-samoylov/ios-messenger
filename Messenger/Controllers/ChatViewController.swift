//
//  ChatViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 10.02.2022.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController {
    
    private var tableView = UITableView()
    private var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    private var responseModel: [InfoModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Чат"
        self.view.backgroundColor = UIColor.systemBackground
        
        spinner = UIActivityIndicatorView(frame: .zero)
        spinner.startAnimating()
        self.view.addSubview(spinner)
        
        spinner.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.translatesAutoresizingMaskIntoConstraints = false

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Регистрация какие и как выглядят ячейки
        tableView.register(GroupTableCell.self, forCellReuseIdentifier: "groupStyle")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "chatStyle")
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.isHidden = true
        spinner.isHidden = false
        
        AF.request("https://jsonplaceholder.typicode.com/todos").responseDecodable(of: [InfoModel].self) { (response) in
            switch response.result {
                case .success(let value):

                for element in value {
                    self.responseModel.append(element)
                    self.tableView.reloadData()
                    
                    self.tableView.isHidden = false
                    self.spinner.isHidden = true
                }

                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // В первой секции только одна ячейка
            return 1
        }
        
        return self.responseModel.count
    }
    
    // Общее количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Названия секций
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Группы"
        }

        return "Чаты"
    }
    
    // Какие и где ячейки используются
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // первая секция
            if indexPath.row == 0 { // первая ячейка
                let cell = tableView.dequeueReusableCell(withIdentifier: "groupStyle", for: indexPath) as! GroupTableCell
                cell.labelName.text = "First text"
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatStyle", for: indexPath)
        cell.textLabel?.text = self.responseModel[indexPath.row].title
        return cell
    }
    
    // Нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DialogViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Решение проблемы с constraints высотой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
