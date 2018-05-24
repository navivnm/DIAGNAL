//
//  CollectionViewCell.swift
//  Entertainment
//
//  Created by Naveen Vijay on 23/05/18.
//  Copyright © 2018 Naveen Vijay. All rights reserved.
//

import UIKit

class  CollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    func funcDisplayCollection(image: UIImage, title: String)
    {
        imageDisplay.image = image
        
        labelText.text = title
        labelText.sizeToFit()
        labelText.adjustsFontSizeToFitWidth = true
    }
}
