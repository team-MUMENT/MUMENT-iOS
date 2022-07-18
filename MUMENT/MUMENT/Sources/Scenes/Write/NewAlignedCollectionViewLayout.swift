//
//  NewAlignedCollectionViewLayout.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/18.
//

import UIKit

class NewAlignedCollectionViewLayout: UICollectionViewFlowLayout {
    var cachedFrames: [[CGRect]] = []
    
    var numRows: Int = 3
    
    let cellSpacing: CGFloat = 20
    
    override init(){
        super.init()
        commonInit()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    func commonInit() {
        scrollDirection = .horizontal
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //      guard let attributes = super.layoutAttributesForElements(in: rect) else {
        //          return nil
        //      }
        
        // we want to force the collection view to ask for the attributes for ALL the cells
        //  instead of the cells in the rect
        var r: CGRect = rect
        // we could probably get and use the max-width from the cachedFrames array...
        //  but let's just set it to a very large value for now
        r.size.width = 50000
        guard let attributes = super.layoutAttributesForElements(in: r) else {
            return nil
        }
        
        guard let attributesToReturn =  attributes.map( { $0.copy() }) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }
        
        attributesToReturn.forEach { layoutAttribute in
            
            let thisRow: Int = layoutAttribute.indexPath.item % numRows
            let thisCol: Int = layoutAttribute.indexPath.item / numRows
            
            layoutAttribute.frame.origin.x = cachedFrames[thisRow][thisCol].origin.x
        }
        
        return attributesToReturn
    }
}

