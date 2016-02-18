//
//  KYAnimationView.swift
//  KYCADisplayLinkDemo
//
//  Created by KangYang on 16/2/18.
//  Copyright © 2016年 KangYang. All rights reserved.
//

import UIKit

class KYAnimationView: UIView {
    
    private var displayLink: CADisplayLink?
    private var from: CGFloat = 0
    private var to: CGFloat = 0
    private var animation: Bool = false
    
    func startAnimationFrom(from: CGFloat, to: CGFloat) {
        self.from = from;
        self.to = to;
        self.animation = true;
        
        if (self.displayLink == nil) {
            self.displayLink = CADisplayLink(target: self, selector: Selector("tick:"));
            self.displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode);
        }
    }
    
    func completeAnimation() {
        self.animation = false;
        self.displayLink?.invalidate();
        self.displayLink = nil;
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let layer = self.layer.presentationLayer();
        var progress: CGFloat = 1;
        if (self.animation == false) {
            progress = 1;
        } else {
            progress = 1 - ((layer?.position.y)! - self.to) / (self.from - self.to);
        }
        
        let height = CGRectGetHeight(rect);
        let deltaHeight = height / 2 * (0.5 - fabs(progress - 0.5));
        print(deltaHeight);
        
        let topLeft = CGPoint(x: 0, y: deltaHeight);
        let topRight = CGPoint(x: CGRectGetWidth(rect), y: deltaHeight);
        let bottomLeft = CGPoint(x: 0, y: height);
        let bottomRight = CGPoint(x: CGRectGetWidth(rect), y: height);
        
        let path: UIBezierPath = UIBezierPath();
        UIColor.blueColor().setFill();
        path.moveToPoint(topLeft);
        path.addQuadCurveToPoint(topRight, controlPoint: CGPoint(x: CGRectGetMidX(rect), y: 0));
        path.addLineToPoint(bottomRight);
        path.addQuadCurveToPoint(bottomLeft, controlPoint: CGPoint(x: CGRectGetMidX(rect), y: height - deltaHeight));
        path.closePath();
        path.fill();
    }
    
    func tick(sender: CADisplayLink) {
        self.setNeedsDisplay();
    }
}
