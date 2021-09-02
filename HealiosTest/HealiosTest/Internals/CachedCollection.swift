//
//  CachedCollection.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class CachedCollection<Object: JsonSerializable> {
    let srcURL: URL
    let cacheURL: URL
    
    typealias Loader = (URL, URL) -> Promise<Void>
    var download: Loader
    
    init(srcURL: URL, cacheURL: URL, downloadMethod: @escaping Loader) {
        self.srcURL = srcURL
        self.cacheURL = cacheURL
        self.download = downloadMethod
    }
    
    private var objects: [Object] = []
        
    func getObjects() -> Promise<[Object]> {
        //If there are objects in memory, return them immediately
        if !objects.isEmpty {
            return Promise<[Object]>.resolve(objects)
        }
        
        //If there is cached content, initialize the in-memory array with it and return
        if let content = FileManager.default.contents(atPath: cacheURL.path) {
            do {
                guard
                    let json = try JSONSerialization.jsonObject(with: content, options: []) as? [Any]
                else {
                    return Promise<[Object]>.reject(RuntimeError.dataError("Invalid cached data format"))
                }
                
                for item in json {
                    guard
                        let object = try? Object(jsonObject: item)
                    else {
                        continue
                    }
                    
                    objects.append(object)
                }
                
                return Promise<[Object]>.resolve(objects)
            } catch {
                return Promise<[Object]>.reject(RuntimeError.dataError("JSON parsing error"))
            }
        }

        //Download the data then try again
        return download(srcURL, cacheURL).then(async: {
            [weak self] _ -> Promise<[Object]> in
            guard
                let strongSelf = self
            else {
                return Promise<[Object]>.reject(RuntimeError.logicError("CachedCollection was deallocated why downloading"))
            }
            
            return strongSelf.getObjects()
        })
    }
}
