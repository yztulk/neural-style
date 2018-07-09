# neural-style

- read https://github.com/jcjohnson/neural-style/wiki/For-Beginners
- run neural-style with more GPUs to generate higher resolution pictures
- play with Multiple Style Images
- enlarge pictures throug AI tool
- cannot run neural-style with NVIDIA cuDNN. Error occur. Try to fix it.
- The -init parameter is by default set to random, though from what I have seen, most people get better results by setting it to image.
- Check out other neural network style tranfser techniques: https://github.com/jcjohnson/neural-style/wiki/Similar-to-Neural-Style
- Check out this https://gist.github.com/ProGamerGov/f650a80c39fc2d3d5139be9ff1fbf0d9 lua implementation. It contains a minor change to the neural_style.lua in that it removes the unneeded dropout layers entirely. vic8760 applies it so check it out.
- ProGamerGov is pretty active in /r/deepdream and has built some cools scripts: https://github.com/ProGamerGov.

# Training models
You can apply other neural networks as well, see https://github.com/jcjohnson/neural-style/wiki/Using-Other-Neural-Models. I find that the standard model does not really do well on faces. This model in particular 'Rough_Faces by ProGamerGov' says that it improves the preservation of facial features. See here examples https://imgur.com/a/tArrY.

# High-res pictures
- jcjohson: "Resolution is constrained by memory". You can use a multi-gpu strategy though to create higher resolution output.
- use tiling to create high res pictures: https://github.com/ProGamerGov/Neural-Tile/
- Check this out to create high res pictures: https://github.com/jcjohnson/neural-style/wiki/Techniques-For-Increasing-Image-Quality-Without-Buying-a-Better-GPU
- Check this script and how to increase the pic resolution: https://pastebin.com/YV4JC5Jn
- https://letsenhance.io/boost allows you to increase pic resolution size with very good results. This is a paid service though. You can run it yourself as well, see here https://medium.com/machine-learning-world/how-to-replicate-lets-enhance-service-without-even-coding-3b6b31b0fa2e
- Created a hotmail and letsenchange account. Username is Kanboer183@hotmail.com and password is mvmdod*(DS??jkds89.
- Search google for image scaling neural networks "scale image neural network github"
- ProGamerGov proposes an approach here https://github.com/jcjohnson/neural-style/issues/351. First create a 512px image and then I used that image at the value for the -init_image command. I used the exact same command, including the same content image (It's a CC0 image I found) and style image. The image below is at 50 iterations and it had an -image_size value of 1000. The look at iteration 50 did not change at all really by iteration 400. Without using the init_image command, this is what it looks like at 50 iterations and 400 iterations. This technique to increase resolution is also used here https://pastebin.com/YV4JC5Jn. It looks like the init_image command can be used to significantly speed up the process of slowly increasing the -image_size value while constantly running the output through Neural-Style again.
- Check this out: https://www.reddit.com/r/deepdream/comments/8vuv5u/the_stanford_campus_uni8_script_prototype/. vic8760 shares his script (https://pastebin.com/xmhRGRc8) to get an image resolution of 4000 pixels.

# Other
- Some parameters in jcjohnson have scientific notations like 1e2, 5e0 and 1e-3. To convert to decimals go to https://coolconversion.com/math/scientific-notation-to-decimal/. 1e2 is 100, 5e0 is 5 and 1e-3 is 0.001. 
- the -init is a method for generating the generated image. You can choose either random or image. Default is random which uses a noise initialization as in the paper; image initializes with the content image. So if you want to initialize from a specific image then you need to pass -init image and give the path to your initialization image in -init_image.

# vic8760 uses these models:
- nin_imagenet_conv
- pascalcontext-fcn32s-heavy
- VGG_ILSVRC_19_layers

# Content and Style Layers
The lower the layer numbers, the more closer it is to the image, anything past Relu4_4 to relu5_4 is pure abstract. See this http://i.imgur.com/b6ngkPt.jpg for pictures per layer.

ReLU (Rectified Linear Units) Layers

Lower layers contain channels that are activated by for example, lines in different directions, or when the entire convolutional kernel is one color, or any other basic pixel level shape.

The next layer is activated by patterns in the activation of the lower layers. Here's where it starts getting harder to interpret what they actually detect. These channels respond to combinations of the more primitive things it's learned in the previous layer, like shapes or textures.

The highest layers encode the most abstract and complex things (once again based on patterns in the activations of the previous layers). A certain combination of lines, textures, and shapes all in the same part of the image might always activate together when there's a dog in the picture. This could cause one of these higher channels to be a kind of 'dog indicator' which activates whenever there's a dog in the picture. However, if the network wasn't trained on squirrels (which also happen to be furry and have dog-like heads) it might also activate and falsely claim that the squirrel in the picture is a dog!
