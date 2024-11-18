
@Component
export struct LecturesPage {
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    Column() {
      NavDestination() {
        Text('Lecture-1')
        Text('Lecture-2')
        Text('Lecture-3')
      }
        .title('Lectures')
    }
  }
}