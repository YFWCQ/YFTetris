//
//  YFTetrisSceneView.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisSceneView: UIView {
    // 已经沉到 底部的 方块
    let viewDataModel:YFTetrisSceneDataModel = YFTetrisSceneDataModel()
    
    // 正在 移动的 方块
    let viewMovingModel:YFTetrisMovingSceneDataModel = YFTetrisMovingSceneDataModel()
    
    let column:Int = 6 // 6列
    let row:Int = 10   // 7 行
    
    var timer:Timer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewMovingModel.beginXX = 3
    }
    
    func creatSecenView() {
        weak var weakS = self
        timer = Timer.YF_scheduledTimerWithTimeInterval(0.5, closure: {
            weakS?.nextStepGame()
        }, repeats: true)
        
        timer.pauseTimer()
        
        let width = frame.size.width / CGFloat(column)
        let height = frame.size.height / CGFloat(row)
        
        for i in 0..<column*row {
            let xx = i % column
            let yy = i / column
            let view = self.sceneViewYF(index: i, frame: CGRect(x: width * CGFloat(xx), y: height * CGFloat(yy), width: width, height: height))
            view.empty()
            view.xx = xx
            view.yy = yy
            viewDataModel.sceneViewArray.append(view)
            self.addSubview(view)
        }
    }
    // MARK:- View
    func sceneViewYF(index:Int,frame:CGRect) -> YFTetrisCubeView {
        let sceneView = YFTetrisCubeView(frame: frame)
        
        sceneView.layer.borderColor = UIColor.blue.cgColor
        sceneView.layer.borderWidth = 0.5
    
        return sceneView
    }

    // MARK:- model
    func beginGame() {
     self.viewMovingModel.createArcStyle()
        timer.resumeTimer()
    }
    
    func nextStepGame(){
        
        self.clearAllfillView()
        self.viewMovingModel.downOneStep()
        self.fillAllfillView()
        self.checkIsBottomed()
    }
    
    func clearAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
                view.empty()
            }
        }
        self.viewMovingModel.dataViewArray.removeAll()
    }
    
    func fillAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
                view.fill()
                self.viewMovingModel.dataViewArray.append(view)
            }
        }
    }
    // 检查是否 到 最后，
    func checkIsBottomed() {
        // 检查已经被占用的方块和 正在移动的方块 有没有 相邻
            for closeViewOfMoving in self.viewMovingModel.dataViewArray
            {
                for closeView in self.viewDataModel.sceneCloseArray {
                    if closeView.yy - closeViewOfMoving.yy <= 1 && closeView.xx == closeViewOfMoving.xx {
                        self.needSettingWhenisBottom()
                        return
                    }
                }
            }

        if let model = self.viewMovingModel.dataArray.last
        {
            // 是否下落到 不能再下落的 地方了
            if model.yy == self.row - 1 {
              self.needSettingWhenisBottom()
            }
        }
    }
    func needSettingWhenisBottom()
    {
        self.rememberIsBottomedOfMovingModel()
        self.viewMovingModel.removeAllModel()
        self.viewMovingModel.creatFourCube()
    }
    
    func rememberIsBottomedOfMovingModel() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
               
                self.viewDataModel.sceneCloseArray.append(view)
            }
        }
    }
    
    
    
    
    
}
