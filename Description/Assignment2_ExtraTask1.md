## Required Task
1. Add a UISlider to your UI which travels through the history of the results of the currently-being-played game’s card choices and display it to the user (moving the slider will modify the contents of the text label you created for Required Task 5 to show its state over the course of the game). When you are displaying past results, you probably want the text label to be grayed out or some such (take a look at the UIView method alpha and note that UISlider inherits from UIView) so it’s clear that it’s “the past.” And every time a new choice happens, you probably want to “jump to the present” in the slider. Implementing this extra credit item will require you to familiarize yourself with UISlider’s API and to add a data structure to your Controller to keep track of the history. It can be implemented in fewer than a dozen lines of code.

1. make UISlider and hook it up to CardGameVC with IBOulter and IBAction

2. make NSmutablearray resultHistory to store result and make lazy init as usual.
```objc
class CardGameVC...

@property (strong, nonatomic) NSMutableArray * resultHisotry;

-(NSMutableArray *)resultHisotry {
    if(_resultHisotry) {
        _resultHisotry = [NSMutableArray array];
    }
    return _resultHisotry;
}
```
3. store result in histroy
```objc
-(void)storeHistory: (NSString *)resultDescritpion {
    [self.resultHistory addObject: resultDescritpion];
}
```

4. set the slide max which mean jump to the presen
```objc
-(void)updateResultHistorySlider {
    self.resultHistorySlider.maximumValue = self.resultHistory.count;
    [self.resultHistorySlider setValue:self.resultHistory.count];
}

```

5. moving the slider will modify the contenst of the text label and alpha
```objc
- (IBAction)slidedreulstHistorySlider:(UISlider *)sender {
    int positionOfSlide =  roundf(self.resultHistorySlider.value);
    if ( positionOfSlide > 0 ) {
        [self.resultsDescription setText:[self.resultHistory objectAtIndex:positionOfSlide - 1]];
        [self.resultsDescription setAlpha:0.5];
    }
}
```
6. update reulstDescriptionLabel alpha to 1.0 when card seleted. During this, refactoring with making updateResultDescription: method for collect [self.resultsDescription setText:someString] in one method;
```objc
-(void)updateResultDescription: (NSString *)description {
    [self.resultsDescription setText:description];
    if ( self.resultHistorySlider.value == self.resultHistorySlider.maximumValue ) {
        [self.resultsDescription setAlpha:1.0];
    } else {
        [self.resultsDescription setAlpha:0.5];
    }
}

7. Finally, when re-dael resultHistory should be reset to nil.
```objc
- (IBAction)touchedDealButton:(UIButton *)sender {
    ...
    self.resultHistory = nil;
    [self updateResultHistorySlider];
}
```
