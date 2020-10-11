"
A FlashcardsLeitnerSystemTest is a test class for testing the behavior of FlashcardsLeitnerSystem
"
Class {
	#name : #FlashcardsLeitnerSystemTest,
	#superclass : #TestCase,
	#category : #'Flashcards-Tests'
}

{ #category : #tests }
FlashcardsLeitnerSystemTest >> testEarlierBoxesMoreProbableToGetPicked [

	| fls boxes card1 card2 card3 results stat card4 |
	fls := FlashcardsLeitnerSystem withProbabilities: #(0.5 0.75 0.9 1) reversed .
	boxes := fls boxes.
	
	
	fls 
		addCard: (card1 := FlashcardsCard word: 1 translation: 1);
		addCard: (card2 := FlashcardsCard word: 2 translation: 2);
		addCard: (card3 := FlashcardsCard word: 3 translation: 3);
		addCard: (card4 := FlashcardsCard word: 4 translation: 4).
		
	fls moveForward: card2.
	fls moveForward: card3; moveForward: card3.
	fls moveForward: card4; moveForward: card4; moveForward: card4.
	
	results := Bag new.
	
	10000 timesRepeat: [ 
		results add: fls randomCard ].

	stat := results cumulativeCounts first.
	
	"results cumulativeCounts inspect."
	self assert: stat value equals: card1.
	
		
	

]

{ #category : #tests }
FlashcardsLeitnerSystemTest >> testSuccessiveBoxesHaveMonotonicIncreasingProbabilities [

	| fls boxes |
	fls := FlashcardsLeitnerSystem withProbabilities: #(0.5 0.25 0.125).
	boxes := fls boxes.
	
	
	self assert: boxes first probability equals: 0.5.
	self assert: boxes second probability equals: 0.75.
	self assert: boxes third probability equals: 0.875.

]
