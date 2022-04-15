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
            tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        }
    }
    
    var data: [ToDoItem] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTasks()
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
                
                do {
                    try self.context.save()
                } catch {
                    print("Saving Error")
                }
                self.getTasks()
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
    
    func getTasks() {
        do {
            let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
            let tasks = try context.fetch(request)
            self.data = tasks
            self.tableView.reloadData()
        } catch {
            print("Fetching Error")
        }
    }
    
    func deleteTask(task: ToDoItem) {
        try self.context.delete(task)
    }
    
}

//MARK: - Table View

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.index = indexPath.row
        cell.delegate = self
        cell.updateCell(task: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.data[indexPath.row]
        let alertVC = UIAlertController(title: "Edit Task", message: "You can change task title:", preferredStyle: .alert)
        alertVC.addTextField { tf in
            tf.text = task.title
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            //save edited
            if let text = alertVC.textFields?.first?.text {
                task.title = text
                self.tableView.reloadSections(IndexSet(integer: .zero), with: .automatic)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            //cancel
        }
        alertVC.addAction(saveAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

//MARK: - TaskDoneDelegate Protocol

extension MainVC: TaskDoneDelegate {
    
    func doneChanged(index: Int) {
        //edit Task isDone: true/false
        let task = self.data[index]
        task.isDone = !task.isDone
//        getTasks()
        self.tableView.reloadSections(IndexSet(integer: .zero), with: .automatic )
    }
    
}
