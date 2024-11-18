import PageNotFound from './NotFound';
import {BrowserPage} from './Browser';
import {DetailInformationPage} from  './DetaiInformation';
import {Information} from '../utils/InformationUtils';
import {SettingPage} from './Setting';
import {LecturesPage} from './Lectures';
@Entry
@Component
struct Index {
  @State message: string = 'Hello LLM';
  @State currentDate: string = Date();
  @State selectedDate: Date = new Date();

  private settingIcon:NavigationMenuItem = {value:'', icon: './images/ic_public_settings.svg', action: ()=>{this.pageStack.pushPathByName('Setting', '');}};
  private lecturesIcon:NavigationMenuItem = {value:'', icon: './images/ic_public_view_list.svg', action: () => {this.pageStack.pushPathByName('Lectures', '');}}
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  PageMap(name: string, param: object) {
    if (name === 'Browser') {
      BrowserPage({infoDate: param as Date})
    } else if (name === 'Detail') {
      DetailInformationPage({info: param as Information})
    } else if(name === 'Setting'){
      SettingPage()
    } else if(name === 'Lectures') {
      LecturesPage()
    } else if (name === '__SOMETHING__') {
      PageNotFound()
    } else {
      PageNotFound()
    }
  }

  build() {
    Column() {
      Navigation(this.pageStack){
        Text(this.message)
          .fontSize(30)
          .margin({top: 60, bottom: 50})
        Text('choose date:')
        DatePicker({
          start: new Date('2023-1-1'),
          end: new Date('2025-12-31'),
          selected: this.selectedDate,
        })
          .size({width:'80%'})
          .onDateChange((newDate) => {this.selectedDate = newDate;})
        Button('get information')
          .onClick(() => {
            console.info('click the button')
            this.pageStack.pushPathByName('Browser',this.selectedDate);
          })
      }
        .mode(NavigationMode.Stack)
        .navDestination(this.PageMap)
        .menus([this.settingIcon, this.lecturesIcon])
    }
    .height('100%')
    .width('100%')
  }
}