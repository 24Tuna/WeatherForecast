//
//  JSONConverter.swift
//  Weather_24
//
//  Created by cmStudent on 2021/12/26.
//

import Foundation

class JSONConverter{
    let url:URL
    
    init(urlString:String){
        url = URL(string: urlString)!
    }
    
    func resume(handler: @escaping (Data?,URLResponse?,Error?) -> ()){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: handler)
        task.resume()
    }
}
