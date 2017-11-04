//
//  AlbumCollectionViewController.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 14.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"
var albums = [AlbumsInfo]()

class AlbumCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewWillAppear(_ animated: Bool) {
        albums.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServerManager.myServerManager.doRequest(serverRequest: ServerRequest.getAlbumsInfo, completitionHandler: { (response) in
            AlbumsInfo.init(albumInfo: response)
            for album in response["response"]["items"].arrayValue {
                let album = AlbumsInfo.init(albumInfo: album)
                albums.append(album)
            }
            MBProgressHUD.hide(for: self.view, animated: true)
            self.collectionView?.reloadData()
            
        })
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 20) / 3
        return CGSize(width: size, height: size)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return albums.count
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderAlbumCollectionReusableView", for: indexPath) as! HeaderAlbumCollectionReusableView
        header.userImage.image = ServerManager.getImage(stringImage: User.user.photo)
        
        header.userName.text = User.user.firstName + " " + User.user.lastName
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.albumImage.image = ServerManager.getImage(stringImage: albums[indexPath.row].albumPhoto)
        cell.albumName.text = albums[indexPath.row].albumName
        cell.numberOfPhotos.text = albums[indexPath.row].photoCount
        // Configure the cell
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ServerRequest.albumSelected = indexPath.row
        
        performSegue(withIdentifier: "PhotoCollectionViewSegue", sender: self)
        
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
