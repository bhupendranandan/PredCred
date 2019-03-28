//
//  ImageLoader.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 26/12/17.
//  Copyright © 2017 Vinay Shankar. All rights reserved.
//

import UIKit

/*class ImageLoader {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        DispatchQueue.global(qos: .background).async {()in
            var data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.async() {() in
                    completionHandler(image, urlString)
                };)
                return
            }
            
            var downloadTask: URLSessionDataTask = URLSession.sharedSession.dataTaskWithURL(NSURL(string: urlString)! as URL, completionHandler: {(data: NSData!, response: URLResponse!, error: NSError!) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        }
        
    }
}*/
