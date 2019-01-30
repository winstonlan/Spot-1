//
//  SpotInViewController.swift
//  Spot
//
//  Created by Winston Lan on 1/29/19.
//  Copyright © 2019 Winston Lan. All rights reserved.
//

import UIKit

class SpotInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let names = ["Michael Scott", "Jim Halpert", "Pam Beasley"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spot_cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = "$0.00"
        
        return cell
    }
}
