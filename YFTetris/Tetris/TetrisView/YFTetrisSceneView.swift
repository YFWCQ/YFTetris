//
//  YFTetrisSceneView.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisSceneView: UIView {
    let viewDataModel:YFTetrisSceneDataModel = YFTetrisSceneDataModel()
    let column:Int = 6 // 6列
    let row:Int = 7   // 7 行
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            }
    
    func creatSecenView() {
        let width = frame.size.width / CGFloat(column)
        let height = frame.size.height / CGFloat(row)
        
        for i in 0..<column*row {
            let view = self.sceneViewYF(index: i, frame: CGRect(x: width * CGFloat((i % column)), y: height * CGFloat((i / column)), width: width, height: height))
            viewDataModel.sceneViewArray.append(view)
            self.addSubview(view)
        }

    }
    
    func sceneViewYF(index:Int,frame:CGRect) -> UIView {
        let sceneView = UIView(frame: frame)
        
        sceneView.backgroundColor = UIColor.gray
        sceneView.layer.borderColor = UIColor.blue.cgColor
        sceneView.layer.borderWidth = 0.5
    
        return sceneView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
