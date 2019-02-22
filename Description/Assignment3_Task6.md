## Required Task
- 6. Instead of drawing the Set cards in the classic form (we’ll do that next week), we’ll use these three characters ▲ ● ■ and use attributes in NSAttributedString to draw them appropriately (i.e. colors and shading).

##### When I use a header "class someName..." in code block for some code, that means the following code is within the scope of the class named 'someName'.

##### Basically I borrowed m2mtech idea.

## My Description
 - make titleForCard and backgroundImageForCard methods of CardGameVC to public so that SetCardGameView use those methods.

```objc
CardGameView.h ...

-(NSString *)titleForCard: (Card*)card;
-(UIImage *)backgroundImageForCard:(Card *)card;

 ```
 - make titleForCard, backgroundImageForCard method in SetCardGameVC.
   - see the mm2mtech code.

- adjust titleForCard methods of CardGameVC return type, NSString to NSAttribuedString and in updateUI setTitle to setAttributedtitle. Because SetCardGameView need it.

- and we need display setcard when view loaded. so make updateUI public and invoke it when SetCardGameVC view loaded(aka viewdidlaod)