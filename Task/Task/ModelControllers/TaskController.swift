//
//  TaskController.swift
//  Task
//
//  Created by Eric Andersen on 8/29/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static var shared = TaskController()
    
    var tasks: [Task] = []
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()

    
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = (due)
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
}
