//
//  Device.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

public enum Device {
    /// Device model code
    ///
    /// like iPhone1,1
    public static var codeName: String {
        var info = utsname()
        uname(&info)
        
        let machineMirror = Mirror(reflecting: info.machine)
        
        return machineMirror.children.reduce(into: "") {
            guard let value = $1.value as? Int8, value != 0 else { return }
            $0 += String(UnicodeScalar(UInt8(value)))
        }
    }
    
    public static func generateUUID() -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
    }
}
