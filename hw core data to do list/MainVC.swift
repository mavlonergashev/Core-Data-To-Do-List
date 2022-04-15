//
//  MainVC.swift
//  hw core data to do list
//
//  Created by Mavlon on 15/04/22.
//

import UIKit
import CoreData

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
        let alertVC = UIAlertController(title: "New Task", message: "Insert task title:", preferredStyle: .alert)
        
        alertVC.addTextField { tf in
            tf.placeholder = "Title"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            //save
            if let text = alertVC.textFields?.first?.text {
                
                let item = ToDoItem(context: self.context)
                item.title = text
                item.isDone = false
                item.date = Date()
                
            } else {
                alertVC.textFields?.first?.placeholder = "Title: *Required"
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            //cancel
        }
        
        alertVC.addAction(saveAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
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
        cell.textLabel?.text =  "\(isDoneText)" + data[indexPath.row].title!
        
        return cell
    }
    
}

