//
//  EmployeeTableViewCell.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-16.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure cell appearance if needed
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        teamLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func configure(with employee: Employee) {
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
        
        // Load the employee's photo asynchronously
        
        if let photoURLSmall = employee.photoUrlSmall {
            
            ImageCacheManager.shared.loadImage(from: photoURLSmall) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.photoImageView.image = image
                    }
                    
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                    self.photoImageView.image = UIImage(named: "placeholder")
                }
            }
        } else {
            photoImageView.image = UIImage(named: "placeholder")
        }
    }
}
