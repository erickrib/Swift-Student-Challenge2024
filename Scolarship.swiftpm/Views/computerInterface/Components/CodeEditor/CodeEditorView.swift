//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct CodeEditorView: View {
    
    @EnvironmentObject var codeEditorViewModel: CodeEditorViewModel
    
    var body: some View {
        ZStack{
            Image("codeEditor")
                .resizable()
                .scaledToFill()
            
            VStack (alignment: .leading, spacing: 200){
                HStack{
                    Button(action: {
                        
                    }){
                        HStack {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 26, height: 24)
                            
                            Text("Run")
                                .foregroundColor(Color.white)
                        }
                        .padding(.all, 10.0)
                        .frame(width: 92, height: 45)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                    }
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        Text("\(codeEditorViewModel.ecopoints)")
                            .foregroundColor(Color.black)
                    }
                    .padding(.all, 10.0)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }
                .padding([.top], 25)
                
                VStack(alignment: .leading, spacing: 0){
                    ForEach(0..<codeEditorViewModel.codeLines.count, id: \.self) { index in
                        HStack(spacing: 0){
                            Text(codeEditorViewModel.codeLines[index].code)
                                .font(.system(size: 28))
                                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 2))
                            
                            if codeEditorViewModel.selectedLineIndex == index {
                                CursorView()
                            }
                            
                            Spacer()
                        }
                        .background(codeEditorViewModel.selectedLineIndex == index ? Color.blue.opacity(0.3) : Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            handleLineSelection(index: index)
                        }
                    }
                }
                
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .frame(maxHeight: .infinity)
        }
        .frame(width: SCENE_SIZE.width * 0.49, height: SCENE_SIZE.height * 0.77)
    }
    
    private func handleLineSelection(index: Int) {
        codeEditorViewModel.codeLines = codeEditorViewModel.codeLines.filter { !$0.code.isEmpty }
        if index >= codeEditorViewModel.codeLines.count{
            codeEditorViewModel.selectedLineIndex = index - 1
        } else {
            codeEditorViewModel.selectedLineIndex = index
        }
    }
}

struct CursorView: View {
    
    @State private var opacity: Double = 1.0
    
    var body: some View {
        Rectangle()
            .frame(width: 2, height: 27)
            .background(Color.black)
            .opacity(opacity)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever()) {
                    self.opacity = self.opacity == 0 ? 1 : 0
                }
                
            }
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 8))
    }
}

#Preview {
    CodeEditorView()
}
