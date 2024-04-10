//
//  FinalFastCell.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

#if !os(watchOS)
/// Used directly in certain scenarios as a replacement for `UITableViewCell`.
public final class FastTableViewCell: BaseTableViewCell, FastCell { }

/// Used directly in certain scenarios as a replacement for `UICollectionViewCell`.
public final class FastCollectionViewCell: BaseCollectionViewCell, FastCell { }
#endif
