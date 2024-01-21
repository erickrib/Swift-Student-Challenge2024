//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 21/01/24.
//

import SpriteKit

extension SKNode {
    func autoScale <T: SKSpriteNode>(_ node: T, widthProportion: Double, screenSize: CGSize) -> CGSize  {
            let proportion = node.size.width / node.size.height
            let width = screenSize.width
            let scale = CGSize(width: width * widthProportion, height: (width * widthProportion) / proportion )
            return scale
    }
}
