# Partial Style Transfer
A partial style transfer algorithm for CS 534 at UW-Madison semester project. It is accomplished by training a style transfer model using TensorFlow based on two images, then running an image segmentation algorithm. Then the program can blend the original image with the style-transferred image on user's demand. Click [here](https://kaiwang66.github.io/) to learn more.

## Usage
To run this algorithm, you need to have TensorFlow for Python downloaded on your computer. It also requires a pre-trained vgg19 model. Once you have downloaded the code in this repository, please download the [model](https://uwprod-my.sharepoint.com/:u:/g/personal/squ27_wisc_edu/EXMeJDYhgotHqijdKTEFETUB5Dle1zXp8lbaDxKTQ_l5Lw?e=dQYsGu) and put it under a folder named "pre-trained model" in the same directory as main.py.

### For Style Transfer: 
To run a style transfer model run main.py. To change the content and style image of the input, please change the STYLE_IMAGE and CONTENT_IMAGE on lines 10 and 11 to path to your desired images. The generated image will be shown in the output folder. Note: for technical reasons, the model currently only support JPG pictures. 

### For Partial Style Transfer:
Make sure you have the style-transferred image generated in the output folder, go to kmeans.m in kmeans folder, change fileName on line 5 to the path of your chosen content image, then hit run. 
