//
//  InvertedCollectionViewLayout.swift
//  InvertedCollectionViewLayout
//
//  Created by Cillian O'Keeffe on 23/06/2016.
//  Copyright © 2016 Cillian O'Keeffe. All rights reserved.
//
//

import UIKit

public protocol InvertedCollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
    func collectionView(collectionView: UICollectionView, insetsForItemAtIndexPath indexPath: NSIndexPath) -> UIEdgeInsets
}

public class InvertedCollectionViewLayout: UICollectionViewLayout {
    
    public var delegate: InvertedCollectionViewLayoutDelegate!
    
    // MARK: - Private Variables
    
    private var hasBeenLayedOut = false
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var width: CGFloat {
        
        return CGRectGetWidth(collectionView!.bounds)
    }
    
    // UICollectionViewLayout Overrides
    
    override public func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: width, height: contentHeight)
    }
    
    override public func invalidateLayoutWithContext(context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayoutWithContext(context)
        
        cache.removeAll()
        contentHeight = 0
    }
    
    override public func prepareLayout() {
  
        if cache.isEmpty {
            
            // the cell's origin offset on the yAxis
            var yOffset: CGFloat = 0

            for item in (collectionView!.numberOfItemsInSection(0) - 1).stride(through: 0, by: -1) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let height = self.delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                let insets = self.delegate.collectionView(collectionView!, insetsForItemAtIndexPath: indexPath)
                
                let frame = CGRect(x: insets.left,
                                   y: yOffset + insets.top,
                                   width: width - insets.left - insets.right,
                                   height: height)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                
                yOffset = yOffset + height + insets.top + insets.bottom
            }
        }
        
        if !hasBeenLayedOut {
            self.collectionView!.contentOffset = CGPoint(x: 0, y: contentHeight)
            hasBeenLayedOut = true
        }
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return cache.filter() {
            
            CGRectIntersectsRect($0.frame, rect)
        }
    }
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        return self.cache[indexPath.row]
    }
    
    override public func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = self.cache[itemIndexPath.row]
        attributes.center = CGPoint(x: attributes.frame.width/2, y: contentHeight - attributes.frame.height/2)
        return attributes
    }
}
