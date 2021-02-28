extends Node2D

const Order = ['']

var Turn = 0
var Cards = []

func spawn(card):
	Cards.append(card)

func number(card):
	var n = card[0]
	match n:
		'A':
			return 1
		'J':
			return 11
		'Q':
			return 12
		'K':
			return 13
		_:
			return int(n)

#U: Gives a score between 0 and 16 based on the ranking of the card
func score(card):
	var n = number(card) #U: Number of the card
	var s = card[1] #U: Suit of the card
	
	if n >= 4 and n != 7:
		#A: Easy to score
		return n - 4 #[0, 9]
	elif n == 1:
		if s in ['H', 'D']:
			return 10 #A: Next after King
		elif s == 'C':
			return 15 #A: Second to highest
		else:
			return 16 #A: Highest one
	elif n == 2:
		return 11 #A: After the bad Aces
	elif n == 3:
		return 12 #A: After the Twos
	elif n == 7:
		if s in ['C', 'H']:
			return 3 #7 - 4
		elif s == 'D':
			return 13 #After the Threes
		else:
			return 14 #After the previous seven

func compare(c1, c2):
	var s1 = score(c1)
	var s2 = score(c2)
	
	if s1 > s2:
		pass
	elif s1 < s2:
		pass
	else: 
		#A: Tie
		pass

func play_card(card):
	if Turn % 2 == 0:
		spawn(card)
	else:
		var prev = Cards[-1]
		spawn(card)
		compare(prev, card)
	
	Turn += 1
