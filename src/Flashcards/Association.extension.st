Extension { #name : #Association }

{ #category : #'*Flashcards' }
Association >> asFlashcard [
	^ Flashcard word: key translation: value.
]
