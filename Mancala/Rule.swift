//
//  Rule.swift
//  HomeWork2
//
//  Created by User06 on 2023/4/8.
//

import SwiftUI

struct Rule: View {
    @Binding var showRule: Bool
    
    let Arr = ["遊戲目標是讓靠近自己這排的右邊大洞裝滿愈多的寶石，遊戲結束時將比較雙方大洞的寶石數量。","一開始每人有 24 顆寶石，一個小洞裝 4 顆。","輪到玩家的回合時，玩家可移動自己某個小洞的寶石。(大洞的寶石無法移動，大洞的寶石數量代表分數）","玩家移動的最後一顆寶石落在自己的大洞時，可以再次移動自己小洞的寶石。","寶石移動時不可落在對手的大洞，若遇到對手的大洞，請視而不見跳過。","玩家移動的最後一顆寶石落在自己空的小洞，而且此洞的對面也有寶石時，兩個洞的寶石將被收到玩家的大洞，開心地進補大量分數。","當某一邊的小洞沒有寶石時遊戲結束，此時畫面上小洞的寶石也會成為分數，它們將全部移動到大洞。","大洞裡寶石較多的玩家獲勝。"]
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 940, height: 430, alignment: .center)
            VStack{
                /*ForEach (0..<10) { i in
                    Text("\(Arr[i])")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .truncationMode(.head)
                }*/
                Text("遊戲目標是讓靠近自己這排的右邊大洞裝滿愈多的寶石，遊戲結束時將比較雙方大洞的寶石數量。一開始每人有 24 顆寶石，一個小洞裝 4 顆。輪到玩家的回合時，玩家可移動自己某個小洞的寶石。(大洞的寶石無法移動，大洞的寶石數量代表分數）玩家移動的最後一顆寶石落在自己的大洞時，可以再次移動自己小洞的寶石。寶石移動時不可落在對手的大洞，若遇到對手的大洞，請視而不見跳過。玩家移動的最後一顆寶石落在自己空的小洞，而且此洞的對面也有寶石時，兩個洞的寶石將被收到玩家的大洞，開心地進補大量分數。當某一邊的小洞沒有寶石時遊戲結束，此時畫面上小洞的寶石也會成為分數，它們將全部移動到大洞。大洞裡寶石較多的玩家獲勝。")
                    .foregroundColor(.blue)
                    .bold()
                    .frame(width: 400, height: 800, alignment: .leading)
                
                Button("HOME"){
                    showRule = false
                }
                .padding(10)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            }
        }
    }
}

struct Rule_Previews: PreviewProvider {
    static var previews: some View {
        Rule(showRule: .constant(true))
    }
}
