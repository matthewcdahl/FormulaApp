//
//  CardCell.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 8/11/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Setup the cell
    func configure(picture: UIImage, title: String){
        pictureView.image = picture
        titleLabel.text = title
    }
    
}
