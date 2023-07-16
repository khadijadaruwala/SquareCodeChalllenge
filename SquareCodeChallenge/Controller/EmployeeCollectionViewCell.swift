//
//  EmployeeCollectionViewCell.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure cell appearance if needed
    }
    
    func configure(with employee: Employee) {
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
    }
}
