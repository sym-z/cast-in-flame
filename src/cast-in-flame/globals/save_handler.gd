extends Node

# Derrived from https://github.com/jible/capstone/blob/main/save_handler.gd
var save_path = "user://savegame.save"
var saves_received = 0
var saves_complete = 0
var save_dictionary = {}
var to_save = []

'''
HOW IT WORKS:
When the game opens, this loads a dictionary of save data from the save file.
That dictionary is stored here. When any script calls load_from_key, 
it will grab its respective entry from that dictionary.



USE:
To give a script save/load functionality:
Add a unique "save_key" that is used to store and access its save info.
Add a an event listener for the global "save" event
On that event, 
	call save_handler.incremenet_save_received
	save each of the important variables in a script via a save function
	to a string based dictionary. 
When the saves are complete, write to file.
Ex:
var seed = 12345
var level = "lust"
->
{
	"seed": 12345,
	"level": "lust",
}



Would have done it this way, but:
While drafting this, I thought it might be helpful to allow saving individual nodes instead of only allowing all at once,
but I couldn't imagine a situation where that would be necessary.
It would be easy to add the feature, but it would entail modifying the given key of the save dictionary, 
but it would still need to re-write the entire save file at save_path, so it might as well just save the whole game every time.

Additionally, we should just save the game whenever the player dies, or closes the game. That way it is easy to manage and keep the saves clean.
It would be hard to manage what has been saved and what hasn't if things were individually saved.

If we want to support saving in the middle of runs (saving what level you are on and that your currecny), 
it will still work just using that
--------------

'''



func load_game():
	'''
	Loads data from save path into save dictionary
	'''
	pass

func load_from_key(key: String)-> Dictionary:
	'''
	Given a node's specific key, it returns that node's save information from the save dictionary
	'''
	var output = {}
	return output


func save_game():
	'''
	Emits signal to save game.
	When each script receives that signal, it 
	'''
	saves_received = 0
	pass

func increment_saves_received():
	'''
	Increments the saves receieved counter.
	Node's save function should call this when they start
	'''
	saves_received += 1
	pass

func save_to_key(key, data):
	'''
	Nodes listening for the save signal will call this function with their unique save key and data
	
	'''
	
	saves_complete += 1
	if saves_complete >= saves_received:
		write_to_file()
	pass


func write_to_file():
	'''
	Writes the current save dictionary to the file at save_path
	'''
	
	pass
