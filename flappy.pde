int width = 360, height = 600;
int score = 0;
int birdX, birdY;

PImage[] birdImg;
PImage landImg;
PImage bgImg;

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
}

void init() {
	score = 0;
	birdX = 30;
	birdY = 240;
	jump = new ArrayList();
	birdImgCycle = 0;
	land1X = 0; land2X = width;

	acceleration = new PVector(0, 2);
	velocity = new PVector(0,0);
	position = new PVector(birdX, birdY);
	upwardForce = new PVector(0, -20);
	angle = 0;
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
			image(birdImg[birdImgCycle%4], 0, 0, int(58 * 3/4), int(41 * 3/4));
		popMatrix();
	}
	else {
		angle += 3 * PI/180;
		if (angle > 2*PI + PI/2)	angle = 2*PI + PI/2;
		pushMatrix();
			translate(position.x, position.y);
			rotate(angle);
			image(birdImg[birdImgCycle%4], 0, 0, int(58 * 3/4), int(41 * 3/4));
		popMatrix();
	}
	velocity.add(acceleration);
	position.add(velocity);

	land1X -= moveBy;
	land2X -= moveBy;

	checkEdges();

	acceleration.set(0, 2);
}

void checkEdges() {
	if (position.y > 440) {
		position.y = 440;
	}
}

void drawBackground() {
	image(bgImg, 0,0, width, height);
	if (land1X < -width)	land1X = width-10;
	if (land2X < -width)	land2X = width-10;
	image(landImg, land1X, 600 - 160*3/4, 480 * 3/4, 160 * 3/4);
	image(landImg, land2X, 600 - 160*3/4, 480 * 3/4, 160 * 3/4);
}

void keyPressed() {
	if (stage == 2) {
		jump.add(true);
		console.log("jump");
	}
}

void mouseClicked() {
	if (stage == 1) {
		stage = 2;
	}
}

void draw() {
	drawBackground();

	if (stage == 1) {
		init();
	}
	else if (stage == 2) {
		update();
	}
	else if (stage == 3) {
	}
	
}

void loadImgs()  {
	/* @pjs preload="assets/images/bg.png,assets/images/land.png,assets/sprite-animations/bird1.png,assets/sprite-animations/bird2.png,assets/sprite-animations/bird3.png,assets/sprite-animations/bird4.png"; */
}