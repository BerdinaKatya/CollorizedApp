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
    
    // MARK: - Variables to transfer
    var color: UIColor!
    
    weak var delegate: EditColorViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        colorView.layer.cornerRadius = 20
        colorView.backgroundColor = color
        
        startSlider()
        changeSliderColor()
        
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        changeSliderColor()
        
        switch sender {
        case redSlider:
            redValueLabel.text = String(format: "%.2f", redSlider.value)
            redValueTF.text = String(format: "%.2f", redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
            greenValueTF.text = String(format: "%.2f", greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
            blueValueTF.text = String(format: "%.2f", blueSlider.value)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        view.endEditing(true)
        delegate?.setColor(from: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func changeSliderColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func startSlider() {
        redSlider.value = Float(color.rgbaValue.red)
        greenSlider.value = Float(color.rgbaValue.green)
        blueSlider.value = Float(color.rgbaValue.blue)
        
        redValueTF.text = String(format: "%.2f", redSlider.value)
        greenValueTF.text = String(format: "%.2f", greenSlider.value)
        blueValueTF.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.redValueTF.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension EditColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == redValueTF && checkTextValid(textField: redValueTF) {
            redValueLabel.text = redValueTF.text ?? ""
            redSlider.value = redValueTF.text.map { Float($0) ?? 0 } ?? 0
        } else if textField == greenValueTF && checkTextValid(textField: greenValueTF) {
            greenValueLabel.text = greenValueTF.text ?? ""
            greenSlider.value = greenValueTF.text.map { Float($0) ?? 0 } ?? 0
        } else if textField == blueValueTF && checkTextValid(textField: blueValueTF) {
            blueValueLabel.text = blueValueTF.text ?? ""
            blueSlider.value = blueValueTF.text.map { Float($0) ?? 0 } ?? 0
        }
        
        changeSliderColor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func checkTextValid(textField: UITextField) -> Bool {
        guard let inputText = textField.text, !inputText.isEmpty else { return true }
        
        let textPattern = "^(0(\\.\\d{1,2})?|1(\\.0{1,2})?)$"
        let isTextValid = NSPredicate(format: "SELF MATCHES %@", textPattern)
            .evaluate(with: inputText)
        
        if !isTextValid {
            showAlert(withTitle: "Wrong format", andMessage: "Please enter a number from 0.0 to 1.0")
            return false
        }
        return true
    }
}

