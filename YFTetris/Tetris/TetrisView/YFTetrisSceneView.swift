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
            let view = self.sceneViewYF(index: i, frame: CGRect(x: width * CGFloat((i % column)), y: height * CGFloat((i / column)), width: width, height: height))
            view.empty()
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
    }
    
    func clearAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
                view.empty()
            }
        }
    }
    
    func fillAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
                view.fill()
            }
        }
    }
}
