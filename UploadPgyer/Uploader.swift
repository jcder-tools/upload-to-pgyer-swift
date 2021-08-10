//
//  Uploader.swift
//  UploadPgyer
//
//  Created by cocoa on 2021/7/14.
//

import Foundation
import Alamofire

let pgyerPath = "https://www.pgyer.com/apiv2/app/builds"

class Uploader {
    
    var session: URLSession = URLSession.shared
    
    init() {
        
    }
    
    func execute(info: Info) {
        guard let url = URL(string: pgyerPath) else {
            Pgyer.exit(withError: PgyerError.urlIsInvalid)
        }
        print("开始上传：******************* info: \(info.desc)")
        let startDate = Date()
        
        let upload = AF.upload(multipartFormData: { formdata in
            var param: [String : String] = [:]

            param["_api_key"] = info.apiKey
            param["appKey"] = info.appkey
            param["buildPassword"] = info.buildPassword
            param["buildUpdateDescription"] = info.buildUpdateDescription
            param["buildInstallDate"] = String(info.buildInstallDate ?? 2)
            param["buildInstallType"] = String(info.buildInstallType ?? 1)
            
            
            param.forEach { (element) in
                if let data = element.value.data(using: .utf8) {
                    formdata.append(data, withName: element.key)
                }
            }

            formdata.append(info.file, withName: "file")
        }, to: url)
                
        var isExit = true
        let queue = DispatchQueue(label: "queue")
        upload.uploadProgress(queue: queue) { progress in
            let p = (Double(progress.completedUnitCount) / Double(progress.totalUnitCount)) * 100
            print("上传进度：******************* \(String(format: "%.2f%", p))")
        }
        upload.responseData(queue:queue) { dataResponse in
            let end = Date()
            let time = Int(end.timeIntervalSince(startDate))
            let m = time / 60
            let s = time % 60
            switch dataResponse.result {
            case .success(let data):
                
                let res = try? JSONSerialization.jsonObject(with: data,
                                                  options: []) as? [String : Any]
                if let code = res?["code"] as? Int,
                   code == 0 {
                    print("上传成功：******************* \(res?.description ?? "")")
                } else {
                    print("上传失败：******************* \(res?.description ?? "")")
                    Pgyer.exit(withError: PgyerError.pgyUploadFail)
                }

            case .failure(let error):
                print("上传失败：******************* \(error)")
                Pgyer.exit(withError: PgyerError.pgyUploadFail)
            }
            print("上传耗时：******************* \(m)分\(s)秒")

            isExit = false
        }
        //使用循环换保证命令行程序,不会死掉
        while isExit {
            Thread.sleep(forTimeInterval: 1)
        }
    }
    
    
}
