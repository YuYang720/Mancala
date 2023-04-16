//
//  Human.swift
//  HomeWork2
//  non copy
//  Created by User06 on 2023/4/8.
//

import SwiftUI

struct Human: View {
    @Binding var showHuman: Bool
    //@Binding var show: Bool
    //@Binding var showResult: Bool
    @State var current_player = 1
    @State var pocket: [Int] = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
    @State var NZC: [Int] = [6, 6]
    @State var non_zero_count: [Int] = [6, 6]
    
    @State var backhome = false
    @State var endd = false
    @State var computer_firend = false
    @State var set = false
    @State var p1win = false
    @State var p1lose = false
    @State var tie = false
    @State var rev = false
    
    
    private func move_stone(index: Int){
        var unmove_stone = pocket[index]
        pocket[index] = 0
        var current_id = index
        while(unmove_stone != 0){   // 逆時針
            if(current_id <= 13){
                current_id += 1
                if(current_id == 14){
                    current_id = 0
                }
            }

            if((current_player==1 && current_id==13) || (current_player==2 && current_id==6)){
                continue
            }
            pocket[current_id] += 1
            unmove_stone -= 1
        }
        // 自己最後為空，對面有寶石時吃掉
        if(pocket[current_id] == 1){
            if(current_player == 1 && current_id <= 5 && pocket[12-current_id] != 0){
                pocket[6] = pocket[6] + pocket[current_id] + pocket[12-current_id]
                pocket[current_id] = 0
                pocket[12-current_id] = 0
            }
            else if(current_player == 2 && current_id >= 7 && current_id <= 12 && pocket[12-current_id] != 0){
                pocket[13] = pocket[13] + pocket[current_id] + pocket[12-current_id]
                pocket[current_id] = 0
                pocket[12-current_id] = 0
            }
        }
        
        // 用非０個數倒著算，去掉初始值為０就進入的可能 每次檢查，全部為０再改值
        for k in 0...5{
            if (pocket[k] == 0){
                NZC[0] -= 1
            }
            if (pocket[12-k] == 0){
                NZC[1] -= 1
            }
        }
        for k in 0...1{
            if(NZC[k] == 0){
                non_zero_count[k] = 0
            }
            NZC[k] = 6
        }
        
        //  確認圓內無剩餘寶石 加上橢圓分數
        if((non_zero_count[0] == 0 || non_zero_count[1] == 0) && unmove_stone == 0){
            endd = true
            for i in 0...5{
                pocket[6] += pocket[i]
                pocket[i] = 0
                pocket[13] += pocket[12-i]
                pocket[12-i] = 0
            }
            if(pocket[6] > pocket[13]){
                p1win = true
            }
            else if (pocket[6] == pocket[13]){
                tie = true
            }
            else{
                p1win = false
            }
            // pocket[0...13] = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
            // showResult = true
        }
        
        if(current_player == 1 && current_id != 6){
            current_player = 2
        }
        else if(current_player == 2 && current_id != 13){
            current_player = 1
        }
    }
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 940, height: 430, alignment: .center)
            VStack(alignment: .center, spacing: 25){
                Text("Current Player: \(current_player)")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                HStack(alignment: .center, spacing: 30){
                    VStack(alignment: .center, spacing: 20){
                        //Text("Player 1")
                        ForEach(0..<6){ i in
                            HStack{
                                Text("\(pocket[i])")
                                    .foregroundColor(((current_player == 1 && pocket[i] != 0) ? Color.red : .blue))
                                    .font(.title2)
                                ZStack{
                                    Circle()
                                        .stroke(((current_player == 1 && pocket[i] != 0) ? Color.red : .blue), lineWidth: 3.0)
                                        .frame(width: 90, height: 90, alignment: .center)
                                        .fullScreenCover(isPresented: $endd, content: {
                                            Result(show: $showHuman, computer_friend: $computer_firend, p1win: $p1win, tie: $tie, player1_score: $pocket[6], player2_score: $pocket[13])
                                        })
                                        .onTapGesture {
                                            if(current_player == 1 && pocket[i] != 0 && (non_zero_count[0] != 0 && non_zero_count[1] != 0)){
                                                move_stone(index: i)
                                            }
                                        }
                                    ForEach(0..<pocket[i], id:\.self){ j in
                                        if(pocket[i] != 0){
                                            Image("cat\(j%7)")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .offset(x: CGFloat.random(in: -30...30), y: CGFloat.random(in: -30...30))
                                        }
                                    }
                                }
                            }
                        }
                        HStack(alignment: .center){
                            Text("\(pocket[6])")
                                .foregroundColor(((current_player == 1 && pocket[6] != 0) ? Color.red : .blue))
                                .font(.title2)
                            ZStack{
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.blue, lineWidth: 3.0)
                                    .frame(width: 160, height: 90, alignment: .center)
                                ForEach(0..<pocket[6], id:\.self){ j in
                                    if(pocket[6] != 0){
                                        Image("cat\(j%7)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -30...30))
                                    }
                                }
                            }
                        }
                    }
                    VStack(alignment: .center, spacing: 20){
                        //Text("Player 2")
                        HStack(alignment: .center){
                            ZStack{
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.blue, lineWidth: 3.0)
                                    .frame(width: 160, height: 90, alignment: .center)
                                ForEach(0..<pocket[13], id:\.self){ j in
                                    if(pocket[13] != 0){
                                        Image("cat\(j%7)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -30...30))
                                    }
                                }
                            }
                            Text("\(pocket[13])")
                                .foregroundColor(((current_player == 1 && pocket[13] != 0) ? Color.red : .blue))
                                .font(.title2)
                        }
                        /*for i in stride(from: 12, through: 7, by: -1)*/
                        
                        ForEach(7..<13){ i in
                            HStack{
                                ZStack{
                                    Circle()
                                        .stroke(((current_player == 2 && pocket[19-i] != 0) ? Color.red: .blue), lineWidth: 3.0)
                                        .frame(width: 90, height: 90, alignment: .center)
                                        .fullScreenCover(isPresented: $endd, content: {
                                            Result(show: $showHuman, computer_friend: $computer_firend, p1win: $p1win, tie: $tie, player1_score: $pocket[6], player2_score: $pocket[13])
                                        })
                                        .onTapGesture {
                                            if(current_player == 2 && pocket[19-i] != 0 && (non_zero_count[0] != 0 && non_zero_count[1] != 0)){
                                                move_stone(index: 19-i)
                                            }
                                        }
                                    ForEach(0..<pocket[19-i], id:\.self){ j in
                                        if(pocket[19-i] != 0){
                                            Image("cat\(j%7)")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .offset(x: CGFloat.random(in: -30...30), y: CGFloat.random(in: -30...30))
                                        }
                                    }
                                }
                                
                                Text("\(pocket[19-i])")
                                    .foregroundColor(((current_player == 2 && pocket[19-i] != 0) ? Color.red : .blue))
                                    .font(.title2)
                            }
                        }
                    }
                }
                HStack(alignment: .center, spacing: 30){
                    Button("Home"){
                        backhome.toggle()
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .fullScreenCover(isPresented: $backhome, content: {
                        ContentView()
                    })
                    .padding(2)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct Human_Previews: PreviewProvider {
    static var previews: some View {
        Human(showHuman: .constant(true))
    }
}
