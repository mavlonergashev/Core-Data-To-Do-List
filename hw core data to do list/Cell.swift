//
//  Cell.swift
//  hw core data to do list
//
//  Created by Mavlon on 15/04/22.
//

import UIKit

protocol TaskDoneDelegate {
    func doneChanged(index: Int)
}

class Cell: UITableViewCell {

    @IBOutlet weak var isDoneBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var delegate: TaskDoneDelegate?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isDoneBtnPressed(_ sender: Any) {
        delegate?.doneChanged(index: index)
    }
    
    func updateCell(task: ToDoItem) {
        titleLbl.text = task.title
        
        if task.isDone {
            isDoneBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            isDoneBtn.tintColor = .systemGreen
        } else {
            isDoneBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            isDoneBtn.tintColor = .systemRed
        }
    }
    
}
