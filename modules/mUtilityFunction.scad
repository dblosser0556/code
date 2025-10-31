
// Utility function to look up a value by key in a list of key-value pairs (dictionary).
// Returns undef if the key is not found.
// Example usage:
// my_dict = [ ["sam", 1], ["bill", 2], ["charley", 3] ];
// value = dict_lookup("bill", my_dict); // value will be 2
function dict_lookup(key, table) = 
    let ( found_item = [for (item = table) if (item[0] == key) item[1] ] )
        len(found_item) > 0 ? found_item[0] : undef;


