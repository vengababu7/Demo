//
//  ViewController.swift
//  NevaTask
//
//  Created by Vengababu Maparthi on 13/02/19.
//  Copyright © 2019 Vengababu Maparthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dataTableView: UITableView!
    var model = DataModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getTheDataFromModel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getTheDataFromModel() {
        model.getTheDataFromAPI { (success) in
            if success{
                self.dataTableView.reloadData()
            }
        }
    }
}


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.parsedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifer, for: indexPath) as! DataTableViewCell
        cell.data = model.parsedData[indexPath.row]
        return cell
    }
    
}
