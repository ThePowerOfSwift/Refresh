//
//  TableViewController.swift
//  Refresh
//
//  Created by  lifirewolf on 16/3/3.
//  Copyright © 2016年  lifirewolf. All rights reserved.
//

import UIKit

class TestController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hv = UIView()
        hv.backgroundColor = UIColor.redColor()
        self.tableView.addSubview(hv)
        
        let fv = UIView()
        fv.backgroundColor = UIColor.blueColor()
        self.tableView.addSubview(fv)

        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        
        let contentView = self.tableView.subviews.first!
        
        for v in self.tableView.subviews {
            fv.translatesAutoresizingMaskIntoConstraints = false
            print(v)
        }
        tableView.removeConstraints(tableView.constraints)
        
        let c10 = NSLayoutConstraint(item: hv, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 100)
        hv.addConstraint(c10)
        
        let c11 = NSLayoutConstraint(item: fv, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 100)
        fv.addConstraint(c11)
        
        let c1 = NSLayoutConstraint(item: hv, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: hv, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: hv, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        tableView.addConstraints([c1, c2, c3])
        
        let c4 = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let c5 = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let c6 = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: hv, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        tableView.addConstraints([c4, c5, c6])
        
        let c7 = NSLayoutConstraint(item: fv, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let c8 = NSLayoutConstraint(item: fv, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: tableView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let c9 = NSLayoutConstraint(item: fv, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        tableView.addConstraints([c7, c8, c9])
        
        
        animation1()
        
        
//        var list = [213, 345, 1, 3, 89]
//        list.sortInPlace({ a, b in
//            return a > b
//        })
//        print(list)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func animation1() {
        
        let r = CAReplicatorLayer()
        r.bounds = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        r.position = view.center
        r.backgroundColor = UIColor.lightGrayColor().CGColor
        view.layer.addSublayer(r)
        
        let bar = CALayer()
        bar.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 8.0)
//        bar.position = CGPoint(x: 10.0, y: 75.0)
        bar.cornerRadius = 2.0
        bar.backgroundColor = UIColor.redColor().CGColor
        
        r.addSublayer(bar)
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y + 52.0
        move.duration = 1
        move.autoreverses = true
        move.repeatCount = Float.infinity
        
        bar.addAnimation(move, forKey: nil)
        
//        r.instanceCount = 3
//        r.instanceDelay = 0.33
//        r.instanceTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
        
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.5
        pulseAnimation.fromValue = NSNumber(float: 0.5)
        pulseAnimation.toValue = NSNumber(float: 1.0)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        bar.addAnimation(pulseAnimation, forKey: nil)
        
        r.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let ty = self.tableView.bounds.origin.y
        print("\(ty)\t\(ty + self.tableView.bounds.height)\t\(self.tableView.contentSize.height)\t\(self.tableView.contentOffset.y)")
        
//        if ty < 0 {
//
//            let h = min(max(0.0, -ty), 100)
//            self.tableView.tableHeaderView?.frame.origin = CGPoint(x: 0, y: ty)
//            self.tableView.tableHeaderView?.bounds.size = CGSize(width: self.view.bounds.width, height: h)
//            
//        } else if ty + self.tableView.bounds.height > self.tableView.contentSize.height {
//            
//            let h: CGFloat = min(ty + self.tableView.bounds.height - self.tableView.contentSize.height, 100)
//            self.tableView.tableFooterView?.bounds.size = CGSize(width: self.view.bounds.width, height: h)
//            let y:CGFloat = self.tableView.tableFooterView!.frame.origin.y
//            self.tableView.tableFooterView?.frame.origin = CGPoint(x: 0, y: y + h)
//        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        
        // Configure the cell...
        cell!.textLabel!.text = "Row \(indexPath.row)"
        
        return cell!
    }
    
}

