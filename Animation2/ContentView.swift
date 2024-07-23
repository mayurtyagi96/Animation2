//
//  ContentView.swift
//  Animation2
//
//  Created by Mayur  on 23/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")
    @State private var enabled2 = false
    @State private var dragAmount2 = CGSize.zero
    @State private var isShowingRed = false
    var body: some View {
        VStack{
            
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
                
            }
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Spacer()
            HStack(spacing: 0){
                ForEach(0..<letters.count, id: \.self){ num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled2 ? .blue : .red)
                        .offset(dragAmount2)
                        .animation(.linear.delay(Double(num) / 20), value: dragAmount2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ dragAmount2 = $0.translation})
                    .onEnded({ _ in
                        dragAmount2 = .zero
                        enabled2.toggle()
                    })
            )
            Spacer()
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged{ dragAmount = $0.translation }
                        .onEnded{ _ in
                            withAnimation(.bouncy){
                                dragAmount = .zero
                            }
                        }
                )
            Spacer()
            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .foregroundStyle(.white)
            .background(enabled ? .blue : .red)
            .animation(.default, value: enabled)
            .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
            .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
        }
    }
}

#Preview {
    ContentView()
}
