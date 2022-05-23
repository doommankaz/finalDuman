//
//  Task.swift
//  dumanFinal
//
//  Created by Дара Отарбаева   on 23.05.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var time: Date = Date()
    
    override init() {
        super.init()
    }
    
    init(name: String, time: Date) {
        self.name = name
        self.time = time
    }
}
