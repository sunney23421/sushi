# SushiProjectZero

This project is all about using object detection and identify 10 types of sushi by using Tensorflow. The project use Flutter as a mobile frame work.

## Warning
This project will not beable to compile anymore. Thank to JFrog (Bintray), bintray server would be blocked since Jfrog is migrating the artifacts to Artifactory.[ref1](https://jfrog.com/blog/into-the-sunset-bintray-jcenter-gocenter-and-chartcenter/)and [ref2](https://stackoverflow.com/questions/70309075/problems-in-android-repository-flutter-tensorflow-lite-by-bintray-502)

The error is
"Unable to load Maven meta-data from https://google.bintray.com/exoplayer/org/tensorflow/tensorflow-lite/maven-metadata.xml."

## Why?
The reason why I've decided to create this app is beacuse I like to solve problems and cut-corners. I'd like to make our life easier by using technologies. It's 2021, modern problems require modern solutions!!

<img src="https://media.giphy.com/media/9058ZMj6ooluP4UUPl/giphy.gif">

## Concept
I'd like to develop application that can detect various types of sushi and calculate total price.
Application is full of advantages that will make their life easier. An employee can save time by useing my app tp recognize what kind of sushi a customers took. 
Moreover, new employees don't have to waste their time by remembering each type of sushi and its price. My apptlication will do all hard work for you.

## How it's work?
I've used Tensorflow 1.5 as the framework, converted to Tensorflow lite and use with Flutter.
TensorFlow is Google's open source AI framework for machine learning and high performance numerical computation.
I used around 2000 images of 10 types of sushi, which is around 200 pre class.
I divided images into 2 sets: 
First is, test set in 10% of total iamges. Second is, train set with 90% of images.

- To train the custom model, I use google Co-lab because of higher GPU power than my laptop.
- The model took me around 3 days, since loss rate didn't get any lower (lower loss rate is, more accurate it's going to be).

## Setup
This is how to setup your phone position.
- The phone need to be above the object(sushi) at least all of them must fit into the screen.
- The sushi detection will be able to identify the top layer of sushi only, not sides.
- When you took a  photo, it should look like this.
<img src="https://user-images.githubusercontent.com/39997819/114253739-9ada1780-99d5-11eb-9bc0-e4b80de8087b.jpg">

## How to use
<img src="https://user-images.githubusercontent.com/39997819/114254216-3f5d5900-99d8-11eb-87a6-7d63d5746db2.jpg" width="400" height="790">
From left to right

- First, press the button to take a photo. As a result, the name of the sushi will appear on the top of the sushi you took picture of.
- Second, in case of non-recognition or adding extra sushi into the list, click on the upper right section with sushi. Or in case of wrong recognition, click the button on the lower left section with sushi.
- Next, as soon as you got everything correct, its ready for payment.
- Lastly, the total price of sushi will appear automatically and you can easily give a change to the customer.


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

Special thanks>> Shanya, I couldn't do it without you. Thank you, love you. :)

<img src="https://media.giphy.com/media/13awhIC2CcDaHC/giphy.gif"  />
