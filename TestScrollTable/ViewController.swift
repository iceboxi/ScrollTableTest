//
//  ViewController.swift
//  TestScrollTable
//
//  Created by iceboxi on 2016/3/18.
//  Copyright © 2016年 iceboxi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBottomView: UIView!
    
    let image = UIImage(named: "header")
    
    let defaultCellIdentifier = "default cell"
    var initialHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        theTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initialHeight = CGRectGetWidth(view.bounds)
        theTableView.contentInset = UIEdgeInsetsMake(initialHeight, 0, 0, 0)
        theTableView.scrollIndicatorInsets = theTableView.contentInset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: - UITableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(defaultCellIdentifier)
        
        cell!.textLabel!.text = "row: \(indexPath.row+1)"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = max(-scrollView.contentOffset.y, 64+60)
        let width = max(CGRectGetWidth(view.bounds)-(initialHeight+scrollView.contentOffset.y), CGRectGetWidth(view.bounds))
        let x = min((initialHeight+scrollView.contentOffset.y)/2, 0)
        
        profileImageView.frame = CGRectMake(x, 0, width, height)
        
        headerBottomView.frame = CGRectMake(0, min(height, CGRectGetHeight(headerView.bounds))-50, CGRectGetWidth(view.bounds), 50)
        
        if initialHeight+scrollView.contentOffset.y > 1 {
            profileImageView.image = UIImageEffects.imageByApplyingCustomEffectToImage(image, withRadius: 10)
        } else {
            profileImageView.image = image
        }
    }
    
    @IBAction func testAction(sender: AnyObject) {
        print("btn press")
    }
}

