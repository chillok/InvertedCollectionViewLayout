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
    
    private var isFirstLaunch = true
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var width: CGFloat {
        
        return CGRectGetWidth(collectionView!.bounds)
    }
    
    override public func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: width, height: contentHeight)
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        
        cache.removeAll()
        contentHeight = 0
    }
    
    override public func prepareLayout() {
        
        let array = Array((collectionView!.numberOfItemsInSection(0) - 1).stride(through: 0, by: -1))
  
        if cache.isEmpty {
            
            var yOffset: CGFloat = 0

            for item in array {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let cellHeight = self.delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                let insets = self.delegate.collectionView(collectionView!, insetsForItemAtIndexPath: indexPath)
                
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
        
        if isFirstLaunch && !array.isEmpty {
            self.collectionView!.contentOffset = CGPoint(x: 0, y: contentHeight)
            isFirstLaunch = false
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