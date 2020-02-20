//
//  RequestAPI.swift
//  Buscame
//
//  Created by macbook-estagio on 23/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import Alamofire

//class RequestAPI: NSObject {
//    typealias WebServiceResponse = ([[String:String]]?, Error?) -> Void
//
//    func requestAPI(_ urlString:String, completion:@escaping WebServiceResponse){
//        Alamofire.request(urlString, method: .get).validate().responseJSON { (response) in
//
//            if let error = response.error {
//                completion(nil, error)
//                print("<><><><><><>\(error.localizedDescription)")
//
//            } else if let jsonArray = response.result.value as? [[String:String]] {
//                completion(jsonArray, nil)
//
//                for array in jsonArray {
//                    //                    print(array.count)
//                    print(array)
//                }
//                //                print(jsonArray)
//
//            } else if let jsonDictionary = response.result.value as? [String:String] {
//                completion([jsonDictionary], nil)
//            }
//        }
//    }
//}


class RequestAPI: NSObject {
    typealias WebServiceResponse = ([[String:String]]?, Error?, Bool) -> Void
    
    func requestAPI(_ urlString:String, completion:@escaping WebServiceResponse){
        
        Alamofire.request(urlString, method: .get).validate().responseJSON { (response) in
            if let error = response.error {
                print("<><><><><><>\(error.localizedDescription)")
                completion(nil, error, true)
            } else if let jsonArray = response.result.value as? [[String:String]] {
                for array in jsonArray {
                    print(array)
                }
                completion(jsonArray, nil, true)
            } else if let jsonDictionary = response.result.value as? [String:String] {
                completion([jsonDictionary], nil, true)
            }
            else {
                let jsonDictionary = response.result.isSuccess
                if jsonDictionary == true {
                    print("Resultado da Request - Sem sucesso (\(jsonDictionary))")
                } else {
                    print("Resultado da Request - Sem sucesso (\(jsonDictionary))")
                }
                completion(nil, nil, jsonDictionary)
            }
            
            
                
                
            
        }
    }
}
