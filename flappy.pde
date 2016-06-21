int width = 360, height = 600;
int score = 0;
int birdX, birdY;

PImage[] birdImg;
PImage landImg;
PImage bgImg;
PImage pipe;
PImage pipeUp;
PFont flappyfont;

int pipe1X, pipe1Y, pipe2X, pipe2Y;

int birdImgCycle;
ArrayList jump;
int land1X, land2X;

PVector position;
PVector velocity;
PVector acceleration;
PVector upwardForce;
int angle;

int moveBy = 6;

int stage = 1;

// Images are scaled down by factor of 3/4

void setup () {
	size(width, height);
	frameRate(30);

	// Load images
	loadImgs();

	landImg = loadImage("assets/images/land.png");
	birdImg = new PImage[]{loadImage("assets/sprite-animations/bird1.png"),loadImage("assets/sprite-animations/bird2.png"),
			loadImage("assets/sprite-animations/bird3.png"),loadImage("assets/sprite-animations/bird4.png")};
	bgImg = loadImage("assets/images/bg.png");
	pipe = loadImage("assets/images/pipe.png");
	pipeUp = loadImage("assets/images/pipeUp.png");
	/* @pjs font="flappy_font.ttf"; */
	flappyfont = loadFont("flappy_font.ttf");
}

void init() {
	score = 0;
	birdX = 60;
	birdY = 240;
	jump = new ArrayList();
	birdImgCycle = 0;
	land1X = 0; land2X = width;

	acceleration = new PVector(0, 2);
	velocity = new PVector(0,0);
	position = new PVector(birdX, birdY);
	upwardForce = new PVector(0, -20);
	angle = 0;

	pipe1X = 450, pipe1Y = 250;
	pipe2X = 650, pipe2Y = 200;
}

void update() {
	birdImgCycle++;

	if (jump.size() > 0) {
		acceleration.add(upwardForce);
		velocity.set(0);
		jump.remove(0);

		angle = 2*PI - PI/4;	// 45 degrees
		pushMatrix();
			translate(position.x, position.y);
			rotate(angle);
			image(birdImg[birdImgCycle%4], 0, 0, 58*3/4, 41*3/4);
		popMatrix();
	}
	else {
		angle += 3 * PI/180;
		if (angle > 2*PI + PI/2)	angle = 2*PI + PI/2;
		pushMatrix();
			translate(position.x, position.y);
			rotate(angle);
			image(birdImg[birdImgCycle%4], 0, 0, 58*3/4, 41*3/4);
		popMatrix();
	}
	velocity.add(acceleration);
	position.add(velocity);

	land1X -= moveBy;
	land2X -= moveBy;
	if (land1X < -width)	land1X = width-10;
	if (land2X < -width)	land2X = width-10;

	pipe1X -= moveBy;
	pipe2X -= moveBy;
	if (pipe1X < -87*3/4)	pipe1X = width;
	if (pipe2X < -87*3/4)	pipe2X = width;

	acceleration.set(0, 2);
}

void checkCollisions() {
	if (position.x >= pipe1X && position.x <= pipe1X + 87*3/4 ||
		position.x + 58*3/4 >= pipe1X && position.x + 58*3/4 <= pipe1X + 87*3/4) {
		if (position.y + 41*3/4>= pipe1Y) {
			stage = 3;
		}
		if (position.y <= pipe1Y - 130) {
			stage = 3;
		}
	}
	if (position.x >= pipe2X && position.x <= pipe2X + 87*3/4 ||
		position.x + 58*3/4 >= pipe2X && position.x + 58*3/4 <= pipe2X + 87*3/4) {
		if (position.y + 41*3/4 >= pipe2Y) {
			stage = 3;
		}
		if (position.y <= pipe2Y - 130) {
			stage = 3;
		}
	}
	if (position.y < -20) {
		stage = 3;
	}
	if (position.y > 440) {
		position.y = 440;
		stage = 3;
	}
}

void updateScore() {
	fill(0);
	textFont(flappyfont, 40);
	text(score, width/2 - 10, 200);
}

void drawBackground() {
	image(bgImg, 0,0, width, height);

	// Draw pipe
	image(pipe, pipe1X, pipe1Y, 87*3/4, 532*3/4);
	image(pipeUp, pipe1X, pipe1Y-532*3/4 - 130, 87*3/4, 532*3/4);
	image(pipe, pipe2X, pipe2Y, 87*3/4, 532*3/4);
	image(pipeUp, pipe2X, pipe2Y-532*3/4 - 130, 87*3/4, 532*3/4);

	image(landImg, land1X, 600 - 160*3/4, 480*3/4, 160*3/4);
	image(landImg, land2X, 600 - 160*3/4, 480*3/4, 160*3/4);
}

void keyPressed() {
	if (stage == 2) {
		jump.add(true);
	}
}

void mouseClicked() {
	if (stage == 1) {
		stage = 2;
	}
	if (stage == 3) {
		init();
		stage = 2;
	}
}

void fallingBird() {
	angle = 2*PI + PI/2;
	pushMatrix();
		translate(position.x, position.y);
		rotate(angle);
		image(birdImg[2], 0, 0, 58*3/4, 41*3/4);
	popMatrix();
	acceleration.set(0, 2);
	velocity.add(acceleration);
	position.add(velocity);
	checkCollisions();
}

void draw() {
	drawBackground();
	console.log(stage);
	updateScore();

	if (stage == 1) {
		init();
	}
	else if (stage == 2) {
		update();
		checkCollisions();
		updateScore();
	}
	else if (stage == 3) {
		fallingBird();
	}
	
}

void loadImgs()  {
	/* @pjs preload="assets/images/bg.png,assets/images/land.png,assets/sprite-animations/bird1.png,assets/sprite-animations/bird2.png,assets/sprite-animations/bird3.png,assets/sprite-animations/bird4.png,assets/images/pipe.png,assets/images/pipeUp.png"; */

	/* @pjs font="flappy_font.ttf"; */
}