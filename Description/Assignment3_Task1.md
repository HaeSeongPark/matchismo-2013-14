> I have organized folders which are General, PlayingCard. And I will make SetCard folder for convenience.

## We need check SET game rule simply before start.
> If you already know, skip this.
- SET game consist of lots of cards. Each card has four features. which would be our model.
  1. Shape(ovals, squiggles, diamonds)
  2. Color(red, purple, green)
  3. Number(one, two, three)
  4. Shading(solid, striped, outlined)
> I think it would be better use the Enum for our model, have it introduced in the lectures?

- SET consists of 3cards in which must satisfy as follows
    - have the same shape `or` different shape separately
    - `And` have the same color `or` different color separately
    - `And` have the same number `or` different number separately
    - `And` have the same shading `or` different shading separately
> As you notice, I highlighted `or` and `And`. It would be our match logic.

> If you want detail instructions with graphic google it. or click [link](https://www.setgame.com/sites/default/files/instructions/SET%20INSTRUCTIONS%20-%20ENGLISH.pdf) for English, [link](https://blog.naver.com/boardville/220919975189) for Korean


## Required Task
- 1. Add a new MVC to your Matchismo solution from last week which plays a simple version of the card matching game Set. A good solution to this assignment will use object-oriented programming techniques to share a lot of code with your Playing Card-based matching game.

## My Solution
 - Structrue Set Card files. In SetCard folder, I made as follows  
     - M : SetCard which is subclass of Card like PlayingCardGame, SetCardDeck which is subclass of Deck like PlayingCardDeck  

     - V : EmptyVC in storyboard and have it class SetCardGameVC
     
     - C : SetCardGameVC which is subclass of CardGameViewController like PlayingCardGameVC. It has no entry points as of now.
