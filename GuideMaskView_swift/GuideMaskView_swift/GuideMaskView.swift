//
//  GuideMaskView.swift
//  GuideMaskView_swift
//
//  Created by huzhaohao on 2019/12/11.
//  Copyright © 2019 huzhaohao. All rights reserved.
//

import UIKit
var countNum = 0
class GuideMaskView: UIView {
    //MARK:1.懒加载
    ///图层
    lazy var fillLayer:CAShapeLayer = {
        let fillLayer = CAShapeLayer()
        fillLayer.frame = self.bounds
        self.layer.addSublayer(fillLayer)
        return fillLayer
    }()
    ///路径
    lazy var overlayPath:UIBezierPath = {
        let overlayPath = self.generateOverlayPath()
        return overlayPath
    }()
    ///透明区数组
    var transparentPaths = NSMutableArray()
    ///图片数组
    var imageArr = NSMutableArray()
    ///图片frame数组
    var frameArr = NSMutableArray()
    ///点击计数
    var index = 0
    ///显示控制数组
    var orderArr = NSMutableArray()
    ///是否单张循环，默认YES
    var isSingle = true

    override init(frame: CGRect) {
       super.init(frame: UIScreen.main.bounds)
        self.setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        self.backgroundColor = UIColor.clear;
        let maskColor = UIColor(white: 0, alpha: 0.7)
        self.fillLayer.path      = self.overlayPath.cgPath;
        self.fillLayer.fillRule  = .evenOdd;
        self.fillLayer.fillColor = maskColor.cgColor;
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapClickedMaskView))
        self.addGestureRecognizer(tapGesture)
    }

    func addImages(images:NSArray,imageframeArr:NSArray,rectArr:NSArray) {
        if (images.count != imageframeArr.count || images.count != rectArr.count) {
            return;
        }
        self.isSingle = true;
        for (_, value) in images.enumerated() {
            let image:UIImage = UIImage(named: value as! String)!
            self.imageArr.add(image)
        }
        self.frameArr = imageframeArr.mutableCopy() as! NSMutableArray
        self.addImage(image: imageArr[0] as! UIImage, frame: frameArr[0] as! CGRect)
        for i in 0..<rectArr.count {
            let transparentPath = UIBezierPath.init(roundedRect: rectArr[i] as! CGRect, cornerRadius: 5)
            self.transparentPaths.add(transparentPath)
        }
        self.addTransparentPath(transparentPath: transparentPaths[0] as! UIBezierPath)
    }

    func addImages(images:NSArray,imageframeArr:NSArray,rectArr:NSArray,orderArr:NSArray) {
        if (images.count != imageframeArr.count || images.count != rectArr.count) {
              return;
          }
          //判断顺序数组总数是否等于图片数组
          var numCount:NSInteger = 0
            for item in orderArr {
                numCount = numCount + (item as! NSInteger)
            }
          if (numCount != images.count) {
              return
          }
         self.orderArr = orderArr.mutableCopy() as! NSMutableArray
          self.isSingle = false;
          for (_, value) in images.enumerated() {
              let image:UIImage = UIImage(named: value as! String)!
              self.imageArr.add(image)
          }
          self.frameArr = imageframeArr.mutableCopy() as! NSMutableArray
          self.addImage(image: imageArr[0] as! UIImage, frame: frameArr[0] as! CGRect)
          for i in 0..<rectArr.count {
              let transparentPath = UIBezierPath.init(roundedRect: rectArr[i] as! CGRect, cornerRadius: 5)
              self.transparentPaths.add(transparentPath)
          }
          self.addTransparentPath(transparentPath: transparentPaths[0] as! UIBezierPath)
    }
    @objc func tapClickedMaskView()  {
        index = index + 1
        if (isSingle) {
            if (index < imageArr.count) {
                self.refreshMask()
                self.addTransparentPath(transparentPath: transparentPaths[index] as! UIBezierPath)
                self.subviews.forEach { item in
                    item.removeFromSuperview()
                }
                self.addImage(image: imageArr[index] as! UIImage, frame: frameArr[index] as! CGRect)
            } else {
                self.dismissMaskView()
            }
        } else {
            if (index < imageArr.count) {
                self.refreshMask()
                self.subviews.forEach { item in
                  item.removeFromSuperview()
                }
                // 控制多个显示逻辑
                let baseNum:NSInteger = orderArr[index-1] as! NSInteger;
                 countNum = countNum + baseNum;
                let endNum:NSInteger = orderArr[index] as! NSInteger + countNum;
                for i in countNum..<endNum {
                    self.addTransparentPath(transparentPath: transparentPaths[i] as! UIBezierPath)
                    self.addImage(image: imageArr[i] as! UIImage, frame: frameArr[i] as! CGRect)
                }

            } else {
                 countNum = 0
                self.dismissMaskView()
            }
        }
    }


    func addTransparentPath(transparentPath:UIBezierPath) {
        self.overlayPath.append(transparentPath)
        self.fillLayer.path = self.overlayPath.cgPath
    }

    func addImage(image:UIImage,frame:CGRect) {
        let imageView:UIImageView  = UIImageView(frame: frame)
        imageView.backgroundColor = UIColor.clear
        imageView.image  = image
        self.addSubview(imageView)
    }

    func refreshMask() {
        let overlayPath:UIBezierPath = self.generateOverlayPath()
        self.overlayPath = overlayPath
    }

    func dismissMaskView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }

    func showMaskViewInView(view:UIView)  {
        self.alpha = 0
        view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

    func generateOverlayPath() -> UIBezierPath {
        let overlayPath = UIBezierPath(rect: self.bounds)
        overlayPath.usesEvenOddFillRule = true
        return overlayPath
    }

}
