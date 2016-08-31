//
//  FourViewController.swift
//  Swift_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "four vc"    
        view.backgroundColor = UIColor.purpleColor()

        print(self.fl_transationStyle().rawValue)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        dismissViewControllerAnimated(true, completion: nil)
        self.fl_dismissToTop()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
