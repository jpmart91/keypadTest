//
//  ExampleViewController.swift
//  keypadTest
//
//  Created by KLabs on 11/30/17.
//  Copyright © 2017 KLabs. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    // Labels
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var shipper: UILabel!
    @IBOutlet weak var variety: UILabel!
    @IBOutlet weak var lotNumber: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var date: UILabel!
    
    // Variables
    var currentAmount : String = "0"
    var currentField : String = "qty"
    
    // Fields
    @IBOutlet weak var qty: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var total: UITextField!
    
    // Highlights
    @IBOutlet weak var highlightPrice: UIView!
    @IBOutlet weak var highlightQty: UIView!
    
    // Buttons
    @IBOutlet weak var addToOrder: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    // MARK: Enter Action
    @IBAction func enterAction(_ sender: Any) {
        
        if currentField == "qty" {
            selectPrice()
        } else {
            selectQty()
        }
    }
    
    @IBAction func deleteValue(_ sender: Any) {
        
        switch currentField {
            
        case "qty":
            
            // Delete
            if !(qty.text?.isEmpty)! {
                if let input : String = qty.text {
                    qty.text = input.substring(to: input.index(before: input.endIndex))
                    performCalculation()
                }
            }
            
        case "price":
            
            // Delete
            if !(price.text?.isEmpty)! {
                if let input : String = price.text {
                    price.text = input.substring(to: input.index(before: input.endIndex))
                    performCalculation()
                }
            }
            
        default:
            break
        }
    }
    
    // Number Button Action
    @IBAction func numberButton(_ sender: UIButton) {
        
        switch currentField {
        case "qty":
            
            // Numbers
            if qty.text == "0" || qty.text == "" {
                qty.text = sender.titleLabel?.text
            } else {
                qty.text = qty.text! + (sender.titleLabel?.text)!
            }
            
        case "price":
            
            // Numbers
            if price.text == "0.00" || price.text == "" {
                price.text = (sender.titleLabel?.text)!
            } else {
                // price.text = toCurrency(price.text! + (sender.titleLabel?.text)!)
                price.text = price.text! + (sender.titleLabel?.text)!
            }
            
        default:
            break
        }
        
        // Perform Calculation
        performCalculation()
        
        // Clear - Clears all fields
        if sender.titleLabel?.text == "CLR" {
            qty.text = ""
            qty.placeholder = "0"
            price.text = ""
            price.placeholder = "0.00"
            performCalculation()
        }
    }
   
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: Enter Action
    func selectQty() {
        currentField = "qty"
        UIView.animate(withDuration: 0.25, animations: {
            self.highlightPrice.alpha = 0.0
            self.highlightQty.alpha = 1.0
        }, completion:nil)
    }
    
    func selectPrice() {
        currentField = "price"
        UIView.animate(withDuration: 0.25, animations: {
            self.highlightPrice.alpha = 1.0
            self.highlightQty.alpha = 0.0
        }, completion:nil)
    }
    
    func performCalculation() {
        
        // Perform Calculation
        let calculation = (qty.text! as NSString).doubleValue * (price.text! as NSString).doubleValue as NSNumber
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        let totalString = currencyFormatter.string(from: calculation)
        
        print(totalString!)
        self.total.text = totalString
    }
    
    func toCurrency(_ string : String) -> String {
        
        var number : NSNumber = 0
        if let value = Double(string) {
            number = NSNumber(value:value)
        }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        let currencyString = currencyFormatter.string(from: number)
        
        return currencyString!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
