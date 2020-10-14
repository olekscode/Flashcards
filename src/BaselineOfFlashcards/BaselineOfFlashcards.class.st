Class {
	#name : #BaselineOfFlashcards,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlashcards
}

{ #category : #baselines }
BaselineOfFlashcards >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			spec
				package: 'Flashcards';
				package: 'Flashcards-Tests' ]


]
