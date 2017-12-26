//
//  mainTableViewCell.swift
//  MasryTester
//
//  Created by Approcks Mac Mini on 1/9/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

import UIKit

/**
 
 ## mainTableViewCell class ##
 
 This class is a layout cell to dispaly main tableview
 
 */

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var userNumberLb: UILabel!
    @IBOutlet weak var latLb: UILabel!
    @IBOutlet weak var lonlb: UILabel!
    @IBOutlet weak var addresslb: UILabel!
    @IBOutlet weak var userFX: UILabel!
     @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var numlb: UILabel!
    
    @IBOutlet weak var editBu: UIButton!
    var item:mainItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.helperView.layer.cornerRadius = 5;
        
        self.helperView.clipsToBounds = true; 
       
        self.contentView.backgroundColor = UIColor.lightGray
        
        self.editBu.setTitle(String(format:"%C",0xf044), for: .normal);
     
        
    }

    @IBAction func editClicked(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name("pushEditYaMain"), object:self.item)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
