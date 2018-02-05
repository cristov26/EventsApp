//
//  LoaderView.swift
//  excalibur
//
//  Created by Cristian Tovar on 11/16/17.
//  Copyright © 2017 rccl. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    static let sharedInstance = LoaderView.initFromNib()
    
    static var loaderView: UIView?
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView?
    
    private class func initFromNib() -> LoaderView {
        
        let nibFile = UINib(nibName: "LoaderView", bundle: nil)
        let view: LoaderView = nibFile.instantiate(withOwner: self, options: nil).first as! LoaderView
        
        return view
    }
    
    class func show(view: UIView){
        loaderView = view
        
        let loader = LoaderView.sharedInstance
        loader.frame = view.frame
        
        if loader.superview == nil {
            
            loaderView!.addSubview(loader)
        } else {
            
            loader.superview?.bringSubview(toFront: loader)
        }
    }
    
    class func dismiss(){
        
        let loader:LoaderView = LoaderView.sharedInstance
        
        UIView.animate(withDuration: 0.4, animations: {
            loader.alpha = 0
        }) { (completed) in
            loader.removeFromSuperview()
        }
    }
}
