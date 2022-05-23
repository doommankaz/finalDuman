//
//  AddTaskViewController.swift
//  dumanFinal
//
//  Created by Дара Отарбаева   on 23.05.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveButton(_ sender: Any) {
        print("Saving Task...")
        let task = Task(name: txtTaskName.text ?? "", time: datePicker.date)
        
        let vm = TodoViewModel.sharedInstance
        vm.addTask(task: task) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
