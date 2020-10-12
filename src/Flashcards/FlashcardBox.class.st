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

{ #category : #adding }
FlashcardBox >> addCards: aCollectionOfCards [
	aCollectionOfCards do: [ :each | self addCard: each ].
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
FlashcardBox >> takeRandomCard [
	"Selects a random card, removes it from the box, and returns the selected card. This way the card is taken out of the box"
	| selectedCard |
	
	cards ifEmpty: [
		Error signal: 'A box is empty' ].
	
	selectedCard := cards atRandom.
	cards remove: selectedCard.
	^ selectedCard
]
