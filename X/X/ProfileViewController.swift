//
//  ProfileViewController.swift
//  X
//
//  Created by yue zheng on 12/18/14.
//  Copyright (c) 2014 PPC. All rights reserved.
//

import UIKit

class ProfileViewController: BackgroundViewController, DBCameraViewControllerDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100

        // Do any additional setup after loading the view.
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as ProfileTableViewCell
            cell.verifyBtn.layer.cornerRadius = 20
            cell.verifyBtn.layer.frame = CGRectInset(cell.verifyBtn.frame, 20, 20)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecordCell") as RecordTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingCell") as SettingTableViewCell
            
            if indexPath.row == 2 {
                cell.nameImageView.image = UIImage(named: "Icon_Settings@2x.png")
                cell.nameLabel.text = "Settings"
            } else if indexPath.row == 3 {
                cell.nameImageView.image = UIImage(named: "Icon_About@2x.png")
                cell.nameLabel.text = "About"
            }
            return cell
        }
        
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func changeSchoolClicked(sender: AnyObject) {
    }
    

    @IBAction func verifySchoolClicked(sender: AnyObject) {
    }
    
    @IBAction func avatarClicked(sender: UITapGestureRecognizer) {
        let cameraController = DBCameraViewController.initWithDelegate(self)
        let container = DBCameraContainerViewController(delegate: self)
        container.setFullScreenMode()
        
        let nav = UINavigationController(rootViewController: container)
        nav.setNavigationBarHidden(true, animated: true)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func changeBGClicked(sender: AnyObject) {
        
        let cameraController = DBCameraViewController.initWithDelegate(self)
        let container = DBCameraContainerViewController(delegate: self)
        container.setFullScreenMode()
        let nav = UINavigationController(rootViewController: container)
        nav.setNavigationBarHidden(true, animated: true)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    

    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        // change background image to image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
