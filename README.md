# SushiProjectZero

This project is about Objection by using Tensorflow, Tensorflow Lite to detect 10 types of sushi and using Flutter.

## why?
Beacuse I like to fix the problem and cut-corner. To make our life easier with technology. it's 2020 man modern problems require modern solutions!!

<img src="https://media.giphy.com/media/9058ZMj6ooluP4UUPl/giphy.gif">

## Concept
I would like to devlop the applicaton that can detect various types of sushi and calculate all those price.
So, employees don't need to think what kind of sushi that customer took. 
Moreover, new employees don't need to remember how many type of sushi what we're selling, what price are they.

## How it's work?
I use Tensorflow 1.5 as the framework, and convert to Tensorflow lite and use with Flutter.
TensorFlow is Google's open source AI framework for machine learning and high performance numerical computation.
I use around 2000 images of 10 types of sushi. Which is around 200 pre class.
I divided images into 2 set, first is test set in 10% of total iamges and Second is train set with 90% of images.

- To train the custom model, I use google Co-lab because higher gpu power that my notebook.
- The model took around 3 days,since the loss rate is not getting anylower(how low of loss rate is, more accuracy it's going to be )

## Setup
This the how to setup your phone position
- The phone need to be over the object(sushi) at least all of sushi needs to fit in the frame
- The sushi detection will able to define by top's of sushi, not side of sushi. 
- when you take photo, it's should look like this
<img src="https://user-images.githubusercontent.com/39997819/114253739-9ada1780-99d5-11eb-9bc0-e4b80de8087b.jpg">

## How to use
<img src="https://user-images.githubusercontent.com/39997819/114254216-3f5d5900-99d8-11eb-87a6-7d63d5746db2.jpg">{:height="50%" width="50%"}
From left to right

- The first section is Tensorflow detection, just press the btn to take the photo. The result will show image with label node over the image
- Second, for at extra sushi into list, or some sushi that has't been detected.
- Next, Is show the list of sushi.
- Lastly, just calculator.


## Types of sushi
<img src="https://user-images.githubusercontent.com/39997819/114253368-1aff7d80-99d4-11eb-972c-3533a406bf58.png">
I used image 10 types of sushi.

- Salmon
- Maguro
- Eel
- Crab
- Omelette
- Squid
- Saba
- Inari
- Tuna
- Wakame


## Getting Started
This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:


- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

I lost my soul while developing this app...

<img src="https://media.giphy.com/media/zOvBKUUEERdNm/giphy.gif"  />