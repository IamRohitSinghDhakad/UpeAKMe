//
//  TableViewExtension.swift
///  Bang
//
//  Created by Rohit on 23/10/19.
//  Copyright © 2019 Rohit Singh All rights reserved.
//

import UIKit

extension UITableView {
    
    func displayBackgroundText(text: String, fontStyle: String, fontSize: CGFloat) {
        let lbl = UILabel();
        
        if let headerView = self.tableHeaderView {
            lbl.frame = CGRect(x: 0, y: headerView.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height - headerView.bounds.size.height)
        } else {
            lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        }
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:fontSize);
        //        lbl.sizeToFit();
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func displayBackgroundText(text: String, fontStyle: String) {
        let lbl = UILabel();
        
        if let headerView = self.tableHeaderView {
            lbl.frame = CGRect(x: 0, y: headerView.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height - headerView.bounds.size.height)
        } else {
            lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        }
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:18);
        //        lbl.sizeToFit();
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func displayBackgroundText(text: String) {
        let lbl = UILabel();
        
        if let headerView = self.tableHeaderView {
            lbl.frame = CGRect(x: 0, y: headerView.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height - headerView.bounds.size.height)
        } else {
            lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        }
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: "Helvetica", size:18);
        //lbl.sizeToFit();
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
}


extension UICollectionView {
    
    func displayBackgroundText(text: String, fontStyle: String, fontSize: CGFloat) {
        let lbl = UILabel();
        lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:fontSize);
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func displayBackgroundText(text: String, fontStyle: String) {
        let lbl = UILabel();
        lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:18);
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func displayBackgroundText(text: String) {
        let lbl = UILabel();
        lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: "Helvetica", size:18);
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
}

extension UITableViewCell {
    func shake123(duration: CFTimeInterval = 0.3, pathLength: CGFloat = 15) {
        let position: CGPoint = self.center
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: position.x, y: position.y))
        path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x+pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x+pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x, y: position.y))
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        
        positionAnimation.path = path.cgPath
        positionAnimation.duration = duration
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
    }
}

