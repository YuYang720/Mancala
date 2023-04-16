//
//  ContentView.swift
//  HomeWork2
//
//  Created by User06 on 2023/4/1.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showRule = false
    @State private var showHuman = false
    @State private var showComputer = false
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 940, height: 430, alignment: .center)
                
            VStack{
                Text("MANCALA")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
                Button("VS. Computer"){
                    showComputer = true
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .fullScreenCover(isPresented: $showComputer){
                    Computer(showComputer: $showComputer)
                }
                Button("VS. Friend"){
                    showHuman = true
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .fullScreenCover(isPresented: $showHuman){
                    Human(showHuman: $showHuman)
                }
                Button("How to play"){
                    showRule = true
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .fullScreenCover(isPresented: $showRule){
                    Rule(showRule: $showRule)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





