//
//  StretchyHeaderFlowLayout.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

class StretchyHeaderFlowLayout: UICollectionViewFlowLayout {

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let layoutAttributes = super.layoutAttributesForElementsInRect(rect) {
            let insets = collectionView!.contentInset
            let minY = -insets.top
            // How far user scrolled
            let offset = collectionView!.contentOffset
            if offset.y < minY {
                let deltaY = fabs(offset.y)
                for attributes in layoutAttributes {
                    if let elementKind = attributes.representedElementKind {
                        if elementKind == UICollectionElementKindSectionHeader {
                            var frame = attributes.frame
                            frame.size.height = max(minY, headerReferenceSize.height + deltaY)
                            frame.origin.y = CGRectGetMinY(frame) - deltaY
                            attributes.frame = frame
                        }
                    }
                }
            }
            return layoutAttributes
        }
        return nil
    }
}
