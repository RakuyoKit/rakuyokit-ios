//
//  File.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//

import UIKit

#if os(iOS)
import EpoxyCollectionView
import RAKCore

extension Extendable where Base: Sequence {
    public typealias EpoxySequenceTransform<SegmentOfResult: Sequence> = (Base.Element) throws -> SegmentOfResult
    
    @inlinable
    public func mapToSection<SegmentOfResult: Sequence>(
        @SectionModelBuilder _ transform: EpoxySequenceTransform<SegmentOfResult>
    ) rethrows -> [SegmentOfResult.Element] {
        try base.flatMap(transform)
    }
    
    @inlinable
    public func mapToItem<SegmentOfResult: Sequence>(
        @ItemModelBuilder _ transform: EpoxySequenceTransform<SegmentOfResult>
    ) rethrows -> [SegmentOfResult.Element] {
        try base.flatMap(transform)
    }
}
#endif
