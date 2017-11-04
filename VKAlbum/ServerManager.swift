//
//  ServerManager.swift
//  VKapp
//
//  Created by Ринат Хабибуллин on 07.08.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Alamofire
import SwiftyJSON


struct ServerRequest {
    static var albumSelected: Int!
    static var getUserInfo: String { return "users.get?&fields=bdate,photo_100"}
    static var getAlbumsInfo: String { return "photos.getAlbums?&need_system=1&need_covers=1&owner_id=\(User.user.ownerID)"}
    static var getPhotosInfo: String {return "photos.get?&owner_id=\(User.user.ownerID)&album_id=\(albums[ServerRequest.albumSelected].albumId)&extended=1"}
}
class ServerManager {
    static var myServerManager = ServerManager()
    func doRequest(serverRequest: String, completitionHandler: @escaping (_ response: JSON) -> ())  {
        
        request("https://api.vk.com/method/\(serverRequest)&access_token=\(LoginViewController.accessToken!)&v=5.68").responseJSON  { (response) in
            
            completitionHandler(JSON(response.value))
        }
    }
    static func getImage(stringImage: String) -> (UIImage) {
        
        let imageUrl = URL(string: stringImage)
        if let imageData = try? Data(contentsOf: imageUrl!) {
            return UIImage(data: imageData)!
        }
        else {
            return UIImage(named: "noImage")!
        }
    }
}
