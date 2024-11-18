import {Information, getInformation, defaultInformation} from '../utils/InformationUtils';

@Component
struct InformationCard {
  @Prop info: Information

  build() {
    Column(){
      Text(this.info.title)
      Text(this.info.keyWords.toString() )
      Text(this.info.body.substring(0,20)+ ' ... ...')
    }
  }

}


@Component
export struct BrowserPage{
  @Consume('pageStack') pageStack: NavPathStack;
  @Prop infoDate: Date;

  @State informations: Information[] = getInformation(this.infoDate);
  // @State hoverIndex: number = -1;
  build() {
    NavDestination(){
      Scroll(){
        Column(){
          Grid(){
            ForEach(this.informations, (info:Information, index) => {

              GridItem() {
                Column(){
                  Row(){
                    Text('不感兴趣')
                      .margin({left:'40%'})
                    Button() {
                      Image($r('app.media.ic_public_close'))
                        .width(20)
                        .height(20)
                    }
                    .margin({left: '5%'})
                    .backgroundColor(Color.Transparent)
                  }
                    .margin({top:-20, bottom: '5%'})
                    .width('100%')
                  InformationCard({ info: info })
                    .onClick(() => {
                      console.info('Click Component title: ' + info.title);
                      this.pageStack.pushPathByName('Detail', info);
                    })
                }
              }
              .backgroundColor(Color.Pink)
              .size({width: '80%', height: 180})
              .margin({left:10, right: 10, top: 10, bottom: 20})
              .borderRadius(20)
            })

          }
          .columnsTemplate('1fr 1fr')
          if(this.informations.length < 10) {
            Text('No More Information Today.')
          }
        }
      }
    }
      .title('Browser Information\n' + this.infoDate.toString())
  }
}