//
//  PhotoViewController.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 25.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit
var photoInfo: PhotosInfo!

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet var photoScrollView: UIScrollView!
    
    static var numberOfImageSelect: Int!
    func changePhotoWithAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.photoImage.alpha = 0
            
            self.photoImage.image = ServerManager.getImage(stringImage: photosArray[PhotoViewController.numberOfImageSelect].photoBig)
            self.photoImage.alpha = 1
            
        })
        
    }
    func swipePhoto(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                
                
                
                if PhotoViewController.numberOfImageSelect < photosArray.count - 1 {
                    PhotoViewController.numberOfImageSelect = PhotoViewController.numberOfImageSelect + 1
                    changePhotoWithAnimation()
                    
                    
                }
            case UISwipeGestureRecognizerDirection.right:
                if PhotoViewController.numberOfImageSelect > 0 {
                    PhotoViewController.numberOfImageSelect = PhotoViewController.numberOfImageSelect - 1
                    changePhotoWithAnimation()
                }
                
            default: break
            }}}
    
    func doubleTap() {
        if (photoScrollView.zoomScale > photoScrollView.minimumZoomScale) {
            photoScrollView.setZoomScale(photoScrollView.minimumZoomScale, animated: true)
        } else {
            photoScrollView.setZoomScale(photoScrollView.maximumZoomScale, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(PhotoViewController.swipePhoto(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.photoScrollView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(PhotoViewController.swipePhoto(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left;
        self.photoScrollView.addGestureRecognizer(swipeLeft)
        
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
        tap.addTarget(self, action: #selector(PhotoViewController.doubleTap))
        self.view.addGestureRecognizer(tap)
        photoImage.image = ServerManager.getImage(stringImage: photosArray[PhotoViewController.numberOfImageSelect].photoBig)
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
        // Do any additional setup after loading the view.
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
