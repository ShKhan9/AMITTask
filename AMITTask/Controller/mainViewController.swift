//
//  ViewController.swift
//  AMITTask
//
//  Created by ShKhan on 12/18/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

import UIKit

let CellIdentifier1 = "ContentCell";

class mainViewController: UIViewController , UITableViewDataSource,UITableViewDelegate , UIAlertViewDelegate {

    @IBOutlet weak var areaSettTable: UITableView!
    
    @IBOutlet weak var addBu: UIButton!
    
    @IBOutlet weak var loadActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var longPressViewHCon: NSLayoutConstraint!    
    
    var dataDef = [mainItem]()
    
    var currentItemToDelete:mainItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(listenForNotification),
            name: Notification.Name(rawValue: "refreshDataYaMain"),
            object: nil)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(listenForNotification),
            name: Notification.Name(rawValue: "pushEditYaMain"),
            object: nil)
       
        
        
        areaSettTable.register(UINib(nibName: "mainTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifier1)
        
        areaSettTable.delegate=self
        
        areaSettTable.dataSource=self
    
        areaSettTable.separatorColor = UIColor.clear
        
        areaSettTable.bounces = false
        
        areaSettTable.separatorStyle = .none
        
        areaSettTable.estimatedRowHeight = 200;
        
        areaSettTable.rowHeight = UITableViewAutomaticDimension;
        
        self.addBu.setTitle(String(format:"%C",0xf067), for: .normal);
       
        self.loadActivity.startAnimating()
        
        
        if(AppDelegate.isNetworkAvailable())
        {
            
             self.getData()
            
           //dataDef =   DataClass.shared.allUsers()
            
        }
        else
        {
          
            let alert = UIAlertView()
            alert.message = NSLocalizedString("internetMessage", comment: "")
            alert.addButton(withTitle: NSLocalizedString("invOk", comment: ""))
            alert.show()
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {
            
            self.longPressViewHCon.constant = 0
            
            UIView.animate(withDuration: 1.0, animations: {
                
                self.view.layoutIfNeeded()
                
            })
            
            
            
        }
        
        
    }
    
    @objc func listenForNotification(notification: Notification)
    {
        
        
        print("notification name : \(notification.name.rawValue)")
        
        
        if(notification.name.rawValue   ==  "refreshDataYaMain")
        {
            dataDef =   DataClass.shared.dataDef
            
            print("Count12122222DB in main \(self.dataDef.count)")
            
            self.areaSettTable.reloadData()
        }
        else
        if(notification.name.rawValue   ==  "pushEditYaMain")
        {
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addView") as! addViewController
            
            vc.edit = true
            
            vc.item = notification.object as! mainItem
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
     
        
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self);
        
    }
    
    func getData()
    {
        
        let urlAsString = "http://amit-learning.com/parkForMe/index.php"
        
        let url = NSURL(string: urlAsString )
        
       let urlRequest = NSMutableURLRequest(url: url! as URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        urlRequest.httpMethod = "GET"
        
        
        let queue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest as URLRequest, queue: queue)
        {
            
            (response: URLResponse?,data: Data?, error: Error?) in
            
            
            
            /* Now we may have access to the data, but check if an error came back first or not */
            if error == nil
            {
                
                do {
                    
                    let responseDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                    print("Prices responseDict:\(responseDict)")
                    
                
                    
                    if(responseDict["result"] as! Bool)
                    {
                        
                        print("Success269")
                        
                        let arr = responseDict["data"] as! NSArray
                        
                        for i in 0..<arr.count
                        {
                            
                            let item = arr.object(at: i) as! NSDictionary
                          
                            let id = item["id"] as? String ?? ""
                            
                            print("id \(id)")
                            
                            let langtitude = item["langtitude"] as? String ?? ""
                            
                            print("langtitude \(langtitude)")
                            
                            let latitude = item["latitude"] as? String ?? ""
                            
                            print("latitude \(latitude)")
                            
                            let address = item["address"] as? String ?? ""
                            
                            print("address \(address)")
                            
                            let userFK = item["userFK"] as? String ?? ""
                            
                            print("userFK \(userFK)")
                            
                            let userNumber = item["userNumber"] as? String ?? ""
                            
                            print("userNumber \(userNumber)")
                            
                            
                            let it = mainItem.init(id: id, lon: langtitude, lat: latitude, userNumber: userNumber, address: address, userFX: userFK)
                           
                            
                            self.dataDef.append(it)
                        }
                        
                        
                        DataClass.shared.dataDef = self.dataDef
                        
                        print("Count12122222 \(self.dataDef.count)")
                        
                        DispatchQueue.main.async {
                            
                            self.loadActivity.isHidden = true
                             self.loadActivity.stopAnimating()
                            self.areaSettTable.reloadData()
                            
                            
                            
                        }
                        
                        
                        DispatchQueue.global().async {
                            
                            for i in 0..<self.dataDef.count
                            {
                                let item  = self.dataDef[i]
                                
                                DataClass.shared.addCardToDB(item: item)
                                
                            }
                          
                            
                            
                        }
                        
                        
                        
                        
                     
                    }
                    else
                    {
                      
                    }
                    
                    
                } catch let caught as NSError
                {
                    print("Prices Error in json \(caught)")
                }
                
                
                
            }
            else if data?.count == 0 && error == nil
            {
                print("Prices Nothing was downloaded")
            }
            else if error != nil
            {
                print("Prices Error happened = \(String(describing: error))")
            }
            
        }
   
}

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = areaSettTable.dequeueReusableCell(withIdentifier:CellIdentifier1) as! mainTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let it = dataDef[indexPath.row]
        
        cell.item = it
        
        cell.userNumberLb.text = it.userNumber
        
        cell.lonlb.text = it.lon
        
        cell.latLb.text = it.lat
        
        cell.addresslb.text = it.address
        
        cell.userFX.text = it.userFX
        
      //  cell.numlb.text = "\(it.id)"
     
        cell.layoutSubviews()
        
        cell.layoutIfNeeded()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //logDetailView
        
        
        
        let it = dataDef[indexPath.row]
        
        
        currentItemToDelete = it
        
        
        let alert = UIAlertView()
        alert.message = "Are you sure you want to delete this item ?"
        alert.addButton(withTitle: "Ok")
        alert.addButton(withTitle: "Cancel")
        alert.delegate = self
        alert.tag = indexPath.row
        alert.show()
        
     
        
        
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        
        if(buttonIndex == 0)
        {
            
            DataClass.shared.deleteCardToDB(item: currentItemToDelete!)
            
            DataClass.shared.dataDef.remove(at: alertView.tag)
            
            dataDef = DataClass.shared.dataDef
            
            self.areaSettTable.reloadData()
         
            let alert = UIAlertView()
            alert.message = "Deleted successfully"
            alert.addButton(withTitle: "OK" )
            alert.show()
            
        }
        else
        {
            print("Cancelllll")
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return  self.dataDef.count
        
    }
    
    
    @IBAction func addClicked(_ sender: Any)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addView") as! addViewController
        
        vc.edit = false
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


 
    
   
}









