//
//  HomeViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/12.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView! {
        didSet {
            chartView.usePercentValuesEnabled = true
            chartView.drawSlicesUnderHoleEnabled = false
            chartView.holeRadiusPercent = 0.58
            chartView.transparentCircleRadiusPercent = 0.61
            chartView.chartDescription?.enabled = false
            chartView.setExtraOffsets(left: 5.0, top: 10.0, right: 5.0, bottom: 5.0)
            chartView.drawCenterTextEnabled = true
            
            chartView.centerText = "销售额1680元"
            chartView.drawHoleEnabled = true
            chartView.rotationAngle = 0.0
            chartView.rotationEnabled = true
            chartView.highlightPerTapEnabled = true
            
            let l = chartView.legend
            l.horizontalAlignment = .right
            l.verticalAlignment = .top
            l.orientation = .vertical
            l.drawInside = false
            l.xEntrySpace = 7.0
            l.yEntrySpace = 0.0
            l.yOffset = 0.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(index: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadData(index: Int) {
        var values: [PieChartDataEntry] = []
        
        if index == 0 {
            let entry0 = PieChartDataEntry(value: 10.0, label: "零食")
            values.append(entry0)
            let entry1 = PieChartDataEntry(value: 30.0, label: "日用品")
            values.append(entry1)
            let entry2 = PieChartDataEntry(value: 40.0, label: "饮料")
            values.append(entry2)
            let entry3 = PieChartDataEntry(value: 50.0, label: "水果")
            values.append(entry3)
            let entry4 = PieChartDataEntry(value: 15.0, label: "杂货")
            values.append(entry4)
        } else {
            let entry0 = PieChartDataEntry(value: 10.0, label: "必和必拓")
            values.append(entry0)
            let entry1 = PieChartDataEntry(value: 30.0, label: "力拓")
            values.append(entry1)
            let entry2 = PieChartDataEntry(value: 40.0, label: "淡水河谷")
            values.append(entry2)
            let entry3 = PieChartDataEntry(value: 50.0, label: "Halcyon")
            values.append(entry3)
        }
        
        
        let dataSet = PieChartDataSet(values: values, label: "")
        dataSet.sliceSpace = 2.0
        dataSet.iconsOffset = CGPoint(x: 0, y: 40)
        
        var colors: [NSUIColor] = []
        
        colors.append(contentsOf: ChartColorTemplates.vordiplom())
        colors.append(contentsOf: ChartColorTemplates.joyful())
        colors.append(contentsOf: ChartColorTemplates.colorful())
        colors.append(contentsOf: ChartColorTemplates.liberty())
        colors.append(contentsOf: ChartColorTemplates.pastel())
        colors.append(NSUIColor(colorLiteralRed: 51.0/255.0, green: 181.0/255.0, blue: 229.0/255.0, alpha: 1.0))
        
        dataSet.colors = colors
        
        let data = PieChartData(dataSet: dataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = " %"
        
        let dFormatter = DefaultValueFormatter(formatter: pFormatter)
        data.setValueFormatter(dFormatter)
        
        chartView.data = data
        chartView.highlightValues(nil)
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }

}
