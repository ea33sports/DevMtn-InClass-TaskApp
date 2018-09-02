//
//  TaskListDetailTableViewController.swift
//  Task
//
//  Created by Eric Andersen on 8/29/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class TaskListDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var addDueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDueDateTextField.inputView = dueDatePicker
        updateViews()
    }
    
    func updateViews() {
        
        guard let task = task, isViewLoaded else { return }
        title = task.name
        taskNameTextField.text = task.name
        addDueDateTextField.text = task.due?.stringValue()
        notesTextField.text = task.notes
    }
    
    func updateTask() {
        guard let name = taskNameTextField.text else { return }
        let due = dueDateValue
        let notes = notesTextField.text
        
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let titleText = taskNameTextField.text, titleText.isEmpty {
            return
        } else {
            updateTask()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        guard let dateTextField = addDueDateTextField.text else { return }
        dueDateValue = sender.date
        addDueDateTextField.text = dueDateValue?.stringValue()
        if dateTextField.isEmpty {
            addDueDateTextField.text = ""
            updateViews()
        }
    }
    
    @IBAction func userTappedView(_ sender: UIGestureRecognizer) {
        taskNameTextField.resignFirstResponder()
        addDueDateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
}







































































