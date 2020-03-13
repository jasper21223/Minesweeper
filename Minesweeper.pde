import de.bezier.guido.*;
int NUM_ROWS = 5;
int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean clickable = true;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    
    
    setMines();
}
public void setMines()
{
    for(int i = 0; i<5 ;i++){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!mines.contains(buttons[row][col])){
            mines.add(buttons[row][col]);
        }
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int count = 0;
    for(int r = 0; r <NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].flagged ==  true && mines.contains(buttons[r][c]))
                count++;
        }
    }
    if(count == mines.size()){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
    if(isWon() == false){
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)-1].setLabel("Y");
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)].setLabel("O");
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)+1].setLabel("U");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)-1].setLabel("L");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)].setLabel("O");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)+1].setLabel("S");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)+2].setLabel("T");
        for(int r = 0; r <NUM_ROWS; r++){
            for(int c = 0; c < NUM_COLS; c++){
                if(mines.contains(buttons[r][c]))
                        buttons[r][c].clicked=true;
            }
        }
    }
    clickable = false;
}
public void displayWinningMessage()
{
    //your code here
    if(isWon() == true){
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)-1].setLabel("Y");
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)].setLabel("O");
        buttons[(NUM_ROWS/3)-1][(NUM_COLS/3)+1].setLabel("U");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)-1].setLabel("W");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)].setLabel("O");
        buttons[(NUM_ROWS/3)][(NUM_COLS/3)+1].setLabel("N");
    }
    clickable = false;
}
public boolean isValid(int r, int c)
{
    if (r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
      return true;
    else
      return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1])){
        numMines++;
    }
    if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1])){
        numMines++;
    }
    if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1])){
        numMines++;
    }
    if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1])){
        numMines++;
    }
    if(isValid(row,col-1) && mines.contains(buttons[row][col-1])){
        numMines++;
    }
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col])){
        numMines++;
    }
    if(isValid(row,col+1) && mines.contains(buttons[row][col+1])){
        numMines++;
    }
    if(isValid(row+1,col) && mines.contains(buttons[row+1][col])){
        numMines++;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
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
        if(clickable == true && mouseButton != RIGHT){
            clicked = true;
        }
        //your code here
        if(mouseButton == RIGHT && clickable == true && clicked == true){
            flagged = !flagged;
            if(flagged == false){
                clicked = false;
            }
        }else if(mines.contains(this) && clickable == true){
            displayLosingMessage();
        }else if(countMines(myRow,myCol)>0 &&clickable == true){
            setLabel(countMines(myRow,myCol));
        }else if(clickable == true){
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked == false){
                buttons[myRow-1][myCol-1].mousePressed();
            }
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false){
                buttons[myRow][myCol-1].mousePressed();
            }
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false){
                buttons[myRow-1][myCol].mousePressed();
            }
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false){
                buttons[myRow+1][myCol].mousePressed();
            }
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false){
                buttons[myRow][myCol+1].mousePressed();
            }
            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false){
                buttons[myRow-1][myCol+1].mousePressed();
            }
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false){
                buttons[myRow+1][myCol-1].mousePressed();
            }
            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked == false){
                buttons[myRow+1][myCol+1].mousePressed();
            }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
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
