//
//  PackakgeInfo.swift
//  UploadPgyer
//
//  Created by cocoa on 2021/7/14.
//

import Foundation

struct Info {
    
    // (必填) API Key
    var apiKey: String
    
    // (必填) 需要上传的ipa或者apk文件
    var file: URL
    
    // (选填)应用安装方式，值为(1,2,3，默认为1 公开安装)。1：公开安装，2：密码安装，3：邀请安装
    var buildInstallType: Int?
    
    // (选填) 设置App安装密码，密码为空时默认公开安装
    var buildPassword: String?
    
    // (选填) 版本更新描述，请传空字符串，或不传。
    var buildUpdateDescription: String?
    
    // 选填)是否设置安装有效期，值为：1 设置有效时间， 2 长期有效，如果不填写不修改上一次的设置
    var buildInstallDate: Int?
    
    var appkey: String
    
    init(apiKey: String, appkey: String, file: String, installType: Int?, password: String?, desc: String?, date: Int?) {
        self.apiKey = apiKey
        self.appkey = appkey
        self.file = URL(fileURLWithPath: file)
        self.buildInstallType = installType ?? 1
        self.buildPassword = password ?? ""
        self.buildUpdateDescription = desc ?? ""
        self.buildInstallDate = date ?? 2
    }
    
    var desc: String {
        return "file: \(file.absoluteString), buildInstallType: \(self.buildInstallType ?? 1), buildPassword: \(self.buildPassword ?? ""), buildUpdateDescription: \(self.buildUpdateDescription ?? ""), buildInstallDate: \(self.buildInstallDate ?? 2), apikey: \(self.apiKey)"
    }
    
}
