//
//  FavoritePlaceCell.swift
//  Favorite Places
//
//  Created by Hivzi on 17.8.22.
//

import UIKit

class FavoritePlaceCell: UITableViewCell {
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(from favoritePlace: FavoritePlace) {
        
        self.longitudeLabel.text = String(format: "%.3f", favoritePlace.longitude)
        self.latitudeLabel.text = String(format: "%.3f", favoritePlace.latitude )
        if let photoData = favoritePlace.photo as Data? {
        self.photo.image  = UIImage(data: photoData)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
