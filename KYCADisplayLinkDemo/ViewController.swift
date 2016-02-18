//
//  ViewController.swift
//  KYCADisplayLinkDemo
//
//  Created by KangYang on 16/2/18.
//  Copyright © 2016年 KangYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: KYAnimationView!
    var animating: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonAction(sender: AnyObject) {
        if animating == true {
            return
        }
        animating = true;
        
        let from: CGFloat = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.animationView.bounds) / 2;
        let to: CGFloat = 100;
        
        animationView.center = CGPoint(x: animationView.center.x, y: from);
        
        animationView.startAnimationFrom(from, to: to);
        UIView.animateWithDuration(1,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0,
            options: UIViewAnimationOptions.LayoutSubviews,
            animations: { () -> Void in
                self.animationView.center = CGPoint(x: self.animationView.center.x, y: to);
            }) { (finished: Bool) -> Void in
                self.animationView.completeAnimation();
                self.animating = false;
        }
    }
}

