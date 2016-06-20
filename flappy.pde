int width = 360, height = 600;

// Images are scaled down by factor of 3/4

void setup () {
	size(width, height);
	frameRate(30);

	// Load images
	loadImgs();
}

void draw() {
	image(loadImage("assets/images/bg.png"), 0,0, width, height);
	image(loadImage("assets/images/land.png"), 0, 600 - 160*3/4, 480 * 3/4, 160 * 3/4);
	
}

void loadImgs()  {
	/* @pjs preload="assets/images/bg.png,assets/images/land.png"; */
}