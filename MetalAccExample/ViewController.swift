//
//  ViewController.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load image from resources folder
        let inimage = UIImage(named: "AnimalImage")
        
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.frame = view.bounds
        
        //create AccImage
        let accImage = AccImage()
        
        //Input resource
        accImage.Input(image: inimage)
        
        //Add filter
        accImage.AddProcessor(filter: AccFalseColorFilter())
        
        //Process
        accImage.Processing()
        
        //Output
        let outimage = accImage.Output()
        
        imageview.image = outimage
        self.view.addSubview(imageview)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
