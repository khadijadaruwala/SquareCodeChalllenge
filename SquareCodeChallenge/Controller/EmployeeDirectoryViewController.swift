//
//  EmployeeDirectoryViewController.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import UIKit

class EmployeeDirectoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: Collection view delegate and data source methods
extension EmployeeDirectoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmployeeCollectionViewCell", for: indexPath) as! EmployeeCollectionViewCell
        let employee = employees[indexPath.item]
        cell.configure(with: employee)
        return cell
    }
}

extension EmployeeDirectoryViewController: UICollectionViewDelegate {
    // Implement any necessary delegate methods
}
