//
//  AccImageLevelsFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
AccImageLevelsFilter: Photoshop-like levels adjustment. The min, max, minOut and maxOut parameters are floats in the range [0, 1]. If you have parameters from Photoshop in the range [0, 255] you must first convert them to be [0, 1]. The gamma/mid parameter is a float >= 0. This matches the value from Photoshop. If you want to apply levels to RGB as well as individual channels you need to use this filter twice - first for the individual channels and then for all channels.
*/
public class AccImageLevelsFilter: AccImageFilter {
    var levelMinimum:(R: Float, G: Float, B: Float) = (0, 0, 0)
    var levelMiddle:(R: Float, G: Float, B: Float) = (0, 0, 0)
    var levelMaximum:(R: Float, G: Float, B: Float) = (0, 0, 0)
    var minOutput:(R: Float, G: Float, B: Float) = (0, 0, 0)
    var maxOutput:(R: Float, G: Float, B: Float) = (0, 0, 0)
    public init() {
        super.init(name: "ImageLevels")
    }
    override public func getFactors() -> [Float] {
        return [
        levelMinimum.R, levelMinimum.G, levelMinimum.B,
        levelMiddle.R, levelMiddle.G, levelMiddle.B,
        levelMaximum.R, levelMaximum.G, levelMaximum.B,
        minOutput.R, minOutput.G, minOutput.B,
        maxOutput.R, maxOutput.G, maxOutput.B ]
    }
}
