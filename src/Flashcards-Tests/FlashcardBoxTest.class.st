Class {
	#name : #FlashcardBoxTest,
	#superclass : #TestCase,
	#category : #'Flashcards-Tests'
}

{ #category : #tests }
FlashcardBoxTest >> testAddCard [
	| box card |
	box := FlashcardBox new.
	card := ('bonjour' -> 'hello') asFlashcard.
	
	self assert: box numberOfCards equals: 0.
	box addCard: card.
	
	self assert: box numberOfCards equals: 1.
]

{ #category : #tests }
FlashcardBoxTest >> testTakeRandomCard [
	| box card1 card2 randomCard |
	
	box := FlashcardBox new.
	card1 := ('bonjour' -> 'hello') asFlashcard.
	card2 := ('merci' -> 'thank you') asFlashcard.
	
	box
		addCard: card1;
		addCard: card2.
	
	randomCard := box takeRandomCard.
	
	self assert: (randomCard = card1 or: [ randomCard = card2 ]).
	self assert: box numberOfCards equals: 1.
	
]
