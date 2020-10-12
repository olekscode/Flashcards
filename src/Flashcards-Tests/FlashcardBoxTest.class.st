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
	
	box addCards: { card1 . card2 }.
	
	randomCard := box takeRandomCard.
	
	self assert: (randomCard = card1 or: [ randomCard = card2 ]).
	self assert: box numberOfCards equals: 1.
	
]

{ #category : #tests }
FlashcardBoxTest >> testTakeRandomCardIsUniform [
	| box card1 card2 randomPairs distribution |
	
	box := FlashcardBox new.
	card1 := ('bonjour' -> 'hello') asFlashcard.
	card2 := ('merci' -> 'thank you') asFlashcard.
	
	randomPairs := (1 to: 10000) collect: [ :i |
		box addCards: { card1 . card2 }.
		{ box takeRandomCard . box takeRandomCard } ].
	
	distribution := randomPairs asBag valuesAndCounts / randomPairs size asFloat.
	
	self assert: distribution size equals: 2.
	self assert: ((distribution at: { card1 . card2 }) - 0.5) abs < 0.05. "close to 0.5"
	self assert: ((distribution at: { card2 . card1 }) - 0.5) abs < 0.05. "close to 0.5"
]
