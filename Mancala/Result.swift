//
//  Result.swift
//  HomeWork2
//
//  Created by User06 on 2023/4/9.
//

import SwiftUI

struct Result: View {
    
    @State var firstpage = false
    @State var again = false
    @State var replay = false
    @State var home = false
    
//    @Binding var showResult: Bool
//    @Binding var showHuman: Bool
//    @Binding var showComputer: Bool
    @Binding var show: Bool
    @Binding var computer_friend: Bool
    @Binding var p1win: Bool
    @Binding var tie: Bool
    @Binding var player1_score: Int
    @Binding var player2_score: Int
    
    @State var pocket: [Int] = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0] //0-13
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 940, height: 430, alignment: .center)
            VStack{
                Spacer()
                if tie{
                    Text("DRAW")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .bold()
                }
                else if !computer_friend{
                    Text(p1win ? "PLAYER 1 WIN!" : "PLAYER 2 WIN!")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .bold()
                }
                else{
                    Text(p1win ? "YOU WIN!" : "YOU LOSE!")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .bold()
                }
                Spacer()
                HStack{
                    Text(computer_friend ? "YOU:\(player1_score)" : "P1 :\(player1_score)")
                        .frame(width: 150, height: 40, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5.0)
                        .onTapGesture {
                            print(player1_score)
                        }
                    Text(computer_friend ? "AI:\(player2_score)" : "P2 :\(player2_score)")
                        .frame(width: 150, height: 40, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5.0)
                        .onTapGesture {
                            print(player2_score)
                        }
                }
                Spacer()
                HStack{
                    Button("Play Again"){
                        replay = true
                    }
                    .fullScreenCover(isPresented: $replay, content: {
                        if !computer_friend {
                            Human(showHuman: $replay)
                        }
                        else{
                            Computer(showComputer: $replay)
                        }
                    })
                    .foregroundColor(Color.white)
                    .font(.title)
                    .frame(width: 150,height: 40)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(5)
                    Button("Home"){
                        home.toggle()
                    }
                    .fullScreenCover(isPresented: $home, content: {
                        ContentView()
                    })
                    .foregroundColor(Color.white)
                    .font(.title)
                    .frame(width: 150,height: 40)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(5)
                }
            }
        }
        
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(show: .constant(true), computer_friend: .constant(true), p1win: .constant(true), tie: .constant(true), player1_score: .constant(0), player2_score: .constant(0))
    }
}
