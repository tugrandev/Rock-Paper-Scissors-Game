//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Tuğran on 25.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var rpsArray = ["🪨", "📄", "✂️"]
    @State private var winOrLose = ["Win", "Lose"]
    @State private var alertTitle = ""
    @State private var showAlertofScore = false
    @State private var score = 0
    @State private var appsChoice = Int.random(in: 0...2)
    @State private var questionCount = 1
    @State private var winOrLoseChoice = Int.random(in: 0...1)
    @State private var showResult = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .yellow], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Spacer()
                Text("App's choice is")
                    .font(.largeTitle.bold())
                Text("\(rpsArray[appsChoice])")
                    .font(.system(size: 200))
                Text("Choose a move to \(winOrLose[winOrLoseChoice])")
                    .foregroundColor(.secondary)
                    .font(.title3.bold())
                HStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button("\(rpsArray[number])") {
                            if winOrLose[winOrLoseChoice] == "Win" {
                                buttonTappedWin(number)
                            } else {
                                buttonTappedLose(number)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.system(size: 75))
                    }
                }
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                Text("\(questionCount)/10")
                    .font(.title3.bold())
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .alert(Text(alertTitle), isPresented: $showAlertofScore) {
                Button("Next", action: newQuestion)
            }
            .alert(Text("Game over!"), isPresented: $showResult) {
                Button("New Game", action: newGame)
            } message: {
                Text("Your score was \(score)")
            }
        }
        
    }
    func buttonTappedLose(_ number: Int) {
        if rpsArray[appsChoice] == "🪨" && rpsArray[number] == "✂️" {
            alertTitle = "Correct"
            score += 10
        } else if rpsArray[appsChoice] == "📄" && rpsArray[number] == "🪨" {
            alertTitle = "Correct"
            score += 10
        } else if rpsArray[appsChoice] == "✂️" && rpsArray[number] == "📄" {
            alertTitle = "Correct"
            score += 10
        } else {
            alertTitle = "False"
            score -= 10
        }
        if questionCount == 10 {
            showResult = true
        } else {
            showAlertofScore = true
        }
    }
    func buttonTappedWin(_ number: Int) {
        if rpsArray[appsChoice] == "🪨" && rpsArray[number] == "📄" {
            alertTitle = "Correct"
            score += 10
        } else if rpsArray[appsChoice] == "📄" && rpsArray[number] == "✂️" {
            alertTitle = "Correct"
            score += 10
        } else if rpsArray[appsChoice] == "✂️" && rpsArray[number] == "🪨" {
            alertTitle = "Correct"
            score += 10
        } else {
            alertTitle = "False"
            score -= 5
        }
        if questionCount == 10 {
            showResult = true
        } else {
            showAlertofScore = true
        }
    }
    func newQuestion() {
        appsChoice = Int.random(in: 0...2)
        winOrLoseChoice = Int.random(in: 0...1)
        questionCount += 1
    }
    func newGame() {
        questionCount = 0
        score = 0
        newQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
