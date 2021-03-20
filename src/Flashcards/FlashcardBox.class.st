Class {
	#name : #FlashcardBox,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'Flashcards-Models'
}

{ #category : #adding }
FlashcardBox >> addCard: aCard [
	cards add: aCard
]

{ #category : #initialization }
FlashcardBox >> initialize [ 	
	super initialize.
	cards := OrderedCollection new.
]

{ #category : #testing }
FlashcardBox >> isEmpty [ 
	^ cards isEmpty 
]

{ #category : #accessing }
FlashcardBox >> numberOfCards [
	^ cards size
]

{ #category : #'as yet unclassified' }
FlashcardBox >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: '(cards: ';
		print: self numberOfCards;
		nextPut: $)
]

{ #category : #'as yet unclassified' }
FlashcardBox >> takeRandomCard [
	"Selects a random card, removes it from the box, and returns the selected card. This way the card is taken out of the box"
	| selectedCard |
	
	cards ifEmpty: [
		Error signal: 'A box is empty' ].
	
	selectedCard := cards atRandom.
	cards remove: selectedCard.
	^ selectedCard
]
