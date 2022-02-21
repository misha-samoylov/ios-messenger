//
//  ChatViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 10.02.2022.
//

import UIKit
import Alamofire

struct DummyData: Decodable {
    let userId: Int //    1
    let id: Int //    1
    let title: String //    "delectus aut autem"
    let completed: Bool //    false
}

class ChatViewController: UIViewController {
    
    private let tableView = UITableView()
    private var responseQ: [DummyData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Чат"
        self.view.backgroundColor = UIColor.systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(GroupTableCell.self, forCellReuseIdentifier: "firstStyle")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "secondStyle")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "thirdStyle")
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        AF.request("https://jsonplaceholder.typicode.com/todos").responseDecodable(of: [DummyData].self) { (response) in
            switch response.result {
                case .success(let value):
                    
                for element in value {
                    self.responseQ.append(element)
                    self.tableView.reloadData()
                }

                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.responseQ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstStyle", for: indexPath) as! GroupTableCell
            cell.labelName.text = "First text"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondStyle", for: indexPath)
            cell.textLabel!.text = "Second text"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdStyle", for: indexPath)
            // cell.textLabel?.text = "Third text"
            cell.textLabel?.text = self.responseQ[indexPath.row].title
            return cell
        }
        
    }
    
    /* Решение проблемы с constraints высотой ячейки */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
