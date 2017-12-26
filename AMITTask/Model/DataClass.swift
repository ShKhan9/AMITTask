//
//  DataClass.swift
//  MasryTester
//
//  Created by Approcks Mac Mini on 4/10/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

import UIKit


class DataClass: NSObject  {
    
   
    var dataDef = [mainItem]()
    
     var dbManager = DBManager()
    
    static let shared: DataClass =
    {
        /// singleton shared object
        
        let instance = DataClass()
        
        instance.dbManager.setFileName("myUsersDB.sqlite")
        
        return instance
        
    }()
    
  
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func addCardToDB(item:mainItem)
    {
        
        let str = String.init(format: "insert or replace into users values(\'%@\',\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')", item.id,item.lon,item.lat,item.userNumber,item.address,item.userFX)
        
        
        self.dbManager.executeQuery(str);
        
        
    }
    func deleteCardToDB(item:mainItem)
    {
        
        let str = String.init(format: "DELETE FROM users where id = \'%@\'",item.id)
        
        
        self.dbManager.executeQuery(str);
        
        
    }
    
    func allUsers() -> [mainItem]
    {
        
        let arr = self.dbManager.loadData(fromDB: "select * from users ORDER BY id COLLATE NOCASE ASC")! as NSArray
        
        
        
        var arrRet = [mainItem]()
        
        for i in 0..<arr.count
        {
            
            let  wer = arr[i] as! NSArray;
            
            let it = mainItem.init(id: wer[0] as! String , lon: wer[1] as! String , lat: wer[2] as! String  , userNumber: wer[3] as! String  , address: wer[4] as! String , userFX: wer[5] as! String )
            
            
            arrRet.append(it)
            
            
        }
       
        arrRet = arrRet.sorted(by: {
            
           
            var m1 = Int($0.id)
            
            var m2 = Int($1.id)
            
           
            return m1! < m2!
            
            
        })
        
        DataClass.shared.dataDef = arrRet
        
        print("Count12122222DB pop \(self.dataDef.count)")
        
        return  arrRet;
        
        
    }
    
    
}
