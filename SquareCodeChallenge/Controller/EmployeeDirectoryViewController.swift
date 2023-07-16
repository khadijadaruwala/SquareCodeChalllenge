//
//  EmployeeDirectoryViewController.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import UIKit

class EmployeeDirectoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var employeeCell = "EmployeeTableViewCell"
    
    private var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: employeeCell, bundle: nil), forCellReuseIdentifier: employeeCell)
        
        reloadEmployees()
    }
    
    private func reloadEmployees() {
        //      Loading
        NetworkManager.shared.fetchEmployees { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let employees):
                self.employees = employees
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                // Show empty and hide loading
                
            case .failure(let error):
                print("Error:", error)
                // show error and hide loading
            }
        }
    }
}

//MARK: Tableview view delegate and data source methods
extension EmployeeDirectoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: employeeCell, for: indexPath) as! EmployeeTableViewCell
        let employee = employees[indexPath.item]
        cell.configure(with: employee)
        return cell
    }
}

extension EmployeeDirectoryViewController: UITableViewDelegate {
    // Implement any necessary delegate methods
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
