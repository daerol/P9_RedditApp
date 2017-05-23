//
//  HTTP.swift
//  P9_NewsApp
//
//  Created by ITP312 on 23/5/17.
//  Copyright © 2017 ITP312. All rights reserved.
//

import UIKit


//// 
//// A simple wrapper for HTTP functions
////

class HTTP: NSObject {
    
    /**
    Issues a HTTP requests to the server
 **/
    
    private class func request(
        url: String,
        httpMethod : String, httpHeaders : [String: String],
        httpBody : Data?,
        onComplete:
        ((_: Data?, _: URLResponse?, _: Error?) -> Void)?)
    {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod // GET / POST
        request.httpBody = httpBody // daa to send to server
        for (key, value) in httpHeaders
        {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request)
            // Closures: 
            // Executes when the server respons to your app.
        {
            data, response, error in
            onComplete?(data, response, error)
            }.resume()
    }
    /**
     Issues a HTTP request to the server
     */
    private class func requestJSON(
        url: String,
        httpMethod : String,
        json: JSON?,
        onComplete:
        ((_: JSON?, _: URLResponse?, _: Error?) -> Void)?)
    {
        do
        {
            var httpBody : Data?
            if (json != nil)
            {
                httpBody = try json!.rawData()
            }
            request(url: url,
                    httpMethod: httpMethod,
                    httpHeaders: [
                        "Accept" : "application/json",
                        "Content-Type" : "application/json" ],
                    httpBody: httpBody,
                    onComplete:
                {
                    data, response, error in
                    var result : JSON?
                    if (data != nil)
                    {
                        result = JSON.init(data: data!)
                    }
                    onComplete?(result, response, error)
                    
            })
        }
        catch
        {
        }
    }
    /**
     Issues a HTTP GET request to the server.
     Retrieves the result as a SwiftyJSON object.
     */
    class func getJSON(url: String, onComplete:
        ((_: JSON?, _: URLResponse?, _: Error?) -> Void)?)
    {
        requestJSON(url: url,
                    httpMethod: "GET",
                    json: nil,
                    onComplete: onComplete)
    }
    /**
     Issues a HTTP POST request to the server using a SwiftyJSON Object as the POST parameters.
     
     Retrieves the result as a SwiftyJSON object.
     */
    class func postJSON(url: String, json: JSON, onComplete:
        ((_: JSON?, _: URLResponse?, _: Error?) -> Void)?)
    {
        requestJSON(url: url,
                    httpMethod: "POST",
                    json: json,
                    onComplete: onComplete)
    }
    
}


                    


