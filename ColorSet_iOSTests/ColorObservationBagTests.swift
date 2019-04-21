//
//  ColorObservationBagTests.swift
//  ColorSet_iOSTests
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import XCTest
@testable import ColorSet_iOS

final class ColorObservationBagTests: XCTestCase {
    var backgroundColor: ColorObservable<UIColor>!
    override func setUp() {
        super.setUp()
        backgroundColor = .init(.white)
    }

    func testAdd() {
        let observationBag = ColorObservationBag()
        let observation = backgroundColor.subscribe { (_) in }
        XCTAssertEqual(observationBag.observations.count, 0)
        observationBag.add(observation)
        XCTAssertEqual(observationBag.observations.count, 1)
    }

    func testRemove() {
        let observationBag = ColorObservationBag()
        XCTAssertEqual(observationBag.observations.count, 0)

        let view = UIView()
        let observation = backgroundColor.bind(to: view, keyPath: \.backgroundColor)
        observationBag.add(observation)
        XCTAssertEqual(observationBag.observations.count, 1)

        backgroundColor.accept(.red)
        XCTAssertEqual(view.backgroundColor, .red)

        observationBag.remove(observation)
        backgroundColor.accept(.blue)
        XCTAssertEqual(view.backgroundColor, .red)
        XCTAssertEqual(observationBag.observations.count, 0)
    }
}
