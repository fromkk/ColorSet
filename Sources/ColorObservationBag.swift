//
//  ColorSetObservationBag.swift
//  ColorSet-iOS
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import Foundation

/// Store observations.
public class ColorObservationBag {
    var observations: [ColorObservation] = []

    public init() {}

    deinit {
        observations.forEach { observation in
            observation.unregister()
        }
        observations = []
    }

    /// add observation
    ///
    /// - Parameter observation: Observation
    public func add(_ observation: ColorObservation) {
        observations.append(observation)
    }

    /// Remove observation
    ///
    /// - Parameter observation: Observation
    public func remove(_ observation: ColorObservation) {
        guard let index = observations.firstIndex(of: observation) else { return }
        observation.unregister()
        observations.remove(at: index)
    }
}
