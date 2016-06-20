int width = 360, height = 600;
int score = 0;
int birdX, birdY;

PImage[] birdImg;
PImage landImg;
PImage bgImg;

int birdImgCycle;
ArrayList jump;
int land1X, land2X;

int moveBy = 10;

int stage = 1;

// Images are scaled down by factor of 3/4

void setup () {
	size(width, height);
	frameRate(30);

	// Load images
	loadImgs();

	landImg = loadImage(loadImage("assets/images/land.png"));
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
}

void update() {
	image(birdImg[birdImgCycle%4], birdX, birdY, int(58 * 3/4), int(41 * 3/4));
	birdImgCycle++;

	if (jump.size() > 0) {
		birdY -= 20;
		jump.remove(0);
	}
	else {
		birdY += 30;
	}

	land1X -= moveBy;
	land2X -= moveBy;

	checkEdges();
}

void checkEdges() {
	if (birdY > 550) {
		birdY = 550;
	}
}

void drawBackground() {
	image(bgImg, 0,0, width, height);
	if (land1X == -width)	land1X = width;
	if (land2X == -width)	land2X = width;
	image(landImg, land1X, 600 - 160*3/4, 480 * 3/4, 160 * 3/4);
	image(landImg, land2X, 600 - 160*3/4, 480 * 3/4, 160 * 3/4);
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

	// delay
	double start = millis();
	while(millis() - start < 100) {}
	
}

void loadImgs()  {
	/* @pjs preload="assets/images/bg.png,assets/images/land.png,assets/sprite-animations/bird1.png,assets/sprite-animations/bird2.png,assets/sprite-animations/bird3.png,assets/sprite-animations/bird4.png"; */
}