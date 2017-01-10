//
//  YFTetrisSceneDataModel.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/10.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisSceneDataModel: NSObject {
    var sceneViewArray:[NSObject] = []// 所有 方块的数组
    var sceneOpenArray:[NSObject] = []// 所有没有被占用的 方块
    var sceneCloseArray:[NSObject] = []// 所有已被 占用的 并且停止移动 方块
    var sceneIsMovingCloseArray:[NSObject] = []// 所有被 占用的 正在移动的 方块

}
