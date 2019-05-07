//
//  TableViewController.swift
//  CoreData_Nhap1So
//
//  Created by Just Kidding on 4/9/19.
//  Copyright © 2019 Just Kidding. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var dataNumber: [Entity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObject()
    }
    
    func fetchObject() {
        if let data = (try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity]) {
            self.dataNumber = data
            self.tableView.reloadData()
        }
    }

   

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataNumber.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = String( dataNumber[indexPath.row].number)
        return cell
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
        showAlert(title: "Add More", message: "Nhap du lieu ma ban muon luu") {(alert) in
            if let content = alert.textFields?.first?.text {
                let entity = Entity(context: AppDelegate.context)
                entity.number = Int64(content) ?? 0
                AppDelegate.saveContext()
                
                self.fetchObject()
            }
        }
    }
    
    // TODO: - 3. Show Alert
    func showAlert(title: String, message: String, completeHandler: ((UIAlertController) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Nhap vao day"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) {(result: UIAlertAction) -> Void in
            completeHandler?(alertController)
        }
        alertController.addAction(okAction)
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(alertController, animated: true, completion: nil)
            
        }
    }


}
