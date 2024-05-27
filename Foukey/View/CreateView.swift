//
//  CreateView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct CreateView: View{
    @Environment(\.modelContext) private var context
    @Bindable var journey: Journey
    @State private var isNotesAreaShown: Bool = false
    @State private var isTagEditorShown = false
    
    var body: some View{
        VStack(alignment: .leading) {
            VStack(alignment:.leading){
                Text("🏡")
                    .font(.largeTitle)
                Text("오늘 하루에서 기억에 남는 장소는 어디인가요?")
                    .bold()
                Text("오늘 어떤 장소에서 시간을 보냈나요?")
                    .foregroundColor(.gray)
                    .bold()
                TextField("장소를 입력해주세요.", text: $journey.place)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
            VStack(alignment:.leading){
                Text("🍽️")
                    .font(.largeTitle)
                Text("오늘 먹은 음식 중 가장 맛있었던 음식은 무엇인가요?")
                    .bold()
                Text("오늘 먹었던 음식들을 떠올려보세요.")
                    .foregroundColor(.gray)
                    .bold()
                TextField("음식을 입력해주세요.", text: $journey.food)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
            VStack(alignment:.leading){
                Text("🫂")
                    .font(.largeTitle)
                Text("오늘 누구를 만났나요?")
                    .bold()
                Text("친구, 가족, 혹은 오늘 읽은 책의 작가도 좋아요.")
                    .foregroundColor(.gray)
                    .bold()
                TextField("사람의 이름을 입력해주세요.", text: $journey.person)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
            VStack(alignment:.leading){
                Text("📚")
                    .font(.largeTitle)
                Text("오늘 하루 중요한 물건은 무엇이었나요?")
                    .bold()
                Text("새로 산 물건이 있나요? 오늘 자주 사용한 물건은 무엇이었나요?")
                    .foregroundColor(.gray)
                    .bold()
                TextField("물건의 이름을 입력해주세요.", text: $journey.stuff)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
            HStack(alignment: .firstTextBaseline) {
                Text("태그:")
                
                FlowLayout(alignment: .leading) {
                    
                    ForEach(journey.tags) { tag in
                        TagCell(tag: tag)
                            .contextMenu {
                                Button(role: .destructive) {
                                    if let index = journey.tags.firstIndex(where: { $0.uuid == tag.uuid }) {
                                        journey.tags.remove(at: index)
                                    }
                                } label: {
                                    Text("Remove from journey")
                                }
                                
                            }
                    }
                }
                
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("메모:")
                Spacer()
                Button(isNotesAreaShown ? "Hide Notes" : "Show Notes") {
                        isNotesAreaShown.toggle()
                }
            }
                
            if isNotesAreaShown {
                TextEditor(text: $journey.notes)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(maxHeight: 100)
                    .border(Color.gray)
            }
        }
        .padding()
        .toolbar {
            ToolbarItemGroup {
                Button {
                    isTagEditorShown.toggle()
                } label: {
                    Image(systemName: "tag")
                }
                .popover(isPresented: $isTagEditorShown) {
                    AddTagToJourneysView(journey: journey)
                }
                Button(role: .destructive) {
                    Journey.delete(journey)
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ModelPreview { journey in
        NavigationStack {
            CreateView(journey: journey)
        }
    }
}


