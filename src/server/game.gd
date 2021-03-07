extends Node

var Players #U: Each turn the players go in the order of this list

var Turn = 0 #U: Who won each turn
var History = [] #U: Card history

#U: Standard 40 card deck for Truco.
#'A'ce, 'J'ack, 'Q'ueen, 'K'ing
#'C'lubs = Basto
#'S'pades = Espada
#'H'earts = Copa
#'D'iamonds = Oro
var Deck = ['AC', '2C', '3C', '4C', '5C', '6C', '7C', 'XC', 'KC', 'JC', 'QC', 'AS', '2S', '3S', '4S', '5S', '6S', '7S', 'XS', 'KS', 'JS', 'QS', 'AD', '2D', '3D', '4D', '5D', '6D', '7D', 'XD', 'KD', 'JD', 'QD', 'AH', '2H', '3H', '4H', '5H', '6H', '7H', 'XH', 'KH', 'JH', 'QH']

#U: SHuffles the deck and deals 3 cards to both players
func shuffle_deck():
	Deck.shuffle()
	
	for i in range(2):
		var cards = [Deck[0 + i * 3], Deck[1 + i * 3], Deck[2 + i * 3]]
		var id = Players[i]
		STC.send(id, 'receive_cards', cards)

#U: Returns the other player's id
func other_player(id):
	return Players[(Players.find(id) + 1) % 2]

func number(card):
	var n = card[0]
	match n:
		'A':
			return 1
		'X':
			return 10
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

#U: Compares two cards and decides who won
func compare(c1, c2):
	var s1 = score(c1)
	var s2 = score(c2)
	
	if s1 > s2:
		return 0
	elif s1 < s2:
		return 1
	else: 
		return 0

#U: Spawns a card on the field
func field_spawn(data):
	History.append(data.number)
	
	for id in Players:
		STC.send(id, 'field_spawn', data)

#U: Checks if you can throw the card and throws it
func throw_card(data):
	if data.id == Players[Turn % 2]:
		#A: It's this player's turn
		field_spawn(data)
		
		if Turn % 2 == 1:
			#A: Response card
			var by = compare(History[-2], History[-1]) #A: Comparing the last two cards
			
			Players = [Players[by], Players[(by + 1) % 2]]
			#A: Shifted the array by "by"
		
		STC.send(data.id, 'remove_from_hand', data.name) #A: Whoever threw it removes it from their hand
		STC.send(other_player(data.id), 'remove_from_enemy') #A: The enemy removes a card from THEIR enemy's hand
		
		Turn += 1
		
		if Turn % 6 == 0:
			#A: End of match
			end_match()

func end_match():
	STC.send(Players[0], 'end_match')
	STC.send(Players[1], 'end_match')

func _ready():
	shuffle_deck()
	
	Players.shuffle()
