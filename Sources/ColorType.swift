//  Represents color types
//
//  ColorType.swift
//  ColorSet-iOS
//
//  Created by Kazuya Ueoka on 2019/04/21.
//

import Foundation
#if canImport(CoreGraphics)
    import CoreGraphics
#endif

#if canImport(CoreImage)
    import CoreImage
#endif

#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

public protocol Color {}

#if canImport(CoreGraphics)
    extension CGColor: Color {}
#endif

#if canImport(CoreImage)
    extension CIColor: Color {}
#endif

#if canImport(UIKit)
    extension UIColor: Color {}
#elseif canImport(Cocoa)
    extension NSColor: Color {}
#endif
