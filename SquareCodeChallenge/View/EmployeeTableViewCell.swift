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
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure cell appearance if needed
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        teamLabel.font = UIFont.systemFont(ofSize: 16)
        biographyLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func configure(with employee: Employee) {
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
        biographyLabel.text = employee.biography
        
        // Load the employee's photo asynchronously
        
        if let photoURLLarge = employee.photoUrlLarge {
            
            ImageCacheManager.shared.loadImage(from: photoURLLarge) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.photoImageView.image = image
                    }
                    
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                    self.photoImageView.image = UIImage(systemName: "person.fill")
                }
            }
        } else {
            self.photoImageView.image = UIImage(systemName: "person.fill")
        }
    }
}
