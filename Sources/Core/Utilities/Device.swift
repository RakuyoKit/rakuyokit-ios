//
//  Device.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

// MARK: - Device

public enum Device {
    public static func generateUUID() -> String {
        UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
    }
}

// MARK: - Code Name

extension Device {
    public enum Running {
        case realMachine
        case simulator
        case wherever
    }

    /// Device model code
    ///
    /// like iPhone1,1
    public static var codeName: String {
        codeName(running: .wherever)
    }

    /// When running on a real machine in the physical world,
    /// the identifier corresponding to the device is returned.
    ///
    /// like `iPhone1,1`
    private static var realMachineCodeName: String {
        var info = utsname()
        uname(&info)

        let machineMirror = Mirror(reflecting: info.machine)

        return machineMirror.children.reduce(into: "") {
            guard let value = $1.value as? Int8, value != 0 else { return }
            $0 += String(UnicodeScalar(UInt8(value)))
        }
    }

    /// When the simulator is running, the identifier of
    /// the real device corresponding to the simulator is returned.
    private static var simulatorCodeName: String? {
        ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]
    }

    /// Device model code
    ///
    /// like iPhone1,1
    public static func codeName(running: Running) -> String {
        switch running {
        case .realMachine:
            return realMachineCodeName

        case .simulator:
            if let _codeName = simulatorCodeName { return _codeName }
            assertionFailure(
                "Please call this property when the simulator is running." +
                    " Consider using `#if targetEnvironment(simulator)` to isolate your code."
            )
            return realMachineCodeName

        case .wherever:
            return simulatorCodeName ?? realMachineCodeName
        }
    }
}
