//
//  AccTexture.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
public extension MTLTexture{
    
    public func sameSizeEmptyTexture() -> MTLTexture{
        let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: pixelFormat, width: width, height: height, mipmapped: false)
        return MTLCreateSystemDefaultDevice()!.makeTexture(descriptor: textureDescriptor)!
    }
    
    public func threadGroups() -> MTLSize{
        let groupCount = threadGroupCount()
        return MTLSizeMake(Int(width) / groupCount.width, Int(height) / groupCount.height, 1)
    }
    public func threadGroupCount() -> MTLSize{
        return MTLSizeMake(16, 16, 1)
    }
    
    public func toImage() -> UIImage? {
        let bytesPerPixel: Int = 4
        let imageByteCount = width * height * bytesPerPixel
        let bytesPerRow = width * bytesPerPixel
        var src = [UInt8](repeating: 0, count: Int(imageByteCount))
        
        let region = MTLRegionMake2D(0, 0, width, height)
        self.getBytes(&src, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)
        
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue))
        
        let grayColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitsPerComponent = 8
        let context = CGContext(data: &src, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: grayColorSpace, bitmapInfo: bitmapInfo.rawValue)!
        if let dstImageFilter = context.makeImage() {
            return UIImage(cgImage: dstImageFilter, scale: 0.0, orientation: UIImageOrientation.downMirrored)
        }
        else {
            return .none
        }
    }
}
