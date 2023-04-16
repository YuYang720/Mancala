//
//  Computer.swift
//  HomeWork2
//
//  Created by User06 on 2023/4/8.
//

import SwiftUI

struct Computer: View {
    @Binding var showComputer: Bool
    @State var player_turn = true
    @State var computer_turn = false
    @State var onChange_flag = 0
    
    @State var pocket: [Int] = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
    @State var player1_score = 0
    @State var player2_score = 0
    @State var NZC: [Int] = [6, 6]
    @State var non_zero_count: [Int] = [6, 6]

    @State var computer_firend = true
    @State var endd = false
    @State var set = false
    @State var p1win = false
    @State var p1lose = false
    @State var tie = false
    
    
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
            if((player_turn && current_id==13) || (computer_turn && current_id==6)){
                continue
            }
            pocket[current_id] += 1
            unmove_stone -= 1
        }
        // 自己最後為空，對面有寶石時吃掉
        if(pocket[current_id] == 1){
            if(player_turn && current_id <= 5 && pocket[12-current_id] != 0){
                pocket[6] = pocket[6] + pocket[current_id] + pocket[12-current_id]
                pocket[current_id] = 0
                pocket[12-current_id] = 0
            }
            else if(computer_turn && current_id >= 7 && current_id <= 12 && pocket[12-current_id] != 0){
                pocket[13] = pocket[13] + pocket[current_id] + pocket[12-current_id]
                pocket[current_id] = 0
                pocket[12-current_id] = 0
            }
        }
        
        // 用非０個數倒著算，去掉初始值為０就進入的可能 每次檢查，全部為０再改值
        for k in 0...5{
            if pocket[k] == 0{
                NZC[0] -= 1
            }
            if pocket[k + 8] == 0{
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
        if(non_zero_count[0] == 0 || non_zero_count[1] == 0){
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
            // showResult = tru
        }
        
        if(player_turn && current_id != 6){
            computer_turn = true
            player_turn = false
        }
        else if(computer_turn && current_id != 13){
            player_turn = true
            computer_turn = false
        }
        onChange_flag += 1
    }
    
    private func computer_move(){
        var computer_index = 8   //pocket為０的話重新產生
        while((non_zero_count[0] != 0 && non_zero_count[1] != 0) && pocket[computer_index] == 0){ //應該用19-computer_index
            computer_index = Int.random(in: 7...12)
        }
        move_stone(index: computer_index)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 25){
            Text(player_turn ? "Your Turn": "Computer Turn")
                .font(.largeTitle)
                .foregroundColor(.black)
            HStack(alignment: .center, spacing: 30){
                VStack(alignment: .center, spacing: 20){
                    //Text("Player")
                    ForEach(0..<6){ i in
                        HStack{
                            Text("\(pocket[i])")
                            Circle()
                                .stroke(((player_turn && pocket[i] != 0) ? Color.red : .blue), lineWidth: 3.0)
                                .frame(width: 90, height: 90, alignment: .center)
                                .fullScreenCover(isPresented: $endd, content: {
                                    Result(show: $showComputer, computer_friend: $computer_firend, p1win: $p1win, tie: $tie, player1_score: $pocket[6], player2_score: $pocket[13])
                                })
                                .onTapGesture {
                                    if(player_turn && pocket[i] != 0 && (non_zero_count[0] != 0 && non_zero_count[1] != 0)){
                                        move_stone(index: i)
                                    }
                                }
                        }
                    }
                    HStack(alignment: .center){
                        Text("\(pocket[6])")
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.blue, lineWidth: 3.0)
                            .frame(width: 160, height: 90, alignment: .center)
                    }
                }
                VStack(alignment: .center, spacing: 20){
                    //Text("Computer")
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.blue, lineWidth: 3.0)
                            .frame(width: 160, height: 90, alignment: .center)
                        Text("\(pocket[13])")
                    }
                    /*for i in stride(from: 12, through: 7, by: -1)*/
                    
                    ForEach(7..<13){ i in
                        HStack{
                            Circle()
                                .stroke(((computer_turn && pocket[19-i] != 0) ? Color.red: .blue), lineWidth: 3.0)
                                .frame(width: 90, height: 90, alignment: .center)
                                .fullScreenCover(isPresented: $endd, content: {
                                    Result(show: $showComputer, computer_friend: $computer_firend, p1win: $p1win, tie: $tie, player1_score: $pocket[6], player2_score: $pocket[13])
                                })
                                .onTapGesture {
                                }
                            Text("\(pocket[19-i])")
                        }
                    }
                }
            }
            HStack(alignment: .center, spacing: 30){
                Button("Home"){
                    showComputer = false
                }
                .font(.title)
                .foregroundColor(.white)
                .padding(2)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            }
        }
        .onChange(of: onChange_flag){ newValue in
            if (computer_turn == true){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    computer_move()
                }
            }
        }
    }
    
}

struct Computer_Previews: PreviewProvider {
    static var previews: some View {
        Computer(showComputer: .constant(true))
    }
}

