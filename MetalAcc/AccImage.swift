//
//  AccImage.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
import ImageIO
public class AccImage {

    private var commandQueue: MTLCommandQueue?
    private var textures = [MTLTexture]()
    public var filter: AccImageFilter?
    
    init() {
        if let defaultDevice = MTLCreateSystemDefaultDevice() {
            if let commandQueue = defaultDevice.makeCommandQueue() {
                self.commandQueue = commandQueue
            }
        }
    }
    
    public func Input(image: UIImage?) {
        guard image != .none else {
            return
        }
        if let image = image {
            if let texture = image.toMTLTexture() {
                if textures.isEmpty, let empty = texture.sameSizeEmptyTexture() {
                    textures.append(empty)//outTexture
                }
                textures.append(texture)
            }
        }
    }
    
    public func AddProcessor(filter: AccImageFilter) {
        self.filter = filter
    }
    
    public func Processing() {
        if let filter = filter, let pipeline = filter.pipelineState {
            commandQueue?.addAccCommand(pipelineState: pipeline, textures: textures, factors: filter.getFactors())
        }
    }
    public func Output() -> UIImage? {
        if textures.count > 0 {
            let image = textures[0].toImage()
            return image
        }
        return .none
    }
}
