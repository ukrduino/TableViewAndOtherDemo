//
//  ViewController.swift
//  TableViewAndOtherDemo
//
//  Created by Romaniuk Sergey on 26.11.14.
//  Copyright (c) 2014 Romaniuk Sergey. All rights reserved.
//

import UIKit
                                        // 3
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    // 1
    @IBOutlet var tableView: UITableView! = UITableView()
    
    // 3
    var dataSource:NSMutableArray = NSMutableArray()
    var headerView:UIView = UIView()

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // 2 
        tableView.delegate = self
        tableView.dataSource = self
    // 5
        headerView.frame = CGRectMake(0, 0, 320	, 200)
        headerView.backgroundColor = UIColor.blackColor()
        tableView.tableHeaderView = headerView
        
    // 6
        var nameTextField:UITextField = UITextField(frame: CGRectMake(0, 0, 150, 45))
        nameTextField.center = headerView.center
        nameTextField.backgroundColor = UIColor.whiteColor()
        nameTextField.textAlignment = NSTextAlignment.Center
        nameTextField.placeholder = "Как тебя зовут?"
        nameTextField.delegate = self
        headerView.addSubview(nameTextField)
    }

// MARK:  UITableViewDataSource - protocol
    
    
    // 4
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
       
//      http://stackoverflow.com/questions/24022763/uitableview-in-swift
//      Let's find a solution without creating custom subclasses or nibs
        
//        The real problem is in the fact that Swift distinguishes between objects that can be empty (nil) and objects that can't be empty. If you don't register a nib for your identifier, then dequeueReusableCellWithIdentifier can return nil.
            
//      That means we have to declare the variable as optional:
        
//      var cell : UITableViewCell?
//      and we have to cast using as? not as
        
//      variable type is inferred
        var cell = tableView.dequeueReusableCellWithIdentifier("cellident") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellident")
        }
        
//      we know that cell is not empty now so we use ! to force unwrapping
        
        cell!.textLabel.text = "Привет \(dataSource.objectAtIndex(indexPath.row) as NSString)"
     
        
        return cell!
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    
        return 1
    }
    // 7
    func textFieldShouldReturn(textField: UITextField) -> Bool { // called when 'return' key pressed. return NO to ignore.
        textField.resignFirstResponder() // не понятный метод....
        dataSource.addObject(textField.text)
        tableView.reloadData()
        textField.text = ""
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//some examples :
//
//// MARK:
//-> will be preceded by a horizontal divider
//
//// MARK: your text goes here
//-> puts 'your text goes here' in bold in the drop down list
//
//// MARK: - your text goes here
//-> puts 'your text goes here' in bold in the drop down list, preceded by a horizontal divider