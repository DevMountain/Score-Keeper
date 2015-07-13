# ScoreKeeper MVC w/ Custom Table View Cells

## Model
- create a 'Player' model object as a sublcass of NSObject
    - properties: name, score

## Controller
- create a 'PlayerController' NSObject subclass
- add a public NSArray called 'players' to your Player Controller
- use the code snippet library to overwrite the initializer ('Objective-C init')
- in your overwritten initializer, initialize 4 players and set the self.players to an array containing all four players

## View

### Subclassing UITableViewCell
- add a new class called 'PlayerTableViewCell'
- add properties for a UITextField (playerNameField), a UILabel (scoreLabel) and a UIStepper (stepper) to the cell's contentView using frames
- implement an action for the stepper that updates the label with the current value of the stepper
- add a public method 'updateWithPlayer:(Player *)player'
- implement the method by updating self.playerNameField.text, self.scoreLabel.text, and self.stepper.value to match the Player's name and score

### Set Up the Table View
- add a property for the PlayerController
- instantiate self.playerController in the viewDidLoad:
- add a tableview to your view controller
- set tableview's allowsSelection to NO
- implement an internal table view datasource
    - number of cells: self.playerController.players.count
    - cell for row: dequeue a PlayerTableViewCell
- set the datasource to self
- implement the table view delegate method 'heightForRowAtIndexPath' to return a taller cell
- set the delegate to self
- dequeue a PlayerTableViewCell instead of a UITableViewCell
- after you dequeue the PlayerTableViewCell run 'updateWithPlayer:(Player *)player'

## Experiment
- in your PlayerController's init method, set name and score properties for the Players you initialized to see how your UITableViewCells update with the Model Data passed by the controller
- experiment with different numbers of Player objects and see how this impacts your UITableView

## Black Diamonds
- implement saving to a file using PersonList as a model