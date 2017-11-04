//
//  User.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 15.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlbumsInfo {
    
    var albumPhoto: String
    var albumId: String
    var albumName: String
    var description: String
    var photoCount: String
    init(albumInfo: JSON) {
        self.albumPhoto = albumInfo["thumb_src"].stringValue
        self.albumId = albumInfo["id"].stringValue
        self.albumName = albumInfo["title"].stringValue
        self.description = albumInfo["description"].stringValue
        self.photoCount = albumInfo["size"].stringValue
        
    }
    
}

class PhotosInfo {
    var id: String
    var photoSmall: String
    var photoBig:String
    var likesCount: String
    var repostsCount: String
    var commentsCount: String
    var text: String
    var data:String
    init(photoInfo: JSON) {
        self.id = photoInfo["id"].stringValue
        self.photoSmall = photoInfo["photo_130"].stringValue
        
        self.photoBig = photoInfo["photo_604"].stringValue
        
        self.likesCount = photoInfo["likes"]["count"].stringValue
        self.repostsCount = photoInfo["reposts"]["count"].stringValue
        self.commentsCount = photoInfo["comments"]["count"].stringValue
        self.text = photoInfo["text"].stringValue
        self.data = photoInfo["date"].stringValue
    }
}

class User {
    static var user: User!
    let photo: String
    let ownerID: String
    let firstName: String
    let lastName: String
    let birthday: String
    init (userInfo: JSON) {
        self.ownerID = userInfo["response"][0]["id"].stringValue
        self.firstName = userInfo["response"][0]["first_name"].stringValue
        self.lastName = userInfo["response"][0]["last_name"].stringValue
        self.birthday = userInfo["response"][0]["bdate"].stringValue
        self.photo = userInfo["response"][0]["photo_100"].stringValue
        User.user = self
    }
    
}
