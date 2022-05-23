//
//  ViewController.swift
//  dumanFinal
//
//  Created by Дара Отарбаева   on 22.05.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    let vm = TodoViewModel.sharedInstance
    var data : [Task] = [
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
        self.data.removeAll()
        vm.loadTasks {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = vm.tasks[indexPath.row]
        cell.textLabel?.text = data.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        let timeString = dateFormatter.string(from: data.time)
        cell.detailTextLabel?.text = timeString
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            vm.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.endUpdates()
        }
    }
}
