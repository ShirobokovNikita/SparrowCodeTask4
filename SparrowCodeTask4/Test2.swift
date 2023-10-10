//
//  Test2.swift
//  SparrowCodeTask4
//
//  Created by Nikita Shirobokov on 10.10.23.
//

import SwiftUI

struct CustomPrimitiveButtonStyle: PrimitiveButtonStyle {
    @Binding var isAnimating: Bool
        @Binding var buttonColor: Color
        
        func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                if !isAnimating {
                    configuration.trigger()
                }
            }) {
                configuration.label
            }
            .scaleEffect(isAnimating ? 0.5 : 1.0) // Анимация масштабирования
//            .onAppear {
//                // При появлении кнопки, меняем цвет на синий
//                buttonColor = .blue
//            }
            .onChange(of: isAnimating) { newValue in
                if !newValue {
                    print("enter")
                    // По окончании анимации масштабирования меняем цвет на красный
                    buttonColor = .red
                }
            }
        }
}

struct Test2: View {
    @State private var isAnimating = false
       @State private var buttonColor = Color.blue

       var body: some View {
           Button(action: {
               // Запускаем анимацию масштабирования
               withAnimation(.easeOut(duration: 0.5)) {
                   isAnimating.toggle()
               } completion: {
                   isAnimating.toggle()
               }
           }) {
               Text("Нажми меня")
                   .padding()
                   .background(buttonColor)
                   .foregroundColor(.white)
                   .cornerRadius(8)
           }
           .buttonStyle(CustomPrimitiveButtonStyle(isAnimating: $isAnimating, buttonColor: $buttonColor))
       }
}



#Preview {
    Test2()
}
