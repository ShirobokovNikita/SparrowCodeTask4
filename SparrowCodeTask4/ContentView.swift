//
//  SparrowVariant.swift
//  SparrowCodeTask4
//
//  Created by Nikita Shirobokov on 09.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var performAnimation = false
    @State private var performAnimation2 = false
    
    var body: some View {
        HStack(spacing: 65) {
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
                    
                    ZStack {
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
            }
            
            .frame(maxWidth: 65)
            //        .buttonStyle(CustomButtonStyle(performAnimation: $performAnimation))
            //        .modifier(CustomButtonStyle())
            .buttonStyle(PrimitiveScaleButton())
            Divider()
            Button {
                if !performAnimation2 {
                    withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                        performAnimation2 = true
                        print("true")
                    } completion: {
                        performAnimation2 = false
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
                            .frame(width: performAnimation2 ? width : .zero)
                            .opacity(performAnimation2 ? 1 : .zero)
                        Image(systemName: systemName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                        Image(systemName: systemName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: performAnimation2 ? 0.5 : width)
                            .opacity(performAnimation2 ? .zero : 1)
                    }
                    
                    .frame(maxHeight: .infinity, alignment: .center)
                }
            }
              
            
            .frame(maxWidth: 65)
            //        .buttonStyle(CustomButtonStyle(performAnimation: $performAnimation))
            //        .modifier(CustomButtonStyle())
            .buttonStyle(PrimitiveScaleButton2())

        }
    }
}

struct PrimitiveScaleButton: PrimitiveButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        ScaleButton(configuration: configuration, scaleAmount: 0.0)
    }

}

private extension PrimitiveScaleButton {
    
    struct ScaleButton: View {

        private enum ButtonGestureState {
            case inactive
            case pressing
            case outOfBounds

            var isPressed: Bool {
                switch self {
                case .pressing:
                    return true
                default:
                    return false
                }
            }
        }

        @Environment(\.isEnabled) var isEnabled
        @GestureState private var dragState = ButtonGestureState.inactive
        @State private var isPressed = false

        let configuration: PrimitiveScaleButton.Configuration
        let scaleAmount: CGFloat

        var body: some View {
            let dragGesture = DragGesture(minimumDistance: 0)
                .updating($dragState, body: { value, state, transaction in
                    let distance = sqrt(
                        abs(value.translation.height) + abs(value.translation.width)
                    )

                    if distance > 10 {
                        state = .outOfBounds
                    } else {
                        state = .pressing
                        print("pressing")
                    }
                })
                .onChanged({ value in
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isPressed = self.dragState.isPressed
                    }
                })
                .onEnded { _ in
                    if self.isPressed {
                        self.configuration.trigger()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut(duration: 1.22)) {
                            self.isPressed = self.dragState.isPressed
                        }
                    }
                    
                }

            return ZStack {
                            Circle()
                                .foregroundColor(.gray)
//                                .frame(width: 0)
                                .scaleEffect(isPressed  ? scaleAmount : 1.8)
                                .opacity(isPressed ? 0.3 : 0)
                            configuration.label
                                .gesture(dragGesture)
                                .foregroundColor(.blue)
//                                .opacity(isPressed ? 0.5 : 1.0)
                                .scaleEffect(isPressed ? scaleAmount : 1.0)
                        }
                
        }
    }
}

struct PrimitiveScaleButton2: PrimitiveButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        ScaleButton(configuration: configuration, scaleAmount: 0.86)
    }

}

private extension PrimitiveScaleButton2 {
    
    struct ScaleButton: View {

        private enum ButtonGestureState {
            case inactive
            case pressing
            case outOfBounds

            var isPressed: Bool {
                switch self {
                case .pressing:
                    return true
                default:
                    return false
                }
            }
        }

        @Environment(\.isEnabled) var isEnabled
        @GestureState private var dragState = ButtonGestureState.inactive
        @State private var isPressed = false

        let configuration: PrimitiveScaleButton.Configuration
        let scaleAmount: CGFloat

        var body: some View {
            let dragGesture = DragGesture(minimumDistance: 0)
                .updating($dragState, body: { value, state, transaction in
                    let distance = sqrt(
                        abs(value.translation.height) + abs(value.translation.width)
                    )

                    if distance > 10 {
                        state = .outOfBounds
                    } else {
                        state = .pressing
                        print("pressing")
                    }
                })
                .onChanged({ value in
                    withAnimation(.easeInOut(duration: 0.22)) {
                        self.isPressed = self.dragState.isPressed
                    }
                })
                .onEnded { _ in
                    if self.isPressed {
                        self.configuration.trigger()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            self.isPressed = self.dragState.isPressed
                        }
                    }
                    
                }

            return ZStack {
                
                Circle()
                    .foregroundColor(.gray)
                //                                .frame(width: 80)
                    .scaleEffect(isPressed  ? scaleAmount + 0.4 : 1.4)
                    .opacity(isPressed ? 0.3 : 0)
                configuration.label
                    .gesture(dragGesture)
                    .foregroundColor(.blue)
                //                                .opacity(isPressed ? 0.5 : 1.0)
                    .scaleEffect(isPressed ? scaleAmount : 1.0)
                
                        }
                
        }
    }
}

#Preview {
    ContentView()
}
