//
//  EmployeeDirectoryViewController.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import UIKit

class EmployeeDirectoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    private var employeeCell = "EmployeeTableViewCell"
    var employees: [Employee] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupRefreshControl()
        reloadEmployees()
    }
    
    func setupTableview(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: employeeCell, bundle: nil), forCellReuseIdentifier: employeeCell)
    }
    
    private func reloadEmployees() {
        showLoadingState()
        
        NetworkManager.shared.getEmployees { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            
            switch result {
            case .success(let employees):
                self.employees = employees
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.showEmptyStateIfNeeded()
                    self.hideLoadingState()
                }
                
            case .failure(let error):
                if error as? NetworkError == NetworkError.noData{
                    self.showEmptyStateIfNeeded()
                } else {
                    self.showErrorState(with: error.localizedDescription)
                }
                self.hideLoadingState()
            }
        }
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshEmployees), for: .valueChanged)
    }
    
    @objc private func refreshEmployees() {
        reloadEmployees()
    }
    
    func showLoadingState() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        tableView.isHidden = true
        emptyStateLabel.isHidden = true
    }
    
    func hideLoadingState() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = false
    }
    
    func showEmptyStateIfNeeded() {
        emptyStateLabel.isHidden = !employees.isEmpty
        tableView.isHidden = true
    }
    
    func showErrorState(with message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
    @objc func phoneButtonClicked(_ sender: AnyObject){
        guard let phoneNumber = employees[sender.tag].phoneNumber else {return}
        
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
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
        cell.selectionStyle = .none
        cell.configure(with: employee)
        cell.phoneButton.tag = indexPath.row
        cell.phoneButton.addTarget(self, action: #selector(phoneButtonClicked(_:)), for: .touchUpInside)
        return cell
    }
}

extension EmployeeDirectoryViewController: UITableViewDelegate {
    // Implement any necessary delegate methods
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
