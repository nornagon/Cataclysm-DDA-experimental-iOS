//
//  PageUpDownPanGestureRecognizer.swift
//  CDDA
//
//  Created by Аполлов Юрий Андреевич on 08.02.2021.
//  Copyright © 2021 Аполлов Юрий Андреевич. All rights reserved.
//

import UIKit


public class PageUpDownPanGestureRecognizer : UIPanGestureRecognizer
{
    @IBOutlet public var viewToHighlight: UIView?
    @IBOutlet public var rootView: UIView?
}
