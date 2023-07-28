//
//  ViewController.swift
//  CollorizedApp
//
//  Created by Екатерина Кузнецова on 28.07.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
    }


    @IBAction func redSliderAction() {
        let roundedValue = round(redSlider.value * 100) / 100
        redValueLabel.text = roundedValue.formatted()
        changeSliderColor()
    }
    
    @IBAction func greenSliderAction() {
        let roundedValue = round(greenSlider.value * 100) / 100
        greenValueLabel.text = roundedValue.formatted()
        changeSliderColor()
    }
    
    @IBAction func blueSliderAction() {
        let roundedValue = round(blueSlider.value * 100) / 100
        blueValueLabel.text = roundedValue.formatted()
        changeSliderColor()
    }
    
    private func changeSliderColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}
