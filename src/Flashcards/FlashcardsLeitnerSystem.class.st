Class {
	#name : #FlashcardsLeitnerSystem,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'random',
		'boxCumulativeProbabilities',
		'selectedBoxNumber',
		'selectedCard'
	],
	#category : #'Flashcards-Controllers'
}

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem class >> defaultProbabilities [
	^ #(0.5 0.25 0.125 0.05)
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerSystem class >> withProbabilities: aCollectionOfProbabilities [
	^ self new
		initializeProbabilities: aCollectionOfProbabilities;
		yourself
]

{ #category : #public }
FlashcardsLeitnerSystem >> addCard: aCard [
	"The new card always goes into the first box"
	boxes first addCard: aCard.
]

{ #category : #accessing }
FlashcardsLeitnerSystem >> boxes [
	^ boxes
]

{ #category : #initialization }
FlashcardsLeitnerSystem >> initialize [ 
	super initialize.
	random := Random new.
	boxes := OrderedCollection new.
	
	self initializeDefaultProbabilities.
]

{ #category : #initialization }
FlashcardsLeitnerSystem >> initializeDefaultProbabilities [
	self initializeProbabilities: self class defaultProbabilities.
]

{ #category : #initialization }
FlashcardsLeitnerSystem >> initializeProbabilities: aCollectionOfProbabilities [
	| sum |
	
	aCollectionOfProbabilities size timesRepeat: [ boxes add: FlashcardBox new ].
	
	sum := 0.
	boxCumulativeProbabilities := Dictionary new.
	
	aCollectionOfProbabilities withIndexDo: [ :probability :i |
		sum := sum + probability.
		boxCumulativeProbabilities at: (boxes at: i) put: sum ].
]

{ #category : #private }
FlashcardsLeitnerSystem >> moveSelectedCardBackwards [
	"This happens if the answer was wrong. The card is moved back to the first box"
	boxes first addCard: selectedCard.
]

{ #category : #private }
FlashcardsLeitnerSystem >> moveSelectedCardForward [
	"This happens if the answer is correct. The card should progress to the next box. And if it was already taken from the last box, it is put back into the last box"
	| nextBoxNumber |
	
	nextBoxNumber := selectedBoxNumber = boxes size
		ifTrue: [ selectedBoxNumber ]
		ifFalse: [ selectedBoxNumber + 1].
		
	(boxes at: selectedBoxNumber) addCard: selectedCard.
]

{ #category : #accessing }
FlashcardsLeitnerSystem >> numberOfBoxes [
	^ boxes size
]

{ #category : #public }
FlashcardsLeitnerSystem >> processAnswer: anAnswer [
	"Check the answer and move the card forward if the answer is correct or move it backwards if the answer is wrong"
	anAnswer = selectedCard translation
		ifTrue: [ self moveSelectedCardForward ]
		ifFalse: [ self moveSelectedCardBackwards ]
]

{ #category : #private }
FlashcardsLeitnerSystem >> returnSelectedCard [
	"Put the selected card back in case you can't answer and want to pause"
	
	(boxes at: selectedBoxNumber) addCard: selectedCard.
]

{ #category : #private }
FlashcardsLeitnerSystem >> selectRandomBox [
	| nonemptyBoxes scalingCoefficient sumOfProbabilities randomNumber scaledProbability selectedBox |
	nonemptyBoxes := boxes reject: [ :box | box isEmpty ].
	
	nonemptyBoxes ifEmpty: [
		Error signal: 'All boxes are empty' ].
	
	sumOfProbabilities := (nonemptyBoxes collect: [ :box | boxCumulativeProbabilities at: box ]) sum.
	scalingCoefficient := 1 / sumOfProbabilities.
	
	randomNumber := random next.
	
	selectedBox := nonemptyBoxes detect: [ :box |
		scaledProbability := (boxCumulativeProbabilities at: box) * scalingCoefficient.
		randomNumber <= scaledProbability ].
	
	selectedBoxNumber := boxes indexOf: selectedBox.
]

{ #category : #public }
FlashcardsLeitnerSystem >> selectRandomCard [
	self selectRandomBox.
	^selectedCard := (boxes at: selectedBoxNumber) takeRandomCard.
]

{ #category : #accessing }
FlashcardsLeitnerSystem >> selectedBox [
	^ boxes at: selectedBoxNumber 
]

{ #category : #accessing }
FlashcardsLeitnerSystem >> selectedCard [
	^ selectedCard
]
