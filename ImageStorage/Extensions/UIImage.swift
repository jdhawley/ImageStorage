//
//  UIImage.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 8/7/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func toBinaryData() -> Data?{
        return pngData()
    }
}
