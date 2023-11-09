//
//  DisableTextField.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 29.09.2023.
//

import UIKit

final class DisableTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
}
