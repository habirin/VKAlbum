//
//  PhotoCollectionViewController.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 24.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"
var photosArray = [PhotosInfo]()

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewWillAppear(_ animated: Bool) {
        
        photosArray.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServerManager.myServerManager.doRequest(serverRequest: ServerRequest.getPhotosInfo, completitionHandler: { (response) in
            
            for photo in response["response"]["items"].arrayValue {
                var photo = PhotosInfo.init(photoInfo: photo)
                photosArray.append(photo)
                
                
            }
            photosArray = photosArray.reversed()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.collectionView?.reloadData()
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 20) / 3
        return CGSize(width: size, height: size)
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        PhotoViewController.numberOfImageSelect = indexPath.row
        
        performSegue(withIdentifier: "PhotoViewControllerSegue", sender: self)
        
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
        
        return photosArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.likes.text = "❤️ \(photosArray[indexPath.row].likesCount)"
        cell.comments.text = "✏️ \(photosArray[indexPath.row].commentsCount)"
        cell.reposts.text = "📌 \(photosArray[indexPath.row].repostsCount)"
        let imageUrl = URL(string: photosArray[indexPath.row].photoSmall)
        let imageData = try? Data(contentsOf: imageUrl!)
        if  imageData != nil {
            cell.photoImage.image = UIImage(data: imageData!)
            return cell
        }
        else {
            let erroreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
            return erroreCell
        }
        
        // Configure the cell
        
        
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
