//
//  NewworkService.swift
//  MarvellRequest
//
//  Created by Daniil Davidovich on 14.03.23.
//

import Foundation
import CryptoKit

class NetworkServise {
    
    var link = "https://gateway.marvel.com:443/v1/public/comics?apikey="
    
    func urlMarvel() -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/comics"
        
        let publicKey = "eb29d3c3d55b564c378a3145801683a1"
        let privateKey = "829690ca0d938d31dbdc9c6df9b042d130778670"
        
        let ts = String(Date().timeIntervalSince1970)
        let conteiner = String()
        let hash = conteiner.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        let queryItemTs = URLQueryItem(name: "ts", value: ts)
        let queryItemApiKey = URLQueryItem(name: "apikey", value: publicKey)
        let queryItemHash = URLQueryItem(name: "hash", value: hash)
        
        components.queryItems = [queryItemTs, queryItemApiKey, queryItemHash]
        let url = components.url
        return url
    }
}
