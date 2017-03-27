//
//  ImageService.swift
//  GVanillaTableView
//
//  Created by Glenn Posadas on 3/28/17.
//  Copyright © 2017 Citus Labs. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ImageService {
    
    typealias ImageServiceCallBack = (BaseClass?) -> Void
    
    /*https://8e126eaf725839c21589:94b60902c6ff9744e2896fb321cc3d50f0ac4b1b@api.shutterstock.com/v2/images/search?query=cars&page=1&per_page=50*/
    
    public func fetchImages(query: String, page: Int, withBlock completion: @escaping ImageServiceCallBack) {
        
        let client_id = "8e126eaf725839c21589"
        let client_secret = "94b60902c6ff9744e2896fb321cc3d50f0ac4b1b"
        let credentialData = "\(client_id):\(client_secret)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        let path = "https://8e126eaf725839c21589:94b60902c6ff9744e2896fb321cc3d50f0ac4b1b@api.shutterstock.com/v2/images/search"
        
        let parameters = ["query" : query,
                          "page" : page,
                          "per_page" : 500] as Parameters
        
        let coreService = CoreService()
        coreService.request = Alamofire.request(path, method: .get, parameters: parameters, headers: headers)
        
        coreService.request {
            (response, result) in
            
            if let _ = result?.error {
                completion(nil)
                return
            }
            
            // Parse the data to Job object
            if let resultValue = result?.value {
                
                let resultJson = JSON(resultValue)
                
                let baseData = BaseClass(json: resultJson)
                
                completion(baseData)
            }
        }
    }
}
