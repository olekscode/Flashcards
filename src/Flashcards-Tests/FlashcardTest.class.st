Class {
	#name : #FlashcardTest,
	#superclass : #TestCase,
	#category : #'Flashcards-Tests'
}

{ #category : #tests }
FlashcardTest >> testAsFlashcard [
	| card |
	card := ('bonjour' -> 'hello') asFlashcard.
	
	self assert: card word equals: 'bonjour'.
	self assert: card translation equals: 'hello'.
]

{ #category : #tests }
FlashcardTest >> testEquality [
	| card1 card2 card3 card4 |
	
	card1 := ('bonjour' -> 'hello') asFlashcard.
	card2 := ('bonjour' -> 'hello') asFlashcard. "same as card1"
	card3 := ('salut' -> 'hello') asFlashcard. "different word"
	card4 := ('bonjour' -> 'good morning') asFlashcard. "different translation"
	
	self assert: card2 equals: card1.
	self deny: card3 equals: card1.
	self deny: card4 equals: card1.
]

{ #category : #tests }
FlashcardTest >> testHash [
	| card1 card2 card3 card4 |
	
	card1 := ('bonjour' -> 'hello') asFlashcard.
	card2 := ('bonjour' -> 'hello') asFlashcard. "same as card1"
	card3 := ('salut' -> 'hello') asFlashcard. "different word"
	card4 := ('bonjour' -> 'good morning') asFlashcard. "different translation"
	
	self assert: card2 hash equals: card1 hash.
	self deny: card3 hash equals: card1 hash.
	self deny: card4 hash equals: card1 hash.
]

{ #category : #tests }
FlashcardTest >> testWordTranslation [
	| card |
	card := Flashcard word: 'bonjour' translation: 'hello'.
	
	self assert: card word equals: 'bonjour'.
	self assert: card translation equals: 'hello'.
]
