//
//  Test.swift
//  SparrowCodeTask4
//
//  Created by Nikita Shirobokov on 09.10.23.
//

import SwiftUI

struct CustomButtonStyle2: ButtonStyle {
    
    @Binding var performAnimation2: Bool
   
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(performAnimation2 ? 0.0 : 1.0) // Уменьшаем размер при нажатии
//            .opacity(isPressed ? 0.0 : 1.0)     // Уменьшаем прозрачность при нажатии
//            .animation(.easeInOut(duration: 0.6)) // Анимация
//
//            // Обрабатываем события нажатия кнопки
            .onTapGesture {
                withAnimation {
                    self.performAnimation2.toggle()
                }
//
//                // Симулируем длительное нажатие с помощью DispatchQueue (можно удалить, если не нужно)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation {
                        self.performAnimation2 = false
                    }
                }
            }
    }
}

struct Test: View {
    
    @State private var performAnimation2 = false
    
    var body: some View {
        Button
            {
                if !performAnimation2 {
                    withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                        performAnimation2 = true
                    } completion: {
                        performAnimation2 = false
                    }
                  
                }
            } label: {
            Text("Нажми меня")
                .padding()
                
                .background(performAnimation2 ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
        }
            
            .buttonStyle(CustomButtonStyle2(performAnimation2: $performAnimation2))
    }
}

#Preview {
    Test()
}
