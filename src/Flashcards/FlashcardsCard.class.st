Class {
	#name : #FlashcardsCard,
	#superclass : #Object,
	#instVars : [
		'word',
		'translation',
		'leitnerBox',
		'isReversed'
	],
	#category : #Flashcards
}

{ #category : #'as yet unclassified' }
FlashcardsCard class >> word: aWord translation: aTranslation [
	^ self new
		initializeWord: aWord translation: aTranslation;
		yourself
]

{ #category : #'as yet unclassified' }
FlashcardsCard >> back [
	^ isReversed
		ifTrue: [ word ]
		ifFalse: [ translation ]
]

{ #category : #'as yet unclassified' }
FlashcardsCard >> front [
	^ isReversed
		ifTrue: [ translation ]
		ifFalse: [ word ]
]

{ #category : #initialization }
FlashcardsCard >> initialize [ 
	super initialize.
	leitnerBox := 1.
	isReversed := false.
]

{ #category : #initialization }
FlashcardsCard >> initializeWord: aWord translation: aTranslation [
	word := aWord.
	translation := aTranslation.
]

{ #category : #accessing }
FlashcardsCard >> leitnerBox [
	^ leitnerBox
]

{ #category : #accessing }
FlashcardsCard >> leitnerBox: anObject [
	leitnerBox := anObject
]

{ #category : #highlighting }
FlashcardsCard >> printOn: aStream [
	aStream nextPutAll: self class name; space; nextPutAll: self front printString
]

{ #category : #highlighting }
FlashcardsCard >> reverse [
	isReversed := isReversed not.
]
