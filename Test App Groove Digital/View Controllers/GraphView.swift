//
//  GraphView.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation
import Macaw

class GraphView: MacawView {
    
    private var backgroundGroup = Group()
    private var mainGroup = Group()
    private var captionsGroup = Group()
    private var nbPlays = Group()
    private var info = Group()
    
    private var barsCount = 1
    private let barsSpacing = 10
    private let barWidth = 7
    private let barHeight = 200
    
    
    private var barAnimations = [Animation]()
    private var barsValues: [Int] = []
    private var barsCaptions: [String] = []
    
    private let emptyBarColor = Color.rgba(r: 0, g: 74, b: 128, a: 0.5)
    private let gradientColor = LinearGradient(degree: 90, from: Color(val: 0xfc0c7e), to: Color(val: 0xffd85e))
    
    open var completionCallback: (() -> ()) = { }
    
    func showGraphAnalytics(dateChosen: String?){
        
        if let date = dateChosen {
            barsValues = []
            barsCaptions = []
            createBarValues(selectedDate: date)
        }
        
    }
    
    private func createBarValues(selectedDate: String?){
        //check if selected date is nil
        if selectedDate == nil {
            return
        }
        NetworkManager.request(router: Router.getVideoAnalytics(date: selectedDate!)) { (response, result) in
            switch result {
            case .success:
                if response.count == 0 {
                    return
                }
                
                for dataPoint in response {
                    self.barsValues.append(dataPoint!.nbPlays)
                    let timeInt = Int(dataPoint!.time.replacingOccurrences(of: "h", with: ""))! + 1
                    self.barsCaptions.append(String(timeInt))
                }
                
                print(self.barsValues.count)
                self.barsCount = self.barsValues.count

                self.setupScene()
                self.setupAnimation()
                self.barAnimations.sequence().onComplete {
                    self.completionCallback()
                }.play()
            default: break
                //Error
            }
        }
    }
    
    private func setupAnimation(){
        barAnimations.removeAll()
        for (index, node) in mainGroup.contents.enumerated() {
            if let group = node as? Group {
                let heightValue = self.barHeight / 100 * barsValues[index]
                let animation = group.contentsVar.animation({ t in
                    let value = Double(heightValue) / 100 * (t * 100)
                    let barShape = Shape(
                        form: RoundRect(
                            rect: Rect(
                                x: Double(index * (self.barWidth + self.barsSpacing)),
                                y: Double(self.barHeight) - Double(value),
                                w: Double(self.barWidth),
                                h: Double(value)
                            ),
                            rx: 5,
                            ry: 5
                        ),
                        fill: self.gradientColor
                    )
                    return [barShape]
                }, during: 0.1, delay: 0).easing(Easing.easeInOut)
                barAnimations.append(animation)
            }
        }
    }
    private func setupScene(){
        let viewCenterX = Double(self.frame.width / 2)
        
        let barsWidth = Double((barWidth * barsCount) + (barsSpacing * (barsCount - 1)))
        let barsCenterX = viewCenterX - barsWidth / 2
        
        let text = Text(
            text: "Groove Digital Inc. Analytics",
            font: Font(name: "Valera Round", size: 22),
            fill: Color(val: 0xFFFFFF)
        )
        text.align = .mid
        text.place = .move(dx: viewCenterX, dy: 30)
        
        backgroundGroup = Group()
        
        for barIndex in 0...barsCount - 1 {
            let barShape = Shape(
                form: RoundRect(
                    rect: Rect(
                        x: Double(barIndex * (barWidth + barsSpacing)),
                        y: 0,
                        w: Double(barWidth),
                        h: Double(barHeight)
                    ),
                    rx: 5,
                    ry: 5
                ),
                fill: emptyBarColor
            )
            backgroundGroup.contents.append(barShape)
        }
        
        mainGroup = Group()
        mainGroup.accessibilityScroll(.right)
        for barIndex in 0...barsCount - 1 {
            let barShape = Shape(
                form: RoundRect(
                    rect: Rect(
                        x: Double(barIndex * (barWidth + barsSpacing)),
                        y: Double(barHeight),
                        w: Double(barWidth),
                        h: Double(0)
                    ),
                    rx: 5,
                    ry: 5
                ),
                fill: gradientColor
            )
            mainGroup.contents.append([barShape].group())
        }
        
        backgroundGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        mainGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        
        captionsGroup = Group()
        captionsGroup.place = Transform.move(
            dx: barsCenterX,
            dy: 100 + Double(barHeight)
        )
        
        for barIndex in 0...barsCount - 1 {
            let text = Text(
                text: barsCaptions[barIndex],
                font: Font(name: "Serif", size: 14),
                fill: Color(val: 0xFFFFFF)
            )
            text.align = .mid
            text.place = .move(
                dx: Double((barIndex * (barWidth + barsSpacing)) + barWidth / 2),
                dy: 0
            )
            captionsGroup.contents.append(text)
        }
        
        nbPlays = Group()
        nbPlays.place = Transform.move(
            dx: barsCenterX,
            dy: 70
        )
        
        for barIndex in 0...barsCount - 1 {
            let text = Text(
                text: "\(barsValues[barIndex])",
                font: Font(name: "Serif", size: 14),
                fill: Color(val: 0xFFFFFF)
            )
            text.align = .mid
            text.place = .move(
                dx: Double((barIndex * (barWidth + barsSpacing)) + barWidth / 2),
                dy: 0
            )
            nbPlays.contents.append(text)
        }
        
        let information = Text(
            text: "Hours - 24hrs",
            font: Font(name: "Valera Round", size: 18),
            fill: Color(val: 0xFFFFFF)
        )
        
        information.align = .mid
        information.place = .move(dx: viewCenterX, dy: 350)
        
        self.node = [text, backgroundGroup, mainGroup, captionsGroup, nbPlays, information].group()
        self.backgroundColor = UIColor(cgColor: Color(val: 0x2f95de).toCG())
    }
    
}
