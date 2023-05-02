//
//  Extension.swift
//  MarvellRequest
//
//  Created by Daniil Davidovich on 28.03.23.
//

import Foundation
import CryptoKit
import UIKit

extension String {
    
    var makeHttps: String {
        let i = self.index(self.startIndex, offsetBy: 4)
        var newString = self
        newString.insert("s", at: i)
        return newString
    }
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8)! )
        
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}

extension UIImageView {
    
    func getImage(stringURL: String) {
        
        if let url = URL(string: stringURL)  {
            let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            let session = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
                
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            session.resume()
        }
    }
}
