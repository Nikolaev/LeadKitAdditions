//
//  Copyright (c) 2018 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit.UIGeometry
import LeadKit

/// Default view model for LabelTableViewCell.
open class LabelCellViewModel {

    public let viewText: ViewText
    public let contentBackground: ViewBackground
    public let contentInsets: UIEdgeInsets
    public let labelInsets: UIEdgeInsets
    public let separatorType: CellSeparatorType

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - viewText: View text to configure label.
    ///   - contentBackground: View background to configure background.
    ///   - contentInsets: Content insets to use for layout whole content.
    ///   - labelInsets: Label insets to use for layout label.
    ///   - separatorType: Separator type to use for separators.
    public init(viewText: ViewText,
                contentBackground: ViewBackground = .color(.clear),
                contentInsets: UIEdgeInsets = UIEdgeInsets.zero,
                labelInsets: UIEdgeInsets = UIEdgeInsets.zero,
                separatorType: CellSeparatorType = .none) {

        self.viewText = viewText
        self.contentBackground = contentBackground
        self.contentInsets = contentInsets
        self.labelInsets = labelInsets
        self.separatorType = separatorType
    }

}
