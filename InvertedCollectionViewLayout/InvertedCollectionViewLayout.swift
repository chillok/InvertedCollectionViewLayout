//
//  InvertedCollectionViewLayout.swift
//  InvertedCollectionViewLayout
//
//  Created by Cillian O'Keeffe on 23/06/2016.
//  Copyright © 2016 Cillian O'Keeffe. All rights reserved.
//
//
//  InvertedCollectionViewLayout.swift
//  InvertedCollectionViewLayout
//
//  Created by Cillian O'Keeffe on 23/06/2016.
//  Copyright © 2016 Cillian O'Keeffe. All rights reserved.
//

import UIKit

public protocol InvertedCollectionViewLayoutDelegate {
    
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat
    func insets(indexPath: NSIndexPath) -> UIEdgeInsets
}

public class InvertedCollectionViewLayout: UICollectionViewLayout {
    
    public var delegate: InvertedCollectionViewLayoutDelegate!
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var width: CGFloat { return CGRectGetWidth(collectionView!.bounds) }
    
    override public func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: width, height: contentHeight)
    }
    
    override public func prepareLayout() {
  
        if cache.isEmpty {
            
            var yOffset: CGFloat = 0
            
            for item in 0..<collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let cellHeight = self.delegate.heightForItemAtIndexPath(indexPath)
                
                let insets = self.delegate.insets(indexPath)
                
                let frame = CGRect(x: CGFloat(0) + insets.left,
                                   y: yOffset + insets.top,
                                   width: width - insets.left - insets.right,
                                   height: cellHeight)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                
                yOffset = yOffset + cellHeight + insets.top + insets.bottom
            }
        }
        
        self.collectionView!.contentOffset = CGPoint(x: 0, y: contentHeight)
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return cache.filter() {
            
            CGRectIntersectsRect($0.frame, rect)
        }
    }
}
