//
//  SparrowVariant.swift
//  SparrowCodeTask4
//
//  Created by Nikita Shirobokov on 14.10.23.
//

import SwiftUI

struct SparrowVariant: View {
    var body: some View {
        ForwardButton()
            .buttonStyle(PressButtonStyle())
    }
}

struct ForwardButton: View {
    
    @State private var performAnimation = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                    print("true")
                } completion: {
                    performAnimation = false
                    print("false")
                }
            }
        } label: {
            GeometryReader { proxy in
                
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 65)
    }
}

struct PressButtonStyle: ButtonStyle {
    
    @State private var isProcessingPressBackground: Bool = false
    
    let duraton: TimeInterval = 0.22
    let scale: CGFloat = 0.86
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.secondary)
                .opacity(isProcessingPressBackground ? 0.3 : 0)
            configuration.label
                .padding(12)
        }
        .scaleEffect(isProcessingPressBackground ? scale : 1)
        .animation(.easeOut(duration: duraton), value: configuration.isPressed)
        .onChange(of: configuration.isPressed) { newValue in
            if newValue {
                withAnimation(.easeOut(duration: duraton)) {
                    isProcessingPressBackground = true
                }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duraton) {
                        withAnimation(.easeOut(duration: duraton)) {
                            isProcessingPressBackground = false
                        }
                    }
                }
            }
        }
    }

#Preview {
    SparrowVariant()
}
