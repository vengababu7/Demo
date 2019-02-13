//
//  DataModel.swift
//  NevaTask
//
//  Created by Vengababu Maparthi on 13/02/19.
//  Copyright © 2019 Vengababu Maparthi. All rights reserved.
//

import Foundation
import RxSwift


class DataModel {
    let disposebag = DisposeBag()
    var parsedData = [Data]()
    func getTheDataFromAPI(completionHandler:@escaping(Bool)->()) {
        let networkApi = NetworkCall()
        
        networkApi.getTheData()
        networkApi.apiResponse.subscribe(onNext: { (response) in
            if(response.status == true)
            {
                if let data = response.data["data"] as? [[String: Any]] {
                    self.parsedData = data.map{
                        Data.init(dict: $0)
                    }
                }
                completionHandler(true)
            } else {
                if let errMSG = response.data["message"] as? String {
                    print(errMSG)
                }
            }
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }).disposed(by: disposebag)
    }
    
    
}

struct Data {
    var id:Int? = 0
    var name:String? = ""
    var skill:String? = ""
    var image:String? = ""
    
    init(dict:[String:Any]) {
        if let id = dict["id"] as? NSNumber{
            self.id = (id as! Int)
        }
        if let name = dict["name"] as? String{
            self.name = name
        }
        if let skills = dict["skills"] as? String{
            self.skill = skills
        }
        if let image = dict["image"] as? String{
            self.image = image
        }else{
            self.image = ""
        }
    }
}
