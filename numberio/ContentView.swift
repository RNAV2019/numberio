//
//  ContentView.swift
//  numberio
//
//  Created by Ryan Navsaria on 09/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State var answer: String = "";
    @State var firstNumber: Int = Int.random(in: 5...10);
    @State var secondNumber: Int = Int.random(in: 1...5);
    @State var answerColour: Color = .primary;
    @State var disableButtons: Bool = false;
    @State var currentQuestion: Int = 1;
    @State var restart: Bool = false;
    @State var animateAnswer: Bool = false;
    @State var arithmeticSwitch: Bool = true;
    
    let gridNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "back", "0", "="];
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ];
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("\(firstNumber) \(arithmeticSwitch ? "+" : "-") \(secondNumber) = ")
                        .bold()
                        .font(.system(size: 55))
                    Text(answer)
                        .bold()
                        .underline()
                        .font(.system(size: 55))
                        .foregroundColor(answerColour)
                        .animation(.default.speed(2.0), value: animateAnswer)
                }
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(gridNumbers, id: \.self) {
                            value in ButtonCell(value: value, image: value == "back" ? true : false)
                                .onTapGesture {
                                    print("Value : \(value)")
                                    if (value == "=") {
                                        let generatedAnswer: String = arithmeticSwitch ? String(firstNumber + secondNumber) : String(firstNumber - secondNumber)
                                        print("Answer : \(generatedAnswer)")
                                        print("User Answer : \(answer)")
                                        if (generatedAnswer == answer) {
                                            answerColour = Color.green;
                                            animateAnswer = true;
                                            disableButtons = true;
                                            if (currentQuestion < 10) {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    answerColour = .primary;
                                                    animateAnswer = false;
                                                    currentQuestion += 1;
                                                    answer = "";
                                                    firstNumber = Int.random(in: 5...10);
                                                    secondNumber = Int.random(in: 1...5);
                                                    answerColour = .primary;
                                                    disableButtons = false;
                                                }
                                            } else {
                                                restart = true;
                                            }
                                        } else {
                                            answerColour = Color.red;
                                            animateAnswer = true;
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                answer = "";
                                                answerColour = .primary;
                                                animateAnswer = false;
                                            }
                                        }
                                    } else if (value != "back") {
                                        if (answer.count < 3 && disableButtons == false) {
                                            answer += value;
                                        }
                                    } else {
                                        if (disableButtons != true) {
                                            answer = String(answer.dropLast())
                                        }
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame(width: 400, height: 550)
                
                ProgressView(value: (Float(currentQuestion) / 10))
                    .frame(width: 350)
                    .padding(.vertical)
                    .animation(.default, value: Float(currentQuestion) / 10)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 30))
                    .padding()
                    .clipShape(Circle())
                    .opacity(restart ? 1 : 0)
                    .onTapGesture {
                        if (restart) {
                            restart = false;
                            currentQuestion = 1;
                            answer = "";
                            firstNumber = Int.random(in: 5...10);
                            secondNumber = Int.random(in: 1...5);
                            answerColour = .primary;
                            disableButtons = false;
                        }
                    }
            }
            .scaledToFill()
            VStack {
                Text("+")
                    .bold()
                    .font(.system(size: 35))
                    .padding(.vertical)
                Toggle(isOn: $arithmeticSwitch) {
                    
                }
                .disabled(disableButtons)
                .rotationEffect(Angle(degrees: 270))
                .frame(width: 20)
                .scaleEffect(1.4)
                .padding(.vertical)
                Text("-")
                    .bold()
                    .font(.system(size: 35))
                    .padding(.vertical)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
