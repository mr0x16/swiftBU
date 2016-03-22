//
//  ContainerViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/2/5.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController {
    var hasMovedGreaterThanHalfWay:Bool = true
    var leftViewController : SidePanelViewController?
    var centerNavigationController : UINavigationController!
    var centerViewController : ViewController!
    var tempLeft:SidePanelViewController?
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    var currentState: SlideOutState = .BothCollapsed {
        didSet{
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    let centerPanelExpandedOffset: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = ViewController()
        centerViewController.delegateView = self
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognier = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognier)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        //        self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ContainerViewController: ViewControllerDelegate{
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels(){
        if currentState != .BothCollapsed{
            toggleLeftPanel()
        }
    }
    
    func addLeftPanelViewController(){
        if(leftViewController == nil){
            if(tempLeft != nil) {
                leftViewController = tempLeft
            } else {
                leftViewController = SidePanelViewController(center: self)
            }
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController){
        sidePanelController.delegateView = centerViewController
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(shouldExpand shouldExpand: Bool){

        
        if(shouldExpand){
            currentState = .LeftPanelExpanded
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                self.leftViewController!.removeFromParentViewController()
                self.tempLeft = self.leftViewController
                self.leftViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition (targetPosition targetPosition:CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool){
        if(shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate{
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureISDraggingFormLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        //在中央视图向左滑时没有反应
        let isMove = (self.leftViewController != nil) || (gestureISDraggingFormLeftToRight && self.leftViewController == nil)
        if !isMove  {
            return
        }
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed){
                if (gestureISDraggingFormLeftToRight) {
                    addLeftPanelViewController()
                }
            }

        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if(gestureISDraggingFormLeftToRight){
                hasMovedGreaterThanHalfWay = recognizer.view!.center.x > 2*(view.bounds.size.width)/3
            } else {
                hasMovedGreaterThanHalfWay = recognizer.view!.center.x > view.bounds.size.width
            }
            animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfWay)
        default:
            break
        }
    }
}

//private extension UIStoryboard {
////    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
//    
//    class func leftViewController() -> SidePanelViewController? {
//        let view = SidePanelViewController()
//        return view
//    }
//    
//    class func centerViewController() -> ViewController? {
//        let view = ViewController()
//        return view
//    }
//    
//}