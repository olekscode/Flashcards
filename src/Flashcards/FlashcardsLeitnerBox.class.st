Class {
	#name : #FlashcardsLeitnerBox,
	#superclass : #Object,
	#instVars : [
		'number',
		'cards',
		'probability'
	],
	#category : #Flashcards
}

{ #category : #'as yet unclassified' }
FlashcardsLeitnerBox class >> number: aBoxNumber probability: aNumber [
	^ self new
		initializeNumber: aBoxNumber probability: aNumber;
		yourself.
]

{ #category : #adding }
FlashcardsLeitnerBox >> addCard: aCard [
	cards add: aCard
]

{ #category : #initialization }
FlashcardsLeitnerBox >> initialize [ 	
	super initialize.
	cards := OrderedCollection new.
]

{ #category : #initialization }
FlashcardsLeitnerBox >> initializeNumber: aBoxNumber probability: aNumber [
	number := aBoxNumber.
	probability := aNumber.
]

{ #category : #testing }
FlashcardsLeitnerBox >> isEmpty [ 
	^ cards isEmpty 
]

{ #category : #accessing }
FlashcardsLeitnerBox >> number [
	^ number
]

{ #category : #accessing }
FlashcardsLeitnerBox >> probability [
	^ probability
]

{ #category : #'as yet unclassified' }
FlashcardsLeitnerBox >> randomCard [
	cards ifEmpty: [
		Error signal: 'A box is empty' ].
	^ cards atRandom
]

{ #category : #adding }
FlashcardsLeitnerBox >> removeCard: aCard [
	cards remove: aCard
]

{ #category : #accessing }
FlashcardsLeitnerBox >> size [
	^ cards size
]
