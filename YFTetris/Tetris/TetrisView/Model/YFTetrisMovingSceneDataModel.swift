//
//  YFTetrisMovingSceneDataModel.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/10.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisMovingSceneModel: NSObject {
    var xx:Int = 0
    var yy:Int = 0
    
    init(x:Int,y:Int) {
        xx = x
        yy = y
    }
}

class YFTetrisMovingSceneDataModel: NSObject {
    var beginXX:Int = 3
    
    var dataArray:[YFTetrisMovingSceneModel] = []
    
    // 四个方格的正方形
    func creatFourCube() {
        dataArray.removeAll()
        for i in 0..<4 {
            let model = YFTetrisMovingSceneModel(x: beginXX + i % 2, y: -1 + i / 2)
            dataArray.append(model)
        }
    }
    
    func createArcStyle(){
     self.dataArray.removeAll()
     self.creatFourCube()
    }
    
//MARK: - 移动 方法
    // 下移动 1 步
    func downOneStep() {
        self.downSteps(step: 1)
    }
    // 下移 step 是步数
    func downSteps(step:Int) {
        for model in self.dataArray {
            model.yy += 1
        }
    }
    
}
