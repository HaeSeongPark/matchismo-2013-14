## Required Task
-  4.Disable the game play mode control (i.e. the UISwitch or UISegmentedControl from Required Task 3) when a game starts (i.e. when the first flip of a game happens) and re-enable it when a re-deal happens (i.e. the Deal button is pressed).

  - hook up cardMatchMode UISegmentedControl to CardGameVC and disable when card touched and enable when re-deal

  ```objc
  class GardGameVC...
...

  @property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchMode;

...

- (IBAction)touchCardButton:(UIButton *)sender {
    self.cardMatchMode.enabled = NO;
    ...
}

...

- (IBAction)touchedDealButton:(UIButton *)sender {
    self.cardMatchMode.enabled = YES;
    ...
}

  ```