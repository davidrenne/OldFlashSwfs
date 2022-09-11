onClipEvent( load ){

	numSteps = 5;
	numXSquares = 9;
	numYSquares = 9;
	spacing = 29.5;
	
	//Set up the empty square object

	emptySquare = new Object();
	emptySquare.x = numXSquares - 1;
	emptysquare.y = numYSquares - 1;

	totalSquares = numXSquares*numYSquares - 1;
	
	//Just a shortcut for the for for loops
	
	function getNumber(x,y){
	
		return (x*numXSquares + 1 + y);
		
	}
	
	//set up of the square object

	function square(x, y){

		this.x = x;
		this.y = y;

	}

	for( x = 0; x < numXSquares; x++){
		for ( y = 0; y < numYSquares; y++){

			number = getNumber(x,y);
			if( number <= totalSquares){

				if( number != 1){
				
					this.squareMC1.duplicateMovieClip("squareMC" add number , number);
					this["squareMC" add number]._x = spacing*x;
					this["squareMC" add number]._y = spacing*y;
				}
				
				this["squareMC" add number].caption = number;
				this["square" add number] = new square(x, y);
				this["colorMC" add number] = new Color(this["squareMC" add number].colorMC);
			}
		}
	}

	//The relevant array holds the numbers of the squares that have an adjacent empty Square

	relevant = new Array();
	chosenOne = 0;

	// **********************************************************************************
	//                           End init \ Start the "real" script
	// **********************************************************************************

	function cleanRelevantArray(){

		//for( i = 0; i < relevant.length; i++ ){

		//	relevant.pop();

		//}
		relevant = new Array();
	}

	function findRelevant(){

		i = 0;
		for( x = 0; x < numXSquares; x++){
			for ( y = 0; y < numYSquares; y++){

				number = getNumber(x,y);

				//This condition checks for the number of squares between the square and the empty square
				//If it is 1, then the square is adjacent to the empty square.
				//The condition also bans the square that was chosen on the previous turn (the «chosen one»)

				if( number <= totalSquares && chosenOne != number && (Math.abs( this["square" add number].x - emptySquare.x) + Math.abs( this["square" add number].y - emptySquare.y)) == 1){

					relevant[i] = number;
					i++;

				}
			}
		}
	}

	function randomRelevantSquare(){

		return relevant[ random( relevant.length ) ];

	}

	function getNewPosition( which ){

		//Make the switch in the variables

		oldSquareX = this["square" add which].x;
		oldEmptyX  = emptySquare.x;
		oldSquareY = this["square" add which].y;
		oldEmptyY  = emptySquare.y;

		this["square" add which].x = oldEmptyX;
		emptySquare.x = oldSquareX;
		this["square" add which].y = oldEmptyY;
		emptySquare.y = oldSquareY;

		chosenOne = which;
		step = 1;
		moving = 1;
		
		xDelta = spacing*(1/numSteps)*(oldEmptyX - oldSquareX);
		yDelta = spacing*(1/numSteps)*(oldEmptyY - oldSquareY);

	}

	function move(){

		this["squareMC" add chosenOne]._x += xDelta;
		this["squareMC" add chosenOne]._y += yDelta;
		
		r = this["squareMC" add chosenOne]._x;
		b = this["squareMC" add chosenOne]._y;
		
		this["colorMC" add chosenOne].setRGB(r << 16 | 127 << 8 | b);
		
		step++;
		
		if( step > numSteps ){
		
			//make up for lost space
			
			this["squareMC" add chosenOne]._x = spacing*oldEmptyX;
			this["squareMC" add chosenOne]._y = spacing*oldEmptyY;
		
			moving = 0;
			
		}

	}
}

onClipEvent( enterFrame ){

	if( !moving ){

		cleanRelevantArray();
		findRelevant();
		getNewPosition( randomRelevantSquare() );

	}
	
	else{

		move();

	}
}