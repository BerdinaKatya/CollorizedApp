//
//  ViewController.swift
//  CollorizedApp
//
//  Created by Екатерина Кузнецова on 28.07.2023.
//

import UIKit

final class EditColorViewController: UIViewController {
    // MARK: - IB Outlet
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    // MARK: - Public Properties
    var color: UIColor!
    weak var delegate: EditColorViewControllerDelegate?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        colorView.backgroundColor = color
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redValueTF, greenValueTF, blueValueTF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redValueTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenValueTF)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueValueTF)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        delegate?.setColor(from: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}
    // MARK: - Private Methods
extension EditColorViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: label.text = string(from: redSlider)
            case greenValueLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF: textField.text = string(from: redSlider)
            case greenValueTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: color)
        colorSliders.forEach { colorSlider in
            switch colorSlider {
            case redSlider: colorSlider.value = Float(ciColor.red)
            case greenSlider: colorSlider.value = Float(ciColor.green)
            default: colorSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
    

// MARK: - UITextFieldDelegate
extension EditColorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem (
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(withTitle: "Wrong format", andMessage: "Please enter correct value")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Wrong format",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redValueTF:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redValueLabel)
        case greenValueTF:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueValueLabel)
        }
        
        setColor()
    }

}

