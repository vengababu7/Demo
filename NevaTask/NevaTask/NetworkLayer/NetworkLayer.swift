//
//  NetworkLayer.swift
//  NevaTask
//
//  Created by Vengababu Maparthi on 13/02/19.
//  Copyright © 2019 Vengababu Maparthi. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import SVProgressHUD


class NetworkCall {
    
    let disposebag = DisposeBag()
    let subject_response = PublishSubject<[String:Any]>()
    let apiResponse = PublishSubject<ApiResponse>()
    
    
    func getTheData(){
        SVProgressHUD.show()
        let apiFullName = "https://test-api.nevaventures.com"
        
        RxAlamofire.requestJSON(.get, apiFullName, parameters: nil,encoding:URLEncoding.default, headers: nil)
            .debug()
            .subscribe(onNext: { (head, body) in
                let bodyIn = body as! [String:Any]
                SVProgressHUD.dismiss()
                let errNum: APIErrors.ErrorCode? = APIErrors.ErrorCode.init(rawValue: head.statusCode)
                if errNum == .success {
                    self.apiResponse.onNext(ApiResponse.init(status: true, response: bodyIn))
                }else{
                    self.apiResponse.onNext(ApiResponse.init(status: false, response: bodyIn))
                }
            }, onError: { (Error) in
                SVProgressHUD.dismiss()
                self.subject_response.onError(Error)
            }).disposed(by: disposebag)
        
    }
    
}


class ApiResponse: NSObject {
    
    var status = Bool()
    var data = [String:Any]()
    
    init(status:Bool,response:[String:Any]) {
        self.status = status
        self.data = response
    }
}

class APIErrors: NSObject {
    static let disposeBag = DisposeBag()
    enum ErrorCode: Int {
        case success                = 200
        case badRequest             = 400
    }
}
