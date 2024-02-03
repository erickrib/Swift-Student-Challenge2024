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
                        codeEditorViewModel.runCode()
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
                            
                            if (codeEditorViewModel.selectedLineIndex == index) && index == 0 && codeEditorViewModel.touchPosition < 0.3 {
                                CursorView()
                            }
                            
                            Text(codeEditorViewModel.codeLines[index].code)
                                .font(.system(size: 28))
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                            
                            if codeEditorViewModel.selectedLineIndex == index && index > 0 {
                                CursorView()
                            }
                            
                            if codeEditorViewModel.selectedLineIndex == index && index == 0 && codeEditorViewModel.touchPosition > 0.3  {
                                CursorView()
                            }
                            
                            if codeEditorViewModel.codeLines[index].bonus > 0 {
                                BonusView(bonus: codeEditorViewModel.codeLines[index].bonus)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 5)
                        .background(codeEditorViewModel.selectedLineIndex == index ? Color.blue.opacity(0.3) : Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture { location in
                            handleLineSelection(index: index)
                            
                            let textWidth = measureTextWidth(text: codeEditorViewModel.codeLines[index].code, fontSize: 32)
                            codeEditorViewModel.touchPosition = location.x / textWidth
                            
                        }
                    }
                }
                
            }
            .padding([.leading, .trailing], 20)
            .frame(maxHeight: .infinity, alignment: .top)
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
    
    private func measureTextWidth(text: String, fontSize: CGFloat) -> CGFloat {
            let font = UIFont.systemFont(ofSize: fontSize)
            let attributes = [NSAttributedString.Key.font: font]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            let textSize = attributedText.size()
            return textSize.width
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
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
    }
}

struct BonusView: View {
    let bonus: Double

    var body: some View {
        HStack {
            Text("//")
                .font(.system(size: 22))
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))

            if bonus > 0 {
                let percentageBonus = Int(bonus * 100)
                
                Text("+\(percentageBonus)%")
                    .font(.system(size: 18))
                    .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

#Preview {
    CodeEditorView()
}
