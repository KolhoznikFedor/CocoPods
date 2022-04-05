//
//  ViewController.swift
//  DzCocoPods
//
//  Created by admin on 05.04.2022.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

final class ViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelWight: UILabel!
    @IBOutlet weak var colorChangeText: UISegmentedControl!
    @IBOutlet weak var colorChangeActivity: UISegmentedControl!
    @IBOutlet weak var viewWidth: UIStepper!
    @IBOutlet weak var viewHeight: UIStepper!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    var indexPicker: NVActivityIndicatorType = .audioEqualizer
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    var height = 30.0
    var weight = 30.0
    
    let oolors: [UIColor] = [.red, .yellow, .purple, .blue, .green]
    let oolorsText: [UIColor] = [.red, .yellow, .purple, .blue, .green]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        textView.delegate = self
    }
    
    @IBAction func actionWidth(_ sender: Any) {
        self.labelWight.text = "Width:  \((sender as! UIStepper).value )"
        weight = (sender as! UIStepper).value
    }
    
    @IBAction func actionHeight(_ sender: Any) {
        self.labelHeight.text = "Height:  \((sender as! UIStepper).value )"
        height = (sender as! UIStepper).value
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        startAnimating(
            CGSize(width: weight, height: height),
            message: textView.text,
            type: indexPicker,
            color: oolors[colorChangeActivity.selectedSegmentIndex],
            backgroundColor: .black,
            textColor: oolors[colorChangeText.selectedSegmentIndex]
        )
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating(nil)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presentingIndicatorTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let types = "\(presentingIndicatorTypes[row])"
        return types
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexPicker = presentingIndicatorTypes[row]
    }
    
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == textView {
            _ = textView.text.count > 5
        }
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
