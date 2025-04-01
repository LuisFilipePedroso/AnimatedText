//
//  App.swift
//  AnimatedText
//
//  Created by Luis Filipe Pedroso on 31/03/25.
//

import SwiftUI

struct Main: View {
    @State private var titleProgress: CGFloat = 0
    @State private var initialAnimation: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Ready to get started?")
                    .font(.largeTitle.bold())
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(hue: 0.62, saturation: 0.4, brightness: 1.0),
                                Color(hue: 0.55, saturation: 0.3, brightness: 0.9),
                                Color(hue: 0.48, saturation: 0.2, brightness: 0.8)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .textRenderer(TitleTextRenderer(progress: titleProgress))
//                    .padding(.bottom, 8)
                Text("Sign up to personalize your experience")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary.opacity(0.9))
                    .tracking(0.4)
                    .blurOpacityEffect(initialAnimation)
                
                Button {
                    initialAnimation = false
                    titleProgress = 0
                    
                    Task {
                        try? await Task.sleep(for: .seconds(0.35))
                        
                        withAnimation(.smooth(duration: 0.75, extraBounce: 0).delay(1.3)) {
                            initialAnimation = true
                        }

                        withAnimation(.smooth(duration: 2.5, extraBounce: 0).delay(0.3)) {
                            titleProgress = 1
                        }
                    }
                } label: {
                    Text("I'm ready")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 12)
                        .background(.white, in: .capsule)
                }
                .padding(.top, 32)
                .blurOpacityEffect(initialAnimation)
            }
            .safeAreaPadding(15)
        }
        .task {
            try? await Task.sleep(for: .seconds(0.35))
            
            withAnimation(.smooth(duration: 0.75, extraBounce: 0).delay(1.3)) {
                initialAnimation = true
            }

            withAnimation(.smooth(duration: 2.5, extraBounce: 0).delay(0.3)) {
                titleProgress = 1
            }
        }
    }
}

extension View {
    func blurOpacityEffect(_ show: Bool) -> some View {
        self
            .blur(radius: show ? 0 : 2)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.9)
    }
}

#Preview {
    ContentView()
}
