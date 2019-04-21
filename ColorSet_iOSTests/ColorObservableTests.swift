//
//  ColorObservableTests.swift
//  ColorSet_iOSTests
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import XCTest
@testable import ColorSet_iOS

class ColorObservableTests: XCTestCase {

    var backgroundColor: ColorObservable<UIColor>!

    override func setUp() {
        super.setUp()
        backgroundColor = .init(.white)
    }

    func testSubscribe() {
        let observationBag = ColorObservationBag()
        var subscribeCount: Int = 0
        backgroundColor.subscribe { (color) in
            defer { subscribeCount += 1 }

            if subscribeCount == 0 {
                XCTAssertEqual(color, .white)
            } else if subscribeCount == 1 {
                XCTAssertEqual(color, .red)
            }
        }.append(to: observationBag)
        backgroundColor.accept(.red)
    }

    func testBind() {
        let observationBag = ColorObservationBag()
        let view = UIView()
        backgroundColor.bind(to: view, keyPath: \.backgroundColor).append(to: observationBag)
        XCTAssertEqual(view.backgroundColor, .white)
        backgroundColor.accept(.red)
        XCTAssertEqual(view.backgroundColor, .red)
    }
}
