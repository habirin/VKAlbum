//
//  PhotoCollectionViewCell.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 24.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit


class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var reposts: UILabel!
}
