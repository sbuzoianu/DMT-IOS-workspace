//
//  ServerRequestManager.swift
//  ServerRequestManager
//
//  Created by Synergy on 27/03/18.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import Foundation
import UIKit

public typealias Parameters = [String:String]

enum ServerRequestConstants {
    
    enum  URLS{
        static let LOGIN_TEXT_RESPONSE = "http://students.doubleuchat.com/list.php"
        static let LOGIN_BINARY_RESPONSE = "http://students.doubleuchat.com/list_bin.php"
        static let LOGIN_URL = "http://students.doubleuchat.com/login.php"
        static let REGISTER_URL = "http://students.doubleuchat.com/register.php"
        static let FORGOT_PASSWORD_URL = "http://students.doubleuchat.com/forgotpw.php"
        static let ALL_OFFERS_URL = "http://students.doubleuchat.com/listoffers.php"
        static let AVATAR_CHANGE_URL = "http://students.doubleuchat.com/avatarchange.php"
        static let CLICKED_OFFER_URL = "http://students.doubleuchat.com/listofferdetails.php"
    }
    
    
    enum resultErrors{
        static let invalidEmail = "Adresa de E-Mail tastata nu este valida!"
        static let emptyText = "Unul sau mai multe campuri sunt incomplete!"
        static let invalidPhoneNumber = "Numarul de telefon tastat nu este valid!"
        static let unknownError = "O eroare necunoscuta a avut loc."
        static let confirmEmail = "Inregistrare reusita! Va rugam sa confirmati activarea acestui cont prin verificarea adresei de email tastate."
    }
    
    
    struct JSON {
        static let REGISTER_REQUEST_NUMBER = "1"
        static let LOGIN_REQUEST_NUMBER = "0"
        static let RESPONSE_ERROR = "error"
        static let RESPONSE_SUCCESS = "success"
        static let TAG_RESPONSE = "response"
        static let TAG_ACTION = "action"
        static let TAG_MESSAGE = "msg"
        
    }
    
}

public enum FetchResult<T> {
    case success(T)
    case error(String)
}

class ServerRequestManager: NSObject {
    
    
    static let instance = ServerRequestManager()
    
    
    func postRequest<T: Decodable>(params : Parameters,
                                   url : String,
                                   postCompleted: @escaping (FetchResult<T>) -> Void) {
        
        
        let request = createRequest(params: params, url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response , error -> Void in
            
            if data != nil {
                
                do{
                    
                    let decoder = JSONDecoder()
                    let objectJSON = try decoder.decode(T.self, from: data!)
                    postCompleted(FetchResult.success(objectJSON))
                    
                    
                }
                catch let error {
                    print("error catch - \(error)")
                    postCompleted(FetchResult.error(error as! String))
                    
                }
                
            } else {
                postCompleted(FetchResult.error(error as! String))
                
            }
            
            
        })
        task.resume()
    }
    
    
    private func createStringFromDictionary(dict: Parameters) -> String {
        var params = String()
        for (key, value) in dict {
            params += "&" + (key as String) + "=" + (value as String);
        }
        
        return params;
    }
    
    func runOnMainQueue(work: @escaping @convention(block) () -> Swift.Void){
        if Thread.isMainThread{
            work()
        }else{
            DispatchQueue.main.async(execute: work)
        }
        
    }
    
    private func createRequest(params : Parameters, url : String) -> NSMutableURLRequest {
        
        guard  let urlFromString = URL(string: url) else {
            assert(false, "NU S-A PUTUT GENERA URL!!!")
        }
        
        let paramsStr = createStringFromDictionary(dict: params)
        let paramsLength = "\(paramsStr.count)"
        let requestBodyData = (paramsStr as NSString).data(using: String.Encoding.utf8.rawValue)
        
        let request = NSMutableURLRequest(url: urlFromString)
        
        request.httpMethod = "POST"
        request.allowsCellularAccess = true
        request.httpBody = requestBodyData;
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(paramsLength, forHTTPHeaderField: "Content-Length")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
}


extension ServerRequestManager:NSURLConnectionDelegate {
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        print("URLConnection error = \(error)")
    }
}


