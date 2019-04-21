//
//  ColorObservationTests.swift
//  ColorSet_iOSTests
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import XCTest
@testable import ColorSet_iOS

final class ColorObservationTests: XCTestCase {
    var backgroundColor: ColorObservable<UIColor>!
    var textColor: ColorObservable<UIColor>!

    override func setUp() {
        super.setUp()
        backgroundColor = .init(.white)
        textColor = .init(.black)
    }

    func testEqual() {
        XCTContext.runActivity(named: "difference") { (_) in
            let observationBag = ColorObservationBag()
            let observationBackground = backgroundColor.subscribe { (_) in }
            let observationText = textColor.subscribe { (_) in }
            observationBag.add(observationBackground)
            observationBag.add(observationText)
            XCTAssertEqual(observationBackground, observationBag.observations.first)
            XCTAssertNotEqual(observationText, observationBag.observations.first)
        }

        XCTContext.runActivity(named: "same") { (_) in
            let observationBackground1 = backgroundColor.subscribe { (_) in }
            let view = UIView()
            let observationBackground2 = backgroundColor.bind(to: view, keyPath: \.backgroundColor)
            XCTAssertNotEqual(observationBackground1, observationBackground2)
        }
    }

    func testAppendTo() {
        let observationBag = ColorObservationBag()
        XCTAssertEqual(observationBag.observations.count, 0)
        backgroundColor.subscribe { (_) in }.append(to: observationBag)
        XCTAssertEqual(observationBag.observations.count, 1)
        let view = UIView()
        backgroundColor.bind(to: view, keyPath: \.backgroundColor).append(to: observationBag)
        XCTAssertEqual(observationBag.observations.count, 2)
    }

    func testUnregister() {
        let observationBag = ColorObservationBag()
        let view = UIView()
        let observation = backgroundColor.bind(to: view, keyPath: \.backgroundColor)
        observationBag.add(observation)

        XCTAssertEqual(view.backgroundColor, .white)
        backgroundColor.accept(.red)
        XCTAssertEqual(view.backgroundColor, .red)
        backgroundColor.accept(.blue)
        XCTAssertEqual(view.backgroundColor, .blue)

        // perform unregister
        observation.unregister()
        backgroundColor.accept(.yellow)
        XCTAssertEqual(view.backgroundColor, .blue)
    }
}
