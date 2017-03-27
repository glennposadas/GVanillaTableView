//
//  CoreService.swift
//  GVanillaTableView
//
//  Created by Glenn Posadas on 3/28/17.
//  Copyright © 2017 Citus Labs. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


class CoreService {
    
    var requestDescription: String?
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            
            requestDescription = request?.description
            headers.removeAll()
            body = nil
            elapsedTime = nil
        }
    }
    
    typealias CoreServiceCallBack = (HTTPURLResponse?, Result<Any>?) -> Void
    
    /** The main core function to have a request. Be sure to set the self.request
     */
    
    public func request(withBlock completion: @escaping CoreServiceCallBack) {
        
        guard let request = self.request else {
            print("WARNING: REQUEST Object is not set!")
            completion(nil, nil)
            return
        }
        
        let start = CACurrentMediaTime()
        
        if let request = request as? DataRequest {
            request.responseJSON(completionHandler: {
                (response) in
                
                let end = CACurrentMediaTime()
                self.elapsedTime = end - start
                
                if let urlResponse = response.response {
                    for (field, value) in urlResponse.allHeaderFields {
                        self.headers["\(field)"] = "\(value)"
                    }
                }
                
                completion(response.response, response.result)
            })
        }
    }
}
