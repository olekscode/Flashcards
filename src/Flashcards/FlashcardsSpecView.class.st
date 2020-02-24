Class {
	#name : #FlashcardsSpecView,
	#superclass : #SpPresenter,
	#instVars : [
		'leitnerSystem',
		'currentCard',
		'card',
		'answer',
		'okButton'
	],
	#category : #Flashcards
}

{ #category : #specs }
FlashcardsSpecView class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #card;
		add: #answer;
		add: #okButton;
		yourself
]

{ #category : #'instance creation' }
FlashcardsSpecView class >> for: aLeitnerSystem [
	^ self new initializeSystem: aLeitnerSystem; yourself
]

{ #category : #accessing }
FlashcardsSpecView >> answer [
	^ answer
]

{ #category : #accessing }
FlashcardsSpecView >> answer: anObject [
	answer := anObject
]

{ #category : #accessing }
FlashcardsSpecView >> card [
	^ card
]

{ #category : #accessing }
FlashcardsSpecView >> card: anObject [
	card := anObject
]

{ #category : #initialization }
FlashcardsSpecView >> initializePresenters [ 
	card := self newButton
		yourself.
		
	answer := self newTextInput.
	
	okButton := self newButton
		label: 'OK';
		action: [ self validateAnswer ];
		yourself.
	
	
]

{ #category : #initialization }
FlashcardsSpecView >> initializeSystem: aLeitnerSystem [
	leitnerSystem := aLeitnerSystem.
	self showRandomCard.
]

{ #category : #accessing }
FlashcardsSpecView >> okButton [
	^ okButton
]

{ #category : #accessing }
FlashcardsSpecView >> okButton: anObject [
	okButton := anObject
]

{ #category : #'as yet unclassified' }
FlashcardsSpecView >> showRandomCard [
	currentCard := leitnerSystem randomCard.
	card label: currentCard front asString.
]

{ #category : #'as yet unclassified' }
FlashcardsSpecView >> validateAnswer [
	card label: currentCard back.
	card color: Color blue.

	answer text = currentCard back
		ifTrue: [
			card color: Color green.
			leitnerSystem moveForvard: currentCard ]
		ifFalse: [ 
			card color: Color red.
			leitnerSystem moveBackward: currentCard ].
		
	okButton
		label: 'Next';
		action: [ self showRandomCard ].
]
