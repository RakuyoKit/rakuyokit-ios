//
//  ViewController.swift
//  RakuyoKitDemo
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

import RakuyoKit
import RaLog

final class ViewController: UIViewController {
    struct TestModel: Codable {
        let str: String

        let num: Int
    }

    @NeedEncrypted(name: "Test String")
    private var testString: String?

    @NeedEncrypted(name: "Test Bool")
    private var testBool: Bool?

    @NeedEncrypted(name: "Test Int")
    private var testInt: Int?

    @NeedEncrypted(name: "Test Float")
    private var testFloat: Float?

    @NeedEncrypted(name: "Test String Array")
    private var testStringArray: [String]?

    @NeedEncrypted(name: "Test Int Array")
    private var testIntArray: [Int]?

    @NeedEncrypted(name: "Test Model")
    private var testModel: TestModel?

    @NeedEncrypted(name: "Test Model Array")
    private var testModelArray: [TestModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        test(for: \.testString, value: "testString", name: "testString")
        test(for: \.testBool, value: true, name: "testBool")
        test(for: \.testInt, value: 123, name: "testInt")
        test(for: \.testFloat, value: 3.14, name: "testFloat")
        test(for: \.testStringArray, value: ["A", "B", "C"], name: "testStringArray")
        test(for: \.testIntArray, value: [1, 2, 33], name: "testIntArray")
        test(for: \.testModel, value: .init(str: "str", num: 976), name: "testModel")
        test(for: \.testModelArray, value: [.init(str: "str", num: 976), .init(str: "str2", num: 543)], name: "testModelArray")
    }

    private func test<T>(for keyPath: WritableKeyPath<ViewController, T>, value: T, name: String) {
        var this = self
        Log.debug("\(name) 写入前：\(formatLogValue(this[keyPath: keyPath]))")
        this[keyPath: keyPath] = value
        Log.debug("\(name) 写入后：\(formatLogValue(this[keyPath: keyPath]))\n")
    }

    private func formatLogValue<T>(_ value: T?) -> String {
        value.flatMap { "\($0)" } ?? "nil"
    }
}
