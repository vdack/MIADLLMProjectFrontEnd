@Component
struct PageNotFound {
  @Consume('pageStack') pageStack:NavPathStack;
  build() {
    Column(){
      NavDestination(){
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text("Not Found Any Page.")
              .fontSize(20)
            Button("Close").onClick(() => {
              this.pageStack.pop()
            }).width('30%')
          }
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .height('30%')
          .width('80%')
        }
        .height("100%").width('100%')
      }
      .title('Page Not Found')
      .backgroundColor('rgba(0,0,0,0.5)')
      .hideTitleBar(true)
      .mode(NavDestinationMode.DIALOG)
    }
  }
}
export default PageNotFound;