Class {
	#name : #FlashcardsLeitnerSystem,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'random'
	],
	#category : #Flashcards
}

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem class >> withProbabilities: aCollectionOfProbabilities [
	^ self new
		initializeProbabilities: aCollectionOfProbabilities;
		yourself
]

{ #category : #adding }
FlashcardsLeitnerSystem >> addCard: aCard [
	boxes first addCard: aCard.
	aCard leitnerBox: boxes first.
]

{ #category : #accessing }
FlashcardsLeitnerSystem >> boxes [
	^boxes
]

{ #category : #initialization }
FlashcardsLeitnerSystem >> initialize [ 
	super initialize.
	random := Random new.
]

{ #category : #initialization }
FlashcardsLeitnerSystem >> initializeProbabilities: aCollectionOfProbabilities [
	| sum |
	sum := 0.
	
	boxes := aCollectionOfProbabilities withIndexCollect: [ :probability :i |
		sum := sum + probability.
		FlashcardsLeitnerBox number: i probability: sum ].
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> moveBackward: aCard [
	| currentBox newBox |
	currentBox := aCard leitnerBox.
	newBox := boxes first.
	
	currentBox removeCard: aCard.
	newBox addCard: aCard.
	aCard leitnerBox: newBox.
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> moveForward: aCard [
	| currentBox newBox |
	currentBox := aCard leitnerBox.
	
	currentBox = boxes last
		ifTrue: [ ^ self ].

	newBox := boxes at: (currentBox number + 1).
		
	currentBox removeCard: aCard.
	newBox addCard: aCard.
	aCard leitnerBox: newBox
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> numberOfBoxes [
	^ boxes size
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> processAnswer: anAnswer onCard: aCard [
	anAnswer = aCard back
		ifTrue: [ self moveForward: aCard ]
		ifFalse: [ self moveBackward: aCard ]
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> randomBox [
	| nonemptyBoxes scalingCoefficient sumOfProbabilities randomNumber scaledProbability |
	nonemptyBoxes := boxes reject: [ :box | box isEmpty ].
	
	nonemptyBoxes ifEmpty: [
		Error signal: 'All boxes are empty' ].
	
	sumOfProbabilities := nonemptyBoxes inject: 0 into: [ :sum :box | box probability ].
	scalingCoefficient := 1 / sumOfProbabilities.
	sumOfProbabilities := 0.
	
	randomNumber := random next.
	
	^ nonemptyBoxes detect: [ :box |
		scaledProbability := box probability * scalingCoefficient.
		sumOfProbabilities := sumOfProbabilities + scaledProbability.
		randomNumber <= sumOfProbabilities ]
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem >> randomCard [
	^ self randomBox randomCard
]
