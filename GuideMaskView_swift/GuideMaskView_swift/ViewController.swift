//
//  ViewController.swift
//  GuideMaskView_swift
//
//  Created by huzhaohao on 2019/12/11.
//  Copyright © 2019 huzhaohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLB: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupGuideView()
    }
    func setupGuideView(){
        let  imageArr: NSArray = ["image_01","image_02","image_03"];
        let  rect1: CGRect = self.textLB.frame;
        let  rect2: CGRect = self.btn.frame;
        let  rect3: CGRect = self.imageV.frame;

        let imgFrameArr: NSArray  = [NSValue.init(cgRect: CGRect(x: rect1.origin.x-118, y: rect1.maxY-123, width:  118, height: 123))
            ,NSValue.init(cgRect: CGRect(x: rect2.maxX, y: rect2.origin.y - 108, width: 206, height: 108))
            ,NSValue.init(cgRect: CGRect(x: rect3.maxX-80, y: rect3.maxY, width: 144, height: 113)),
        ]
        let transparentRectArr:NSArray = [NSValue.init(cgRect: rect1),NSValue.init(cgRect: rect2),NSValue.init(cgRect: rect3)]
        let orderArr:NSArray = [1,2]

        let maskView:GuideMaskView = GuideMaskView()
        maskView.addImages(images: imageArr, imageframeArr: imgFrameArr, rectArr: transparentRectArr,orderArr:orderArr)
        maskView.showMaskViewInView(view: self.view)

    }
}

