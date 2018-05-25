//
//  AppDelegate.swift
//  TelePost
//
//  Created by Hitender kumar on 16/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import Foundation

typealias APICompletionHandler = ((_ info : NSDictionary?, _ response : HTTPURLResponse) -> ())?
typealias APIFailureHandler = ((_ error : NSError) -> ())?

public class API : NSObject{
    
    //MARK: Initializers
    
    override init() {
    }
    
    class var sharedInstance : API {
        return API()
    }
 
    func getTopHeadlinesWith(countryCode : String, completion : APICompletionHandler, failure : APIFailureHandler) {
        let urlStr = "https://newsapi.org/v2/top-headlines?country=\(countryCode)&apiKey=\(NewsApi.key)"
        let url = URL.init(string: urlStr)
        let request = URLRequest.init(url: url!)
        self.forwardRequest(request: request, httpMethod: HttpMethods.HttpMethod_GET, completion: completion, failure: failure)
    }
    
    func forwardRequest(request : URLRequest, httpMethod : String, completion : APICompletionHandler, failure : APIFailureHandler) {
        
        var sendRequest:URLRequest = request
        
        sendRequest.httpMethod = httpMethod as String
        //sendRequest.timeoutInterval = 5.0
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: sendRequest, completionHandler: { data, response, error in
            
            if error == nil{
                if let data = data {
                    let urlResponse = response as! HTTPURLResponse
                    
                    #if DEBUG
                    print("Response json Data is \(data)")
                    #endif
                    //use library to extract data from response json
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let infoDict = json as? NSDictionary {
                            completion!(infoDict, urlResponse)
                        } else {
                            completion!(nil, urlResponse)
                        }
                    } catch {
                        completion!(nil, urlResponse)
                    }
                }
            }
            else{
                if failure != nil{
                    failure!(error! as NSError )
                }
            }
            
        })
        task.resume()
    }
}

