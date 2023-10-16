//
//  OScreenTimeLimitPicker.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

final class OScreenTimeLimitPicker: UIView {
    lazy var pickerView = makePickerView()
    
    private lazy var hours = Array(0...24)
    private lazy var minutes = Array(0...59)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension OScreenTimeLimitPicker {
    var totalMinutes: Int {
        let hour = hours[pickerView.selectedRow(inComponent: 0)]
        let minutes = minutes[pickerView.selectedRow(inComponent: 1)]
        return (hour * 60) + minutes
    }
}

// MARK: UIPickerViewDataSource
extension OScreenTimeLimitPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        } else if component == 1 {
            return pickerView.selectedRow(inComponent: 0) == (hours.count - 1) ? 1 : minutes.count
        }
        
        return 0
    }
}

// MARK: UIPickerViewDelegates
extension OScreenTimeLimitPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        64.scale
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var cell = view
        
        if cell == nil {
            cell = ScreenTimeLimitPickerCell()
            cell?.backgroundColor = UIColor.clear
        }
        
        var value = ""
        
        if component == 0 {
            let hour = hours[row]
            if hour >= 10 {
                value = "\(hour)"
            } else {
                value = "0\(hour)"
            }
        } else if component == 1 {
            let minute = pickerView.selectedRow(inComponent: 0) == (hours.count - 1) ? 0 : minutes[row]
            if minute >= 10 {
                value = "\(minute)"
            } else {
                value = "0\(minute)"
            }
        }
        
        (cell as? ScreenTimeLimitPickerCell)?.setup(value: value)
        
        return cell!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let minutesCount = pickerView.numberOfRows(inComponent: 1)
            if row == (hours.count - 1) && minutesCount > 1 {
                pickerView.reloadComponent(1)
            } else if row != (hours.count - 1) && minutesCount == 1 {
                pickerView.reloadComponent(1)
            }
        }
    }
}

// MARK: Private
private extension OScreenTimeLimitPicker {
    func initialize() {
        pickerView.selectRow(4, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
    }
}

// MARK: Make constraints
private extension OScreenTimeLimitPicker {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OScreenTimeLimitPicker {
    func makePickerView() -> UIPickerView {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
