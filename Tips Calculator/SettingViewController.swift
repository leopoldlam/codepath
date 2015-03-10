//
//  SettingViewController.swift
//  Tips Calculator
//
//  Created by Leo Lam on 2/24/15.
//  Copyright (c) 2015 KML. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var tipOnefield: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        println("setting view did load")
        var defaults = NSUserDefaults.standardUserDefaults()
        
        
        
        
        if let tempDefaultPercentages = defaults.arrayForKey("defaultPercentages")
        {
            var count = 0;
            
            for object in tempDefaultPercentages
            {
                var temp = (object as Double) * 100
                tipControl.setTitle(String(format:"%.0f%%", temp), forSegmentAtIndex: count)
                println(String(format:"%.0f%", temp))
                
                if (count == 0){
                    
                    tipOnefield.text = String(format:"%.0f", temp);
                }
                
                count++
                
            }
            
        }
        
        let defaultSelection = defaults.objectForKey("defaultSelection") as NSInteger
        tipControl.selectedSegmentIndex = defaultSelection
        let tipIndex = tipControl.selectedSegmentIndex
        let _tipTitle : String = tipControl.titleForSegmentAtIndex(tipIndex)!
        let tipTitle = _tipTitle.substringToIndex(_tipTitle.endIndex.predecessor())
        
        tipOnefield.text = tipTitle;
        

   
        
        // Do any additional setup after loading the view.
    }

    @IBAction func OnTipTouchDownRepeat(sender: AnyObject) {
        println("touchdown")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("setting view will appear")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tipOnefield.selectAll(nil)
        tipOnefield.becomeFirstResponder()
        println("setting view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("setting view will disappear")
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultPercentages = [Double]()
        

        
        if let tempDefaultPercentages = defaults.arrayForKey("defaultPercentages")
        {
            var count = 0;
            
            for object in tempDefaultPercentages
            {
                let _tipTitle : String = tipControl.titleForSegmentAtIndex(count)!
                let tipTitle = _tipTitle.substringToIndex(_tipTitle.endIndex.predecessor())
                
                if tipTitle.isEmpty{
                    defaultPercentages.append(object as Double)
                }
                else{

                    defaultPercentages.append(tipTitle._bridgeToObjectiveC().doubleValue / 100)
                }
                count++
            }
            defaults.setObject(defaultPercentages, forKey: "defaultPercentages")
            
            defaults.synchronize()
            
        }
        
        defaults.setObject(tipControl.selectedSegmentIndex, forKey: "defaultSelection")
 
        println( String(tipControl.selectedSegmentIndex))
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        

        
        println("setting view did disappear")
    }

    @IBAction func OnDefaultChanged(sender: AnyObject) {

        let tipIndex = tipControl.selectedSegmentIndex
        tipControl.setTitle(tipOnefield.text + "%", forSegmentAtIndex: tipIndex)
        
    }
    @IBAction func OnDoneButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func OnTipSelectionChanged(sender: UISegmentedControl) {
        let tipIndex = tipControl.selectedSegmentIndex
        let _tipTitle : String = tipControl.titleForSegmentAtIndex(tipIndex)!
        let tipTitle = _tipTitle.substringToIndex(_tipTitle.endIndex.predecessor())

        tipOnefield.text = tipTitle;
        tipOnefield.selectAll(nil)
        tipOnefield.becomeFirstResponder()
   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
