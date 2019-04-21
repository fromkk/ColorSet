//
//  ColorSetObservation.swift
//  ColorSet-iOS
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import Foundation

/// Management notification for change color.
public class ColorObservation: Equatable {
    private let observation: NSObjectProtocol
    weak var notificationCenter: NotificationCenter?
    init(_ observation: NSObjectProtocol, notificationCenter: NotificationCenter) {
        self.observation = observation
        self.notificationCenter = notificationCenter
    }

    /// Remove notification.
    public func unregister() {
        notificationCenter?.removeObserver(observation)
    }

    /// Add notification to bag.
    ///
    /// - Parameter observationBag: Observation bag.
    public func append(to observationBag: ColorObservationBag) {
        observationBag.add(self)
    }

    public static func == (lhs: ColorObservation, rhs: ColorObservation) -> Bool {
        return lhs.observation.isEqual(rhs.observation) && (lhs.notificationCenter?.isEqual(rhs.notificationCenter) ?? false)
    }
}
