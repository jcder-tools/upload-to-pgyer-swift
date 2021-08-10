//
//  main.swift
//  UploadPgyer
//
//  Created by cocoa on 2021/7/14.
//

import Foundation
import ArgumentParser

enum PgyerError: Error {
    case fileIsEmpty
    case apiKeyIsNull
    case appKeyIsNull
    case urlIsInvalid
    case fileIsInvalid
    case pgyUploadFail
}


struct Pgyer: ParsableCommand {

    
    @Option(name: .shortAndLong, help: "The ipa need upload")
    var file: String?
    
    @Option(name: .shortAndLong, help: "Pgyer api key")
    var apiKey: String?
    
    @Option(name: .shortAndLong, help: "Install type")
    var installType: Int?
    
    @Option(name: .shortAndLong, help: "Install password")
    var password: String?
    
    @Option(name: .shortAndLong, help: "Deploy desc")
    var desc: String?
    
    @Option(name: .shortAndLong, help: "Pgyer app Key")
    var key: String?
    
    func run() throws {
        guard let file = file else {
            Pgyer.exit(withError: PgyerError.fileIsEmpty)
        }
        
        guard let apiKey = apiKey else {
            Pgyer.exit(withError: PgyerError.apiKeyIsNull)
        }
        
        guard let key = key else {
            Pgyer.exit(withError: PgyerError.appKeyIsNull)
        }
        
        let info = Info(apiKey: apiKey, appkey: key, file: file, installType: installType, password: password, desc: desc, date: 2)
        
        Uploader().execute(info: info)
        
        
    }
    
    
}

Pgyer.main()
