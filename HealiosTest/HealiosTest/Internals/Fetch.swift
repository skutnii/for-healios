//
//  Fetch.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

func fetchContent(srcURL: URL, cacheURL: URL) -> Promise<Void> {
    let result = Promise<Void>()
    URLSession.shared.downloadTask(with: srcURL) {
        [result] (maybeFile: URL?, maybeResponse: URLResponse?, maybeError: Error?) -> Void in
        if let file = maybeFile {
            do {
                try FileManager.default.moveItem(at: file, to: cacheURL)
            } catch {
                DispatchQueue.main.async {
                    result.reject(RuntimeError.IOError("File I/O error"))
                }
            }
            
            DispatchQueue.main.async {
                result.resolve(())
            }
        }
        
        DispatchQueue.main.async {
            result.reject(RuntimeError.IOError("HTTP error"))
        }
    }
    .resume()
    
    return result
}
