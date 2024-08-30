//
//  TakeATourController.swift
//  AQAR55
//
//  Created by lion on 27/02/19.
//  Copyright © 2019 lion. All rights reserved.
//

import UIKit

class TakeTourController: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var collectionView       :   UICollectionView!
    @IBOutlet weak var pageControllerRef    :   UIPageControl!
    
    @IBOutlet weak var btnNextObj: UIButton!
    
    @IBOutlet weak var skipBtnObj: UIButton!
    
    //MARK: - Variables
    let imageArray = [#imageLiteral(resourceName: "register_1"),#imageLiteral(resourceName: "image_second"),#imageLiteral(resourceName: "image_third"),#imageLiteral(resourceName: "image_four")]

    //MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    
    
    
    @IBAction func btn_SkipTapped(_ sender: Any) {
        let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(login_VC, animated: true)
    }
    
    
    @IBAction func btnNextAction(_ sender: Any) {
        let cellWidth = collectionView.visibleCells[0].bounds.size.width
        let contentOffset = Float(floor(collectionView.contentOffset.x + cellWidth))
        moveCollectionView(toFrame: CGFloat(contentOffset))
        let pageWidth:CGFloat = collectionView.frame.width
        let indexOfcurrentPage:CGFloat = floor((collectionView.contentOffset.x-pageWidth/2)/pageWidth)+1
        let currentPage = indexOfcurrentPage + 1.0
        if currentPage == 4{
            print("Aage bhej do")
            //btnNextObj.imageView?.image = UIImage.image
            let login_VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(login_VC, animated: true)
        }
        else if currentPage<3{
            btnNextObj.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
            btnNextObj.setTitle("", for: UIControl.State.normal)
            skipBtnObj.isHidden = false
        }
        else if currentPage == 3{
             btnNextObj.setTitle("Done", for: UIControl.State.normal)
             btnNextObj.setImage(UIImage(named: "redTap")?.withRenderingMode(.alwaysOriginal), for: .normal)
            skipBtnObj.isHidden = true
         }
        else{
            btnNextObj.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
            skipBtnObj.isHidden = false
            print(currentPage)
        }
    }
}

//MARK: - User Defined Methods
extension TakeTourController{
    func initialSetup(){
    }
    
    func moveCollectionView(toFrame contentOffset: CGFloat) {
        let frame = CGRect(x: contentOffset, y: collectionView.contentOffset.y, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        collectionView.scrollRectToVisible(frame, animated: true)
        
    }
}

//MARK: - CollectionView dataSource and delegates
extension TakeTourController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //TODO: Number of section in collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imageArray.count
    }
    
    
    //TODO: Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    //TODO: Cell for item at indexPath
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "TakeATourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TakeATourCollectionViewCell")
        let collectionViewItem = collectionView.dequeueReusableCell(withReuseIdentifier: "TakeATourCollectionViewCell", for: indexPath) as! TakeATourCollectionViewCell
        print(indexPath.section)
 
        collectionViewItem.imageView.image = imageArray[indexPath.section]
        
        return collectionViewItem
    }
    
    //TODO: CollectionView flow layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height - 50)
    }
    
    //TODO: CollectionView willDisplay
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControllerRef.currentPage = indexPath.section
        if indexPath.section == 3 {
 
                btnNextObj.setTitle("Done", for: UIControl.State.normal)
                skipBtnObj.isHidden = true
                btnNextObj.setImage(UIImage(named: "")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            else{
                btnNextObj.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
                btnNextObj.setTitle("", for: UIControl.State.normal)
                skipBtnObj.isHidden = false
            }
        }
     }


//extension UIPageControl {
//    //TODO: Custom page controller
//    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
//        for (pageIndex, dotView) in self.subviews.enumerated() {
//            if self.currentPage == pageIndex {
//                dotView.backgroundColor = dotFillColor
//                dotView.layer.cornerRadius = dotView.frame.size.height / 2
//            }else{
//                dotView.backgroundColor = .clear
//                dotView.layer.cornerRadius = dotView.frame.size.height / 2
//                dotView.layer.borderColor = dotBorderColor.cgColor
//                dotView.layer.borderWidth = dotBorderWidth
//            }
//        }
//    }
//}
