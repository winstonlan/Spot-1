//
//  SpotInViewController.swift
//  Spot
//
//  Created by Winston Lan on 1/29/19.
//  Copyright © 2019 Winston Lan. All rights reserved.
//

import UIKit
import Firebase

class SpotInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var people = [
        Person(name: "Michael Scott", amount: 5),
        Person(name: "Jim Halpert", amount: 10),
        Person(name: "Pam Beasley", amount: 15)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        ref.observe(.value, with: {snapshot in
            var newPeople: [Person] = []
            
            for item in snapshot.children {
                let person = Person(snapshot: item as! DataSnapshot)
                newPeople.append(person)
            }
            self.people = newPeople
            self.tableView.reloadData()
        })
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spot_cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(format: "$%.2f", people[indexPath.row].amount)
        
        return cell
    }
    
    @IBAction func addButtonDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "New Loan",
                                      message: "Enter new money loaned.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Name"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Amount Loaned"
        })
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let textFieldName = alert.textFields?.first,
                let textName = textFieldName.text else {return}
            
            
            
            guard let textFieldAmount = alert.textFields?.last,
                let textAmount = textFieldAmount.text else {return}
            
            let person = Person(name: textName, amount: Double(textAmount) ?? 0)
            let personRef = self.ref.childByAutoId()
            personRef.setValue(person.toAnyObject())
        }))
        
        self.present(alert, animated: true)
    }
}
