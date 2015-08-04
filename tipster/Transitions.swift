//
//  Transitions.swift
//  tipster
//
//  Created by MacBKPro on 8/3/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//
/* ref: https://www.andrewcbancroft.com/2014/09/24/slide-in-animation-in-swift/ */
//    https://www.youtube.com/watch?v=4WC4Hmn0ML0

import UIKit


extension UIView {
    
    // kCATransitionPush
    func pushFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionPush, kCATransitionFromRight, duration, completionDelegate), forKey: "pushFromRightTransition")
    }
    
    func pushFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionPush, kCATransitionFromLeft, duration, completionDelegate), forKey: "pushFromLeftTransition")
    }
    
    func pushFromTop(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionPush, kCATransitionFromBottom , duration, completionDelegate), forKey: "pushFromTopTransition")
    }
    
    func pushFromBottom(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionPush, kCATransitionFromTop, duration, completionDelegate), forKey: "pushFromBottomTransition")
    }
    
    // kCATransitionMoveIn
    func moveInFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionMoveIn, kCATransitionFromRight, duration, completionDelegate), forKey: "moveInFromRightTransition")
    }
    
    func moveInFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionMoveIn, kCATransitionFromLeft, duration, completionDelegate), forKey: "moveInFromLeftTransition")
    }
    
    func moveInFromBottom(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionMoveIn, kCATransitionFromTop, duration, completionDelegate), forKey: "moveInFromBottomTransition")
    }
    
    func moveInFromTop(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionMoveIn, kCATransitionFromBottom, duration, completionDelegate), forKey: "moveInFromTopTransition")
    }
    
    // kCATransitionReveal
    func revealFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionReveal, kCATransitionFromRight, duration, completionDelegate), forKey: "revealFromRightTransition")
    }
    
    func revealFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionReveal, kCATransitionFromLeft, duration, completionDelegate), forKey: "revealFromLeftTransition")
    }
    
    func revealFromBottom(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionReveal, kCATransitionFromTop, duration, completionDelegate), forKey: "revealFromBottomTransition")
    }
    
    func revealFromTop(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        self.layer.addAnimation(helpToMakeFuncUIViewTransition(kCATransitionReveal, kCATransitionFromBottom, duration, completionDelegate), forKey: "revealFromTopTransition")
    }
    
    // Usage: insert view.fadeTransition right before changing content
    func fadeTransition(duration:CFTimeInterval) {
        let transition:CATransition = CATransition()
        
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.duration = duration
        
        self.layer.addAnimation(transition, forKey: kCATransitionFade)
    }
    
    // UIViewAnimationTransition
    func curlDown(animationTime: Float){
        helpToMakeFuncUIViewTransitionWithUIViewAnimationTransition(self, animationTime, UIViewAnimationTransition.CurlDown)
    }
    
    func curlUp(animationTime: Float){
        helpToMakeFuncUIViewTransitionWithUIViewAnimationTransition(self, animationTime, UIViewAnimationTransition.CurlUp)
    }
    
    func flipFromLeft(animationTime: Float){
        helpToMakeFuncUIViewTransitionWithUIViewAnimationTransition(self, animationTime, UIViewAnimationTransition.FlipFromLeft)
    }
    
    func flipFromRight(animationTime: Float){
        helpToMakeFuncUIViewTransitionWithUIViewAnimationTransition(self, animationTime, UIViewAnimationTransition.FlipFromRight)
    }
    
}

func helpToMakeFuncUIViewTransition(type: String, subtype: String, duration: NSTimeInterval, completionDelegate: AnyObject?) -> CATransition{
    // Create a CATransition animation
    let transition = CATransition()
    
    // Set its callback delegate to the completionDelegate that was provided (if any)
    if let delegate: AnyObject = completionDelegate {
        transition.delegate = delegate
    }
    
    // Customize the animation's properties
    transition.type = type
    transition.subtype = subtype
    transition.duration = duration
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.fillMode = kCAFillModeRemoved
    
    return transition
}

func helpToMakeFuncUIViewTransitionWithUIViewAnimationTransition(view: UIView, animationTime: Float, transition: UIViewAnimationTransition){
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
    UIView.setAnimationDuration(NSTimeInterval(animationTime))
    UIView.setAnimationTransition(transition, forView: view, cache: false)
    UIView.commitAnimations()
}















