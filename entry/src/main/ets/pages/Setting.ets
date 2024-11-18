


import {userPI, UserPreference, UserInterest} from '../utils/UserUtils';
/**
 * 修改用户偏好
 * TODO 1. 点击 修改 按钮后, 按钮有变化反馈, 同时焦点从输入框中离开.
 * TODO 2. 避免用户修改后忘记保存.
 * TODO 3. 类CSS的办法, 统一设置UI.
 * TODO 4. userInterest 的偏好关键词 (userPI.interestedKeyWords/ userPI.uninterestedKeyWords)
 */
@Component
export struct SettingPage {
  @Consume('pageStack') pageStack:NavPathStack;

  @State major:string = '';
  @State campus:string = '';
  @State grade:string = '';

  aboutToAppear(): void {
    const tmpPreference:UserPreference = userPI.getUserPreference();
    this.major = tmpPreference.major;
    this.campus = tmpPreference.campus;
    this.grade = tmpPreference.grade;
  }

  build() {
    Column() {
      NavDestination() {
        Column(){

          Row(){
            Text('专业')
              .margin({right: 10})
              .fontSize(20)
            TextInput({text: this.major})
              .width('60%')
              .onChange((value) => {this.major = value;})
              .onSubmit(() => {userPI.setUserPreference(this.major);})
            Button('修改')
              .onClick(() => {userPI.setUserPreference(this.major);})
          }
            .margin({top:10, left:15, right:15, bottom:10})

          Row(){
            Text('年级')
              .margin({right: 10})
              .fontSize(20)
            TextInput({text: this.grade})
              .onChange((value) => {this.grade = value;})
              .onSubmit(() => {userPI.setUserPreference(undefined, this.grade);})
              .width('60%')
            Button('修改')
              .onClick(() => {userPI.setUserPreference(undefined, this.grade);})
          }
            .margin({top:10, left:15, right:15, bottom:10})

          Row(){
            Text('校区')
              .margin({right: 10})
              .fontSize(20)
            TextInput({text: this.campus})
              .onChange((value) => {this.campus = value;})
              .onSubmit(() => {userPI.setUserPreference(undefined, undefined, this.campus);})
              .width('60%')
            Button('修改')
              .onClick(() => {userPI.setUserPreference(undefined, undefined, this.campus);})
          }
            .margin({top:10, left:15, right:15, bottom:10})

        }
      }
      .title('Setting')
      .mode(NavDestinationMode.STANDARD)
    }
  }
}