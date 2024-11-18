import {Information} from '../utils/InformationUtils';
@Component
export struct DetailInformationPage{
  @Consume('pageStack') pageStack: NavPathStack;
  @Prop info:Information;

  private copySourceIcon:NavigationMenuItem = {value:'', icon:'./images/ic_public_copy.svg', action: () => {}};
  private feedbackIcon:NavigationMenuItem = {value: '', icon:'./images/ic_public_help.svg', action: () => {}};
  private forwardIcon:NavigationMenuItem = {value: '', icon: './images/ic_message_forwarding.svg', action: ()=> {}};

  build() {
    NavDestination(){
      Scroll(){
        Column(){
          Text(this.info.date.toString())
            .margin({bottom:20})
          Text(this.info.body)
          Text(this.info.source)
        }
        .margin({left:20, right: 20, top:20, bottom: 20})
      }
    }
      .title(this.info.title)
      .menus([this.copySourceIcon, this.feedbackIcon, this.forwardIcon])
  }
}