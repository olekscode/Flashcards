Class {
	#name : #Flashcard,
	#superclass : #Object,
	#instVars : [
		'word',
		'translation'
	],
	#category : #'Flashcards-Models'
}

{ #category : #'as yet unclassified' }
Flashcard class >> word: aWord translation: aTranslation [
	^ self new
		initializeWord: aWord translation: aTranslation;
		yourself
]

{ #category : #comparing }
Flashcard >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject word = word and: [
		anObject translation = translation ].
]

{ #category : #comparing }
Flashcard >> hash [
	^ word hash bitXor: translation hash
]

{ #category : #initialization }
Flashcard >> initializeWord: aWord translation: aTranslation [
	word := aWord.
	translation := aTranslation.
]

{ #category : #accessing }
Flashcard >> translation [
	^ translation
]

{ #category : #accessing }
Flashcard >> translation: anObject [
	translation := anObject
]

{ #category : #accessing }
Flashcard >> word [
	^ word
]

{ #category : #accessing }
Flashcard >> word: anObject [
	word := anObject
]
