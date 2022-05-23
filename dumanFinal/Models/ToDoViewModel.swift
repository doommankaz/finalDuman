//
//  ToDoviewModel.swift
//  dumanFinal
//
//  Created by Дара Отарбаева   on 23.05.2022.
//

import Foundation
import RealmSwift

class TodoViewModel: NSObject {
    static var sharedInstance = TodoViewModel()
    
    var tasks = [Task]()
    
    typealias completionHandler = () -> Void
    
    let realm = try! Realm()
    
    func addTask(task: Task, completion: completionHandler) {
        
        self.realm.beginWrite()
        
        self.realm.add(task)
        
        try! self.realm.commitWrite()
        
        print("Task saved!")
        
        completion()
        
    }
    
    func loadTasks(completion: completionHandler) {
        
        self.realm.beginWrite()
        
        let savedTasks = self.realm.objects(Task.self)
        self.tasks.removeAll()
        self.tasks.append(contentsOf: savedTasks)
        
        try! self.realm.commitWrite()
        
        completion()
        
    }
}
