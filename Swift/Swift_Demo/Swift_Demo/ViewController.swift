//
//  ViewController.swift
//  Swift_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FLCarouselViewDataSource ,FLCarouselViewDelegate,UIViewControllerTransitioningDelegate{
    
    var arr : NSArray = ["1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3"]
    
    let transitionController = FLSlideInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "first vc"
        let carousel = FLCarouselView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 300))
        carousel.dataSource = self
        carousel.delegate = self
        carousel.fl_scrollTimeInterval = 4.0
        view.addSubview(carousel)
        carousel.fl_reloadData()
    }
    
    func numberOfItems(carousel: FLCarouselView) -> Int {
        return arr.count
    }
    
    func carouselView(collection: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, reuseId: String) -> FLCarouselCell {
        let cell = collection.dequeueReusableCellWithReuseIdentifier(reuseId, forIndexPath: indexPath) as! FLCarouselCell
        cell.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(256)) / 255.0), green: CGFloat(Double(arc4random_uniform(256)) / 255.0), blue: CGFloat(Double(arc4random_uniform(256)) / 255.0), alpha: 1.0)
        return cell
    }
    
    func carouselView(collectionView: UICollectionView, didSelectItemAtIndexPath index: NSInteger) {
        let toVc = SecondViewController()
//        toVc.transitioningDelegate = self
//        toVc.delegate = self
//        transitionController.writeToViewController(toVc)
        self.presentViewController(toVc, animated: true, completion: nil)
        
//        let nav = UINavigationController.init(rootViewController: toVc)
//        presentViewController(nav, animated: true, completion: nil)
        print(index)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FLBouncePresentAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FLNormalDismissAnimation()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionController.interacting ? transitionController : nil
    }
}

extension ViewController : FLDismissDelegate{
    func clickToDismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

