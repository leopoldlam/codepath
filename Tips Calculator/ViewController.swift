//
//  ViewController.swift
//  Tips Calculator
//
//  Created by Leo Lam on 2/19/15.
//  Copyright (c) 2015 KML. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultPercentages = [Double]()
        var predefinedDefaultPercentages = [ 0.15, 0.18, 0.20 ]
        if let tempDefaultPercentages = defaults.arrayForKey("defaultPercentages")
        {
            for object in tempDefaultPercentages
            {
                defaultPercentages.append( object as Double)
                
            }
        }
        else
        {
            println("no defaults found")
            defaultPercentages = predefinedDefaultPercentages  ;
        }
        
        defaults.setObject(defaultPercentages, forKey: "defaultPercentages")
        var temp = defaultPercentages[0] * 100
        tipControl.setTitle(String(format:"%.0f%%", temp),forSegmentAtIndex: 0)
        temp = defaultPercentages[1] * 100
        tipControl.setTitle(String(format:"%.0f%%", temp), forSegmentAtIndex:1)
        temp = defaultPercentages[2] * 100
        tipControl.setTitle(String(format:"%.0f%%", temp), forSegmentAtIndex:2)
        
        
        var _defaultSelection: AnyObject?  = defaults.objectForKey("defaultSelection")
        
        var defaultSelection = 0;
        if (_defaultSelection != nil) {
            if (_defaultSelection as NSInteger) < 3 {
                defaultSelection = _defaultSelection as NSInteger
                tipControl.selectedSegmentIndex = defaultSelection
            }
            
            println("Selection is "+String(format:"%d", defaultSelection))
        }
        defaults.setObject(tipControl.selectedSegmentIndex, forKey: "defaultSelection")
        

        
        
        
        println("view will appear")
        
        defaults.synchronize()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("view did appear")
        var billAmount = billAmountField.text._bridgeToObjectiveC().doubleValue
        let _tipTitle : String = tipControl.titleForSegmentAtIndex(tipControl.selectedSegmentIndex)!
        let tipTitle = _tipTitle.substringToIndex(_tipTitle.endIndex.predecessor())
        var tipPercent  = NSNumberFormatter().numberFromString(tipTitle)!.doubleValue / 100
        var tip = billAmount * tipPercent
        var totalAmount = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", totalAmount)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        

        
        println("view did disappear")
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
 
        var billAmount = billAmountField.text._bridgeToObjectiveC().doubleValue
        let _tipTitle : String = tipControl.titleForSegmentAtIndex(tipControl.selectedSegmentIndex)!
        let tipTitle = _tipTitle.substringToIndex(_tipTitle.endIndex.predecessor())
        var tipPercent  = NSNumberFormatter().numberFromString(tipTitle)!.doubleValue / 100
        var tip = billAmount * tipPercent
        var totalAmount = billAmount + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", totalAmount)
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

