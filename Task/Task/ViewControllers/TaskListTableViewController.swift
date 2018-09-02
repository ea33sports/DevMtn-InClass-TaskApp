//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Eric Andersen on 8/29/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try TaskController.shared.fetchedResultsController.performFetch()
        } catch {
            print("❌ Error fetching with FetchResultsController: \(error.localizedDescription)")
        }
        
    }
    
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        guard let tasks = TaskController.shared.fetchedResultsController.fetchedObjects else { return }
        let task = tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell
        guard let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else { return UITableViewCell() }

        // Configure the cell...
        cell?.delegate = self
        cell?.update(withTask: task)

        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            TaskController.shared.remove(task: task)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "cellToTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
            let destinationVC = segue.destination as? TaskListDetailTableViewController
            destinationVC?.task = task
            destinationVC?.dueDateValue = task?.due
        }
    }
}


























































