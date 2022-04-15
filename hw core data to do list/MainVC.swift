//
//  MainVC.swift
//  hw core data to do list
//
//  Created by Mavlon on 15/04/22.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    var data: [ToDoItem] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func newTaskBtnPressed(_ sender: Any) {
    }
    
}

//MARK: - Table View

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let isDoneText = data[indexPath.row].isDone ? "[✅]" : "[❎]"
        cell.textLabel?.text =  "\(isDoneText)" + "\(data[indexPath.row].title)"
        
        return cell
    }
    
}

