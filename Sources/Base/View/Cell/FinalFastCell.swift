//
//  FinalFastCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

/// Used directly in certain scenarios as a replacement for `UITableViewCell`.
public final class FastTableViewCell: BaseTableViewCell, FastCell { }

/// Used directly in certain scenarios as a replacement for `UICollectionViewCell`.
public final class FastCollectionViewCell: BaseCollectionViewCell, FastCell { }
#endif
