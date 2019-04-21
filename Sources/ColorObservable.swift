//
//  ColorObservable.swift
//  ColorSet-iOS
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import Foundation

/// Observable color
public class ColorObservable<T: Color> {
    let didChange: Notification.Name = .init("me.fromkk.ColorSet.didChange")
    let notificationCenter: NotificationCenter = .init()

    public private(set) var value: T {
        didSet {
            notificationCenter.post(name: didChange, object: value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    /// Change color
    ///
    /// - Parameter value: Color
    public func accept(_ value: T) {
        self.value = value
    }

    /// Wait color change.
    ///
    /// - Parameter callback: handle change color
    /// - Returns: Observation for unregister.
    public func subscribe(_ callback: @escaping (T) -> Void) -> ColorObservation {
        callback(value)
        return ColorObservation(
            notificationCenter.addObserver(forName: didChange, object: nil, queue: .main, using: { notification in
                guard let value = notification.object as? T else { return }
                callback(value)
            }),
            notificationCenter: notificationCenter
        )
    }

    /// Color bind to view's property.
    ///
    /// - Parameters:
    ///   - object: set view
    ///   - keyPath: set key path
    /// - Returns: Observation for unregister.
    public func bind<O: AnyObject>(to object: O, keyPath: ReferenceWritableKeyPath<O, T>) -> ColorObservation {
        return subscribe { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }

    /// Color bind to view's property for optional.
    ///
    /// - Parameters:
    ///   - object: set view
    ///   - keyPath: set key path
    /// - Returns: Observation for unregister.
    public func bind<O: AnyObject>(to object: O, keyPath: ReferenceWritableKeyPath<O, T?>) -> ColorObservation {
        return subscribe { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
