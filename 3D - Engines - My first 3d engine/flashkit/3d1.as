onClipEvent(load){

	x = new Array();
	y = new Array();
	z = new Array();
	scale = new Array();

	//Note to self: x can't be 0. Change it to 0.1 to make it work
	
	x[0] = 0.1;
	y[0] = -80;
	z[0] = 0;
	scale[0] = 300;
	
	x[1] = -25;
	y[1] = -80;
	z[1] = 0;
	scale[1] = 125;
		
	x[2] = 25;
	y[2] = -80;
	z[2] = 0;
	scale[2] = 125;
	
	x[3] = 0;
	y[3] = 0;
	z[3] = 0;
	scale[3] = 400;
	
	x[4] = -30;
	y[4] = -20;
	z[4] = 0;
	scale[4] = 200;
	
	x[5] = 30;
	y[5] = -20;
	z[5] = 0;
	scale[5] = 200;

	x[6] = -85;
	y[6] = 40;
	z[6] = 10;
	scale[6] = 150;

	x[7] = 85;
	y[7] = 40;
	z[7] = 10;
	scale[7] = 150;
	
	x[8] = -40;
	y[8] = 100;
	z[8] = 0;
	scale[8] = 200;

	x[9] = 40;
	y[9] = 100;
	z[9] = 0;
	scale[9] = 200;

	x[10] = -60;
	y[10] = 150;
	z[10] = 0;
	scale[10] = 150;

	x[11] = 60;
	y[11] = 150;
	z[11] = 0;
	scale[11] = 150;	

	x[12] = 0.1;
	y[12] = 30;
	z[12] = 0;
	scale[12] = 300;
	
	x[13] = -70;
	y[13] = 0;
	z[13] = -5;
	scale[13] = 175;
	
	x[14] = 70;
	y[14] = 0;
	z[14] = -5;
	scale[14] = 175;
	
	dist = new Array();
	
	originalAngleTheta = new Array();
	originalAnglePhi = new Array();

	for ( i = 0; i < x.length; i++){

		dist[i] = Math.sqrt( x[i]*x[i] + y[i]*y[i] + z[i]*z[i] );
		
		originalAnglePhi[i] = Math.atan2( x[i] , y[i] );
		originalAngleTheta[i] = Math.atan( z[i] / x[i] );
		
		if ( i > 0){
			this.point0.duplicateMovieClip('point' add i, i);
		}
		
		this['point' add i]._x = x[i];
		this['point' add i]._y = y[i];
		this['point' add i]._xscale = scale[i];
		this['point' add i]._yscale = scale[i];
	}

	angleTheta = 0;
	anglePhi = 0;
	
	angleThetaDelta = 0;
	anglePhiDelta = 0;

}

onClipEvent(enterFrame){

	angleTheta += angleThetaDelta;
	anglePhi += anglePhiDelta;

	for ( i = 0; i < x.length; i++){
	
		sinPhi = Math.sin(anglePhi + originalAnglePhi[i]);
		cosPhi = Math.cos(anglePhi + originalAnglePhi[i]);
		sinTheta = Math.sin(angleTheta + originalAngleTheta[i]);
		cosTheta = Math.cos(angleTheta + originalAngleTheta[i]);
		
		this['point' add i]._x = dist[i]*sinPhi*sinTheta;
		this['point' add i]._y = dist[i]*cosPhi;
		this['point' add i]._xscale = 0.5*dist[i]*sinPhi*cosTheta + scale[i];
		this['point' add i]._yscale = 0.5*dist[i]*sinPhi*cosTheta + scale[i];
	
	}
}

onClipEvent (mouseMove){

	angleThetaDelta = _xmouse/2000;
	anglePhiDelta = _ymouse/2000;
	
}

