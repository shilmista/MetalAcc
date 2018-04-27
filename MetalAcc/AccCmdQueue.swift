//
//  AccCmdQueue.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
public extension MTLCommandQueue {

    public func addAccCommand<T>(pipelineState: MTLComputePipelineState, textures: [MTLTexture], factors: [T]) {
        
        if let commandBuffer = self.makeCommandBuffer(), let commandEncoder = commandBuffer.makeComputeCommandEncoder() {
            commandEncoder.setComputePipelineState(pipelineState)

            for i in 0..<textures.count {
                commandEncoder.setTexture(textures[i], index: i)
            }

            if let device = MTLCreateSystemDefaultDevice() {
                for i in 0..<factors.count {
                    var factor = factors[i]
                    let size = max(MemoryLayout.size(ofValue: i), 16)
                    let buffer = device.makeBuffer(bytes: &factor, length: size, options: [MTLResourceOptions.storageModeShared])
                    commandEncoder.setBuffer(buffer, offset: 0, index: i)
                }
            }

            if textures.count > 0 {
                commandEncoder.dispatchThreadgroups(textures[0].threadGroups(), threadsPerThreadgroup: textures[0].threadGroupCount())
            }
            commandEncoder.endEncoding()
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
        }

    }
}
