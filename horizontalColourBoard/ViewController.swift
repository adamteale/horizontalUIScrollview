//
//  ViewController.swift
//  horizontalColourBoard
//
//  Created by Adam Teale on 9/7/18.
//  Copyright © 2018 Adam Teale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var keyViews = [UIView]()
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyViews()
    }

    func setupKeyViews(){
        
        keyViews.append(scrollView)
        
        //Total subviews
        let total = 20
        for index in 0...total {

            let previousView = keyViews.last
            
            // RANDOM UICOLOUR as UIIMAGE
            
            let anImage = UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
                                  green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
                                  blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
                                  alpha: 1.0).image(CGSize(width: 128, height: 128))
            
            let aView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: view.bounds.height))
            aView.image = anImage
            aView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.addSubview(aView)
            keyViews.append(aView)

            // CONSTRAINTS
            
            let topConstraint = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: aView, attribute: .top, multiplier: 1.0, constant: 0)
            let heightConstraint = NSLayoutConstraint(item: aView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
            let leadingConstraint : NSLayoutConstraint!
            if index == 0 {
                leadingConstraint = NSLayoutConstraint(item: aView, attribute: .leading, relatedBy: .equal, toItem: previousView, attribute: .leading, multiplier: 1.0, constant: 0)
            }
            else {
                leadingConstraint = NSLayoutConstraint(item: aView, attribute: .leading, relatedBy: .equal, toItem: previousView, attribute: .trailing, multiplier: 1.0, constant: 0)
            }
            
            // Constraint of last subview to the scrollview
            if index == total {
                let trailingConstraint = NSLayoutConstraint(item: aView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing , multiplier: 1.0, constant: 8)
                trailingConstraint.priority = .defaultLow
                view.addConstraint(trailingConstraint)
            }
            
            view.addConstraints([
                leadingConstraint,
                heightConstraint,
                topConstraint
            ])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
}


