int width = 360, height = 600;
int score = 0;
int highscore = 0;
int birdX, birdY;

PImage[] birdImg;
PImage landImg, bgImg, pipe, pipeUp, logo, help, gmOver, dialog, replay, leaderboard;
PFont flappyfont;
PImage[] medal;


int pipe1X, pipe1Y, pipe2X, pipe2Y;

int birdImgCycle;
ArrayList jump;
int land1X, land2X;
boolean nextOne;	// true means can add points for passing pipe1
int[] tl, tr, bl, br;	// Top left, top right, bottom left, bottom right coordinates (for rotation)

PVector position;
PVector velocity;
PVector acceleration;
PVector upwardForce;
int angle;

int moveBy = 6;
int spacing = 135;

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
	logo = loadImage("assets/images/logo.png");
	help = loadImage("assets/images/help.png");
	gmOver = loadImage("assets/images/gmOver.png");
	dialog = loadImage("assets/images/dialog.png");
	medal = new PImage[4];
	medal[0] = loadImage("assets/images/medal1.png");
	medal[1] = loadImage("assets/images/medal2.png");
	medal[2] = loadImage("assets/images/medal3.png");
	medal[3] = loadImage("assets/images/medal5.png");
	replay = loadImage("assets/images/replay.png");
	leaderboard = loadImage("assets/images/standingsBtn.png");
}

interface JavaScript {
	void getValue(int s);
}

JavaScript javascript;
void bindJavascript(JavaScript js) {
	javascript = js;
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

	pipe1X = 420;
	pipe2X = pipe1X + 250;
	pipe1Y = int(random() * (420-150)) + 150;
	pipe2Y = int(random() * (420-150)) + 150;
	nextOne = true;
	stage = 1;
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

	rotationCoordinates();

	velocity.add(acceleration);
	position.add(velocity);

	land1X -= moveBy;
	land2X -= moveBy;
	if (land1X < -width)	land1X = width-10;
	if (land2X < -width)	land2X = width-10;

	pipe1X -= moveBy;
	pipe2X -= moveBy;
	if (pipe1X < -87*3/4) {
		pipe1X = pipe2X + 250;
		pipe1Y = int(random() * (420-150)) + 150;
	}
	if (pipe2X < -87*3/4) {
		pipe2X = pipe1X + 250;
		pipe2Y = int(random() * (420-150)) + 150;
	}

	if (position.x > pipe1X + 87*3/4 && nextOne) {
		score++;
		nextOne = false;
	}
	if (position.x > pipe2X + 87*3/4 && !nextOne) {
		score++;
		nextOne = true;
	}

	acceleration.set(0, 2);
}

void checkCollisions() {
	if (tl[0] >= pipe1X &&  tl[0] <= pipe1X + 87*3/4) {
		if (bl[1] >= pipe1Y) {
			stage = 3;
		}
		if (tl[1] <= pipe1Y - spacing) {
			stage = 3;
		}
	}
	if (tr[0] >= pipe1X && tr[0] <= pipe1X + 87*3/4) {
		if (br[1] >= pipe1Y) {
			stage = 3;
		}
		if (tr[1] <= pipe1Y - spacing) {
			stage = 3;
		}
	}
	if (tl[0] >= pipe2X && tl[0] <= pipe2X + 87*3/4) {
		if (bl[1] >= pipe2Y) {
			stage = 3;
		}
		if (tl[1] <= pipe2Y - spacing) {
			stage = 3;
		}
	}
	if (tr[0] >= pipe2X && tr[0] <= pipe2X + 87*3/4) {
		if (br[1] >= pipe2Y) {
			stage = 3;
		}
		if (tr[1] <= pipe2Y - spacing) {
			stage = 3;
		}
	}
	if (tr[1] < -60) {
		stage = 3;
	}
	if (br[1] > 485) {
		position.y = 440;
		velocity.set(0,0);
		stage = 3;
	}
}

void rotationCoordinates() {
	tl = new int[]{(58*1/8)*cos(angle) - 0*sin(angle), 
					(58*1/8)*sin(angle) + 0*cos(angle)};
	tr = new int[]{(58*3/4*4/5)*cos(angle) - 0*sin(angle),
					 (58*3/4*4/5)*sin(angle) + 0*cos(angle)};
	bl = new int[]{(58*1/8)*cos(angle) - (41*3/4)*sin(angle),
					 (58*1/8)*sin(angle) + (41*3/4)*cos(angle)};
	br = new int[]{(58*3/4*4/5)*cos(angle) - (41*3/4)*sin(angle),
					 (58*3/4*4/5)*sin(angle) + (41*3/4)*cos(angle)};

	tl[0]+=position.x; tl[1]+=position.y; tr[0]+=position.x; tr[1]+=position.y;
	bl[0]+=position.x; bl[1]+=position.y; br[0]+=position.x; br[1]+=position.y;
}

void updateScore() {
	fill(0);
	textFont(flappyfont, 40);
	text(score, width/2 - 10, 150);
}

void drawBackground() {
	image(bgImg, 0,0, width, height);

	// Draw pipe
	image(pipe, pipe1X, pipe1Y, 87*3/4, 532*3/4);
	image(pipeUp, pipe1X, pipe1Y-532*3/4 - spacing, 87*3/4, 532*3/4);
	image(pipe, pipe2X, pipe2Y, 87*3/4, 532*3/4);
	image(pipeUp, pipe2X, pipe2Y-532*3/4 - spacing, 87*3/4, 532*3/4);

	image(landImg, land1X, 600 - 160*3/4, 480*3/4, 160*3/4);
	image(landImg, land2X, 600 - 160*3/4, 480*3/4, 160*3/4);
}

void keyPressed() {
	if (stage == 1) {
		stage == 2;
	}
	if (stage == 2) {
		jump.add(true);
	}
}

boolean clientSend = false;

void mouseClicked() {
	if (stage == 1) {
		stage = 2;
	}
	if (stage == 2) {
		jump.add(true);
	}
	if (stage == 3) {
		if (mouseX >= 110 && mouseX <= 110+197*3/4)
		if (mouseY >= 350 && mouseY <= 350+120*3/4) {
			stage = 1;
		}
		if (mouseX >= 110 && mouseX <= 110+199*3/4) 
		if (mouseY >= 440 && mouseY <= 440+120*3/4) {
			if (javascript != null) {
				clientSend = true;
				tellClientScoreSubmit();
				javascript.getValue(highscore);
				highscore = 0;
			}
		}
	}
}

void tellClientScoreSubmit() {
	stroke(96, 42, 94, 255 * 9/10);
	strokeWeight(10);
	fill(29, 21, 78, 255 * 9/10);
	rect(30, 170, 393*3/4, 205);
	fill(243, 134, 48);
	textFont("sans-serif", 32);
	text("Sending score", 70, 250);
	text("to server...", 70, 290);
}

void drawStartScreen() {
	image(logo, 50, 100, 360*3/4, 120*3/4);
	image(help, 60, 220, 323*3/4, 185*3/4);
	image(birdImg[birdImgCycle%4], birdX, birdY, 58*3/4, 41*3/4);
}

void drawEndScreen() {
	image(gmOver, 50, 60, 340*3/4, 100*3/4);
	image(dialog, 30, 170, 393*3/4, 205*3/4);
	if (score >= 40)
		image(medal[3], 70, 225, 76*3/4, 76*3/4);
	else if (score >= 30)
		image(medal[2], 70, 225, 76*3/4, 76*3/4);
	else if (score >= 20)
		image(medal[1], 70, 225, 76*3/4, 76*3/4);
	else if (score >= 10)
		image(medal[0], 70, 225, 76*3/4, 76*3/4);
	fill(0);
	textFont(flappyfont, 20);
	text(score, 265, 233);

	if (score > highscore) {
		highscore = score;
	}
	text(highscore, 265, 280);
	textFont(flappyfont, 14);
	text("Clone by Minh Tran", 10, height-10);

	image(replay, 110, 350, 197*3/4, 120*3/4);
	if (highscore > 0)
		image(leaderboard, 110, 440, 199*3/4, 120*3/4);

	if (clientSend) {
		tellClientScoreSubmit();
	}

}

void fallingBird() {
	angle = 2*PI + PI/2;
	pushMatrix();
		translate(position.x, position.y);
		rotate(angle);
		image(birdImg[2], 0, 0, 58*3/4, 41*3/4);
	popMatrix();
	rotationCoordinates();
	if (position.y < 440) {
		acceleration.set(0, 2);
		velocity.add(acceleration);
		position.add(velocity);
		checkCollisions();
	}
}

void draw() {
	drawBackground();

	if (stage == 1) {
		init();
		drawStartScreen();
	}
	else if (stage == 2) {
		update();
		checkCollisions();
		updateScore();
	}
	else if (stage == 3) {
		fallingBird();
		drawEndScreen();
	}
	
}

void loadImgs()  {
	/* @pjs preload="assets/images/bg.png,assets/images/land.png,assets/sprite-animations/bird1.png,assets/sprite-animations/bird2.png,assets/sprite-animations/bird3.png,assets/sprite-animations/bird4.png,assets/images/pipe.png,assets/images/pipeUp.png,assets/images/logo.png,assets/images/help.png,assets/images/gmOver.png,assets/images/dialog.png,assets/images/medal1.png,assets/images/medal2.png,assets/images/medal3.png,assets/images/medal5.png,assets/images/replay.png,assets/images/standingsBtn.png"; */

	/* @pjs font="flappy_font.ttf"; */
}