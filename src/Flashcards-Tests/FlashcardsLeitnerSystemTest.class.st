"
A FlashcardsLeitnerSystemTest is a test class for testing the behavior of FlashcardsLeitnerSystem
"
Class {
	#name : #FlashcardsLeitnerSystemTest,
	#superclass : #TestCase,
	#category : #'Flashcards-Tests'
}

{ #category : #tests }
FlashcardsLeitnerSystemTest >> testDefaultProbabilities [

	| fls results topSelection |
	
	fls := FlashcardsLeitnerSystem withProbabilities: #(0.5 0.25 0.125).
	
	1 to: 3 do: [ :i | fls addCard: (Flashcard word: i translation: i) ].
	
	results := Bag new.
	
	1000 timesRepeat: [ 
		results add: fls selectRandomCard.
		fls processAnswer: 'wrong anser'].
	
	topSelection := results sortedCounts first.
	
	self assert: topSelection key > 300 description: 'Should be about 1/3 of the values'.
	self assert: topSelection key < 400 description: 'Should be about 1/3 of the values'.
	
	
		
	

]

{ #category : #tests }
FlashcardsLeitnerSystemTest >> testEarlierBoxesMoreProbableToGetPicked [

	| fls card1 card2 card3 results topSelection |
	
	fls := FlashcardsLeitnerSystem withProbabilities: #(0.7 0.2 0.1).
	
	card1 := Flashcard word: 1 translation: 1.
	card2 := Flashcard word: 2 translation: 2.
	card3 := Flashcard word: 3 translation: 3.
		
		
	"sneaky way to setup boxes in known state"
	{card1. card2. card3} doWithIndex: [ :item :i |
		(fls boxes at: i) addCard: item ].
	
	results := Bag new.
	
	10000 timesRepeat: [ 
		results add: fls selectRandomCard.
		fls returnSelectedCard  ].

	topSelection := results cumulativeCounts first.
	
	"results cumulativeCounts inspect."
	self assert: topSelection value equals: card1.
	
		
	

]
