//
//  LinearGradientLayer.swift
//  Reciplease
//
//  Created by Margarita Blanc on 12/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

public final class LinearGradientLayer: CALayer {
    
    public enum Direction {
        case vertical
        case horizontal
        case custom(start: CGPoint, end: CGPoint)
        
        var points: (start: CGPoint, end: CGPoint) {
            switch self {
            case .vertical:
                return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
            case let .custom(start, end):
                return (start, end)
            }
        }
    }
    
    public var direction: Direction = .vertical
    public var colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    public var colors: [CGColor]?
    public var locations: [CGFloat]?
    public var options: CGGradientDrawingOptions = CGGradientDrawingOptions(rawValue: 0)
    
    // MARK: - Lifecycle
    public required override init() {
        super.init()
        masksToBounds = true
        needsDisplayOnBoundsChange = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override public func draw(in ctx: CGContext) {
        ctx.saveGState()
        guard let colors = colors, let gradient = CGGradient(colorsSpace: colorSpace,
                                                             colors: colors as CFArray, locations: locations) else { return }
        let points = direction.points
        ctx.drawLinearGradient(
            gradient,
            start: transform(points.start),
            end: transform(points.end),
            options: options
        )
    }
    
    // MARK: - Private
    private func transform(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: bounds.width * point.x, y: bounds.height * point.y)
    }
}
