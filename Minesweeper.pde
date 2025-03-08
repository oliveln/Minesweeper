import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>();//ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  buttons = new MSButton[NUM_ROWS][NUM_COLS];

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }

  setMines();
}
public void setMines()
{
  while (mines.size() < NUM_ROWS) {
    final int r1 = (int)(Math.random() * NUM_ROWS);
    final int c1 = (int)(Math.random() * NUM_COLS);
    if ((!mines.contains(buttons[r1][c1]))) {
      mines.add(buttons[r1][c1]);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if ((buttons[r][c].clicked) == false) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  buttons[NUM_ROWS/2][8].setLabel("U");
  buttons[NUM_ROWS/2][10].setLabel("L");
  buttons[NUM_ROWS/2][11].setLabel("O");
  buttons[NUM_ROWS/2][12].setLabel("S");
  buttons[NUM_ROWS/2][13].setLabel("E");
}
public void displayWinningMessage()
{
  buttons[NUM_ROWS/2][8].setLabel("U");
  buttons[NUM_ROWS/2][10].setLabel("W");
  buttons[NUM_ROWS/2][11].setLabel("I");
  buttons[NUM_ROWS/2][12].setLabel("N");
}

public boolean isValid(int row, int col) {
  if (row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS) {
    return true;
  }
  return false;
}

public int countMines(int row, int col) {
  int numMines = 0;
  //bottom left                    
  if (isValid(row + 1, col - 1) == true && mines.contains(buttons[row + 1][col - 1]) == true) {
    numMines+=1;
  }
  //bottom
  if (isValid(row + 1, col) == true && mines.contains(buttons[row + 1][col]) == true) {
    numMines+=1;
  } 
  //bottom right
  if (isValid(row + 1, col + 1) == true && mines.contains(buttons[row + 1][col + 1]) == true) {
    numMines+=1;
  }  
  //left
  if (isValid(row, col - 1) == true && mines.contains(buttons[row][col - 1]) == true) {
    numMines+=1;
  }  
  //right
  if (isValid(row, col + 1) == true && mines.contains(buttons[row][col + 1]) == true) {
    numMines+=1;
  }  
  //top left
  if (isValid(row - 1, col - 1) == true && mines.contains(buttons[row - 1][col - 1]) == true) {
    numMines+=1;
  }  
  //top
  if (isValid(row - 1, col) == true && mines.contains(buttons[row - 1][col]) == true) {
    numMines+=1;
  }  
  //top right
  if (isValid(row - 1, col + 1) == true && mines.contains(buttons[row - 1][col + 1]) == true) {
    numMines+=1;
  }  
  return numMines;
}

public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    myLabel = String.valueOf(countMines(myRow, myCol));
    clicked = true;
    //done //bottom left
    if (isValid(myRow + 1, myCol-1) && !mines.contains(buttons[myRow + 1][myCol-1]) && countMines(myRow + 1, myCol-1) == 0 && buttons[myRow + 1][myCol -1].clicked == false) {
      buttons[myRow + 1][myCol -1].mousePressed();
    }
    //done //bottom
    if (isValid(myRow + 1, myCol)  && !mines.contains(buttons[myRow + 1][myCol]) && countMines(myRow + 1, myCol) == 0 && buttons[myRow + 1][myCol].clicked == false) {
      buttons[myRow + 1][myCol].mousePressed();
    }
    //done //bottom right
    if (isValid(myRow + 1, myCol + 1) && !mines.contains(buttons[myRow + 1][myCol+1]) && countMines(myRow + 1, myCol + 1) == 0 && buttons[myRow + 1][myCol + 1].clicked == false) {
      buttons[myRow + 1][myCol + 1].mousePressed();
    }
    //done //left
    if (isValid(myRow, myCol - 1) && !mines.contains(buttons[myRow][myCol-1]) && countMines(myRow, myCol - 1) == 0 && buttons[myRow][myCol -1].clicked == false) {
      buttons[myRow][myCol -1].mousePressed();
    }
    //done //right
    if (isValid(myRow, myCol + 1) && !mines.contains(buttons[myRow][myCol + 1]) && countMines(myRow, myCol + 1) == 0 && buttons[myRow][myCol + 1].clicked == false) {
      buttons[myRow][myCol + 1].mousePressed();
    }
    //done //top left
    if (isValid(myRow - 1, myCol - 1) && !mines.contains(buttons[myRow - 1][myCol-1]) && countMines(myRow - 1, myCol -1) == 0 && buttons[myRow - 1][myCol - 1].clicked == false) {
      buttons[myRow - 1][myCol - 1].mousePressed();
    }
    //done //top
    if (isValid(myRow - 1, myCol) && !mines.contains(buttons[myRow - 1][myCol]) && countMines(myRow - 1, myCol) == 0 && buttons[myRow - 1][myCol].clicked == false) {
      buttons[myRow - 1][myCol].mousePressed();
    }
    //done //top right
    if (isValid(myRow - 1, myCol + 1) && !mines.contains(buttons[myRow - 1][myCol + 1]) && countMines(myRow - 1, myCol + 1) == 0 && buttons[myRow - 1][myCol + 1].clicked == false) {
      buttons[myRow - 1][myCol + 1].mousePressed();
    }       
    if (mouseButton == RIGHT) {
      flagged = !flagged;
    } else if (mines.contains(this)) {
      fill(0, 0, 255);
      displayLosingMessage();
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill(95, 177, 225);
    else 
    fill(167, 199, 231);

    rect(x, y, width, height);
    if (myLabel.equals("U")) {
      fill(0, 0, 255);
    } else if (myLabel.equals("L") || myLabel.equals("O") || myLabel.equals("S") || myLabel.equals("E")) {
      fill(160, 32, 240);
    } else if (myLabel.equals("W") || myLabel.equals("I") || myLabel.equals("N")) {
      fill(0, 255, 0);
    } else {
      fill(0);
    }
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
