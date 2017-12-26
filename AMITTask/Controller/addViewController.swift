//
//  addViewController.swift
//  AMITTask
//
//  Created by ShKhan on 12/18/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

import UIKit

class addViewController: UIViewController  , UITextFieldDelegate {

    @IBOutlet weak var backBu: UIButton!
    
    @IBOutlet weak var userNumberTextF: UITextField!
    
    @IBOutlet weak var addressTextF: UITextField!
    
    @IBOutlet weak var userFXTextF: UITextField!
    
    @IBOutlet weak var lonTextF: UITextField!
    
    @IBOutlet weak var latTextF: UITextField!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var addBu: UIButton!
    
    @IBOutlet weak var editAddlb: UILabel!
    
    
    var edit:Bool?
    
    var item:mainItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        userNumberTextF.attributedPlaceholder=NSAttributedString(string:NSLocalizedString("Enter your number", comment: ""), attributes:    [NSAttributedStringKey.foregroundColor : UIColor.lightGray,NSAttributedStringKey.font:UIFont (name: "TheSans", size: 14)!])
        
        
        userNumberTextF.delegate = self
        
        addressTextF.attributedPlaceholder=NSAttributedString(string:NSLocalizedString("Enter your address", comment: ""), attributes:    [NSAttributedStringKey.foregroundColor : UIColor.lightGray,NSAttributedStringKey.font:UIFont (name: "TheSans", size: 14)!])
        
        
        addressTextF.delegate = self
        
        userFXTextF.attributedPlaceholder=NSAttributedString(string:NSLocalizedString("Enter your FX", comment: ""), attributes:    [NSAttributedStringKey.foregroundColor : UIColor.lightGray,NSAttributedStringKey.font:UIFont (name: "TheSans", size: 14)!])
        
        
        userFXTextF.delegate = self
        
        lonTextF.attributedPlaceholder=NSAttributedString(string:NSLocalizedString("Enter your lon -test", comment: ""), attributes:    [NSAttributedStringKey.foregroundColor : UIColor.lightGray,NSAttributedStringKey.font:UIFont (name: "TheSans", size: 14)!])
        
        
        lonTextF.delegate = self
        
        latTextF.attributedPlaceholder=NSAttributedString(string:NSLocalizedString("Enter your lat -test", comment: ""), attributes:    [NSAttributedStringKey.foregroundColor : UIColor.lightGray,NSAttributedStringKey.font:UIFont (name: "TheSans", size: 14)!])
        
        
        latTextF.delegate = self
        
        
        let tap15 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        innerView.isUserInteractionEnabled = true
        
        innerView.addGestureRecognizer(tap15)
        
        
        self.backBu.setTitle(String(format:"%C",0xf053), for: .normal);
       
        self.addBu.layer.cornerRadius = 5;
        
        
        self.userNumberTextF.keyboardType = .numberPad
        
        self.lonTextF.keyboardType = .numberPad
        
        self.latTextF.keyboardType = .numberPad
        
        
        if(edit)!
        {
            
            self.userNumberTextF.text = item?.userNumber
            
            self.addressTextF.text = item?.address
            
            self.userFXTextF.text = item?.userFX
            
            self.lonTextF.text = item?.lon
            
            self.latTextF.text = item?.lat
            
            self.addBu.setTitle("Save", for: .normal);
            
            self.editAddlb.text = "Edit"
        }
        else
        {
            
            self.addBu.setTitle("Add", for: .normal);
            
              self.editAddlb.text = "Add"
            
        }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        // handling code
        if sender?.view==innerView
        {
            self.view.endEditing(true)
            
        }
    }
    @IBAction func addClicked(_ sender: Any)
    {
        if(self.userNumberTextF.text == "" || self.addressTextF.text == "" || self.userFXTextF.text == "" ||  self.lonTextF.text == "" || self.latTextF.text == "" )
        {
            let alert = UIAlertView()
            alert.message = "Please enter correct data"
            alert.addButton(withTitle:"OK")
            alert.show()
            
            return
            
        }
        
       
           self.resignAll()
        
        if(edit)!
        {
            let it = mainItem.init(id: "\((item?.id)!)", lon: self.lonTextF.text!, lat: self.latTextF.text!, userNumber: self.userNumberTextF.text!, address: self.addressTextF.text!, userFX: self.userFXTextF.text!)
            
            DataClass.shared.addCardToDB(item: it)
            
            DataClass.shared.allUsers()
            
           NotificationCenter.default.post(name: Notification.Name("refreshDataYaMain"), object:"")
            
             self.navigationController?.popViewController(animated: true)
            
            let alert = UIAlertView()
            alert.message = "Edited successfully"
            alert.addButton(withTitle: "OK")
            alert.show()
            
        }
        else
        {
            let lastID = DataClass.shared.dataDef.count + 1
            
            print("lastID2255-- \(lastID)")
            
            let it = mainItem.init(id: "\(lastID)", lon: self.lonTextF.text!, lat: self.latTextF.text!, userNumber: self.userNumberTextF.text!, address: self.addressTextF.text!, userFX: self.userFXTextF.text!)
            
            DataClass.shared.dataDef.append(it)
            
            DataClass.shared.addCardToDB(item: it)
            
            NotificationCenter.default.post(name: Notification.Name("refreshDataYaMain"), object:"")
            
             self.navigationController?.popViewController(animated: true)
            
            let alert = UIAlertView()
            alert.message = "Added successfully"
            alert.addButton(withTitle: "OK")
            alert.show()
            
        }
        
        
        
    }
    
    @IBAction func cancelClicked(_ sender: Any)
    {
   self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func backClicked(_ sender: Any)
    {
        
        NotificationCenter.default.post(name: Notification.Name("refreshDataYaMain"), object:"")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resignAll()
    {
        
        self.userNumberTextF.resignFirstResponder()
        
        self.addressTextF.resignFirstResponder()
        
        self.userFXTextF.resignFirstResponder()
        
        self.lonTextF.resignFirstResponder()
        
        self.latTextF.resignFirstResponder()
        
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
