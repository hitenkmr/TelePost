//
//  UIView+Additions.swift
//  Soundify
//
//  Created by Hitender Kumar on 20/10/16.
//  Copyright © 2016 Hitender Kumar. All rights reserved.
//

import UIKit
import ObjectiveC

private struct AssociatedKeys {
    static var KeyIndexPath    = "IndexPath"
    static var KeyIdentifier   = "Identifier"
    static var KeyInfo         = "Info"
    static var KeyMarked       = "Marked"
}

extension UIView {
    
    var indexPath: IndexPath?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.KeyIndexPath) as? IndexPath
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.KeyIndexPath, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.KeyIndexPath, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var identifier : String?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.KeyIdentifier) as? String
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.KeyIdentifier, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.KeyIdentifier, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    var info : [String : Any]?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.KeyInfo) as? [String : Any]
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.KeyInfo, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.KeyInfo, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var marked : Bool?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.KeyMarked) as? Bool
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.KeyMarked, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.KeyMarked, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: Frame Setters
    
    func setOrigin(origin : CGPoint){
        var frame = self.frame
        frame.origin.x = origin.x
        frame.origin.y = origin.y
        self.frame = frame
    }
    
    func setXOrigin(xOrigin : CGFloat){
        var frame = self.frame
        frame.origin.x = xOrigin
        self.frame = frame
    }
    
    func setYOrigin(yOrigin : CGFloat){
        var frame = self.frame
        frame.origin.y = yOrigin
        self.frame = frame
    }
    
    func setWidth(width : CGFloat){
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height : CGFloat){
        var frame = self.frame
        frame.size.width = height
        self.frame = frame
    }
    
    // MARK: Frame Getters
    
    func getOrigin() -> CGPoint?{
        return self.frame.origin
    }
    
    func getXOrigin() -> CGFloat{
        return self.frame.origin.x
    }
    
    func getYOrigin() -> CGFloat{
        return self.frame.origin.y
    }
    
    func getWidth() -> CGFloat{
        return self.frame.size.width
    }
    
    func getHeight() -> CGFloat{
        return self.frame.size.height
    }
    
}

extension UILabel {
    
    func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

extension UIButton {
    
    func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

extension UIImageView {
    
    func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

