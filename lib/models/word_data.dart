//import 'package:flutter/material.dart';

//class WordItem {
  //final String name;
  //final IconData icon;
  //final String audioAsset;
  //final Color? color; // Only for colors

  //WordItem({
    //required this.name,
    //required this.icon,
    //required this.audioAsset,
    //this.color,
  //});
//} 

// --- Animals ---
final Map<String, List<Map<String, String>>> animals = {
  'A': [{'name': 'Ant', 'emoji': '🐜'}, {'name': 'Alligator', 'emoji': '🐊'}],
  'B': [{'name': 'Bear', 'emoji': '🐻'}, {'name': 'Bat', 'emoji': '🦇'}],
  'C': [{'name': 'Cat', 'emoji': '🐱'}, {'name': 'Camel', 'emoji': '🐫'}],
  'D': [{'name': 'Dog', 'emoji': '🐶'}, {'name': 'Deer', 'emoji': '🦌'}],
  'E': [{'name': 'Elephant', 'emoji': '🐘'}, {'name': 'Eagle', 'emoji': '🦅'}],
  'F': [{'name': 'Fox', 'emoji': '🦊'}, {'name': 'Frog', 'emoji': '🐸'}],
  'G': [{'name': 'Goat', 'emoji': '🐐'}, {'name': 'Giraffe', 'emoji': '🦒'}],
  'H': [{'name': 'Horse', 'emoji': '🐴'}, {'name': 'Hedgehog', 'emoji': '🦔'}],
  'I': [{'name': 'Iguana', 'emoji': '🦎'}, {'name': 'Impala', 'emoji': '🦌'}],
  'J': [{'name': 'Jaguar', 'emoji': '🐆'}, {'name': 'Jackal', 'emoji': '🦊'}],
  'K': [{'name': 'Kangaroo', 'emoji': '🦘'}, {'name': 'Koala', 'emoji': '🐨'}],
  'L': [{'name': 'Lion', 'emoji': '🦁'}, {'name': 'Leopard', 'emoji': '🐆'}],
  'M': [{'name': 'Monkey', 'emoji': '🐒'}, {'name': 'Mouse', 'emoji': '🐭'}],
  'N': [{'name': 'Newt', 'emoji': '🦎'}, {'name': 'Nightingale', 'emoji': '🐦'}],
  'O': [{'name': 'Owl', 'emoji': '🦉'}, {'name': 'Otter', 'emoji': '🦦'}],
  'P': [{'name': 'Pig', 'emoji': '🐷'}, {'name': 'Penguin', 'emoji': '🐧'}],
  'Q': [{'name': 'Quail', 'emoji': '🦃'}, {'name': 'Quokka', 'emoji': '🦡'}],
  'R': [{'name': 'Rabbit', 'emoji': '🐰'}, {'name': 'Raccoon', 'emoji': '🦝'}],
  'S': [{'name': 'Sheep', 'emoji': '🐑'}, {'name': 'Snake', 'emoji': '🐍'}],
  'T': [{'name': 'Tiger', 'emoji': '🐯'}, {'name': 'Turtle', 'emoji': '🐢'}],
  'U': [{'name': 'Urial', 'emoji': '🐏'}, {'name': 'Umbrellabird', 'emoji': '🐦'}],
  'V': [{'name': 'Vulture', 'emoji': '🦅'}, {'name': 'Vicuña', 'emoji': '🦙'}],
  'W': [{'name': 'Wolf', 'emoji': '🐺'}, {'name': 'Walrus', 'emoji': '🦭'}],
  'X': [{'name': 'Xerus', 'emoji': '🐿️'}],
  'Y': [{'name': 'Yak', 'emoji': '🐃'}, {'name': 'Yellowjacket', 'emoji': '🐝'}],
  'Z': [{'name': 'Zebra', 'emoji': '🦓'}, {'name': 'Zorilla', 'emoji': '🦨'}],
};

// --- Fruits ---
final Map<String, List<Map<String, String>>> fruits = {
  'A': [{'name': 'Apple', 'emoji': '🍎'}, {'name': 'Apricot', 'emoji': '🍑'}],
  'B': [{'name': 'Banana', 'emoji': '🍌'}, {'name': 'Blueberry', 'emoji': '🫐'}],
  'C': [{'name': 'Cherry', 'emoji': '🍒'}, {'name': 'Coconut', 'emoji': '🥥'}],
  'D': [{'name': 'Date', 'emoji': '🌴'}, {'name': 'Dragonfruit', 'emoji': '🐉'}],
  'E': [{'name': 'Elderberry', 'emoji': '🫐'}],
  'F': [{'name': 'Fig', 'emoji': '🍈'}],
  'G': [{'name': 'Grape', 'emoji': '🍇'}, {'name': 'Guava', 'emoji': '🥝'}],
  'H': [{'name': 'Honeydew', 'emoji': '🍈'}],
  'I': [{'name': 'Indian Fig', 'emoji': '🌵'}],
  'J': [{'name': 'Jackfruit', 'emoji': '🍈'}, {'name': 'Jujube', 'emoji': '🍎'}],
  'K': [{'name': 'Kiwi', 'emoji': '🥝'}, {'name': 'Kumquat', 'emoji': '🍊'}],
  'L': [{'name': 'Lemon', 'emoji': '🍋'}, {'name': 'Lychee', 'emoji': '🍈'}],
  'M': [{'name': 'Mango', 'emoji': '🥭'}, {'name': 'Melon', 'emoji': '🍈'}],
  'N': [{'name': 'Nectarine', 'emoji': '🍑'}],
  'O': [{'name': 'Orange', 'emoji': '🍊'}, {'name': 'Olive', 'emoji': '🫒'}],
  'P': [{'name': 'Papaya', 'emoji': '🍈'}, {'name': 'Peach', 'emoji': '🍑'}, {'name': 'Pear', 'emoji': '🍐'}, {'name': 'Pineapple', 'emoji': '🍍'}, {'name': 'Plum', 'emoji': '🍑'}],
  'Q': [{'name': 'Quince', 'emoji': '🍏'}],
  'R': [{'name': 'Raspberry', 'emoji': '🍓'}, {'name': 'Rambutan', 'emoji': '🍈'}],
  'S': [{'name': 'Strawberry', 'emoji': '🍓'}, {'name': 'Starfruit', 'emoji': '⭐'}],
  'T': [{'name': 'Tangerine', 'emoji': '🍊'}, {'name': 'Tomato', 'emoji': '🍅'}],
  'U': [{'name': 'Ugli Fruit', 'emoji': '🍋'}],
  'V': [{'name': 'Vanilla', 'emoji': '🌸'}],
  'W': [{'name': 'Watermelon', 'emoji': '🍉'}],
  'X': [{'name': 'Xigua', 'emoji': '🍉'}],
  'Y': [{'name': 'Yellow Passion Fruit', 'emoji': '🍈'}, {'name': 'Yunnan Hackberry', 'emoji': '🍏'}],
  'Z': [{'name': 'Ziziphus Fruit', 'emoji': '🍏'}],
};

// --- Vehicles ---
final Map<String, List<Map<String, String>>> vehicles = {
  'A': [{'name': 'Ambulance', 'emoji': '🚑'}, {'name': 'Airplane', 'emoji': '✈️'}],
  'B': [{'name': 'Bus', 'emoji': '🚌'}, {'name': 'Bicycle', 'emoji': '🚲'}, {'name': 'Boat', 'emoji': '⛵'}],
  'C': [{'name': 'Car', 'emoji': '🚗'}, {'name': 'Cargo Ship', 'emoji': '🚢'}],
  'D': [{'name': 'Dump Truck', 'emoji': '🚚'}, {'name': 'Drone', 'emoji': '🛸'}],
  'E': [{'name': 'Excavator', 'emoji': '🚜'}, {'name': 'Electric Car', 'emoji': '🚙'}],
  'F': [{'name': 'Fire Truck', 'emoji': '🚒'}, {'name': 'Ferry', 'emoji': '⛴️'}],
  'G': [{'name': 'Golf Cart', 'emoji': '🏎️'}, {'name': 'Garbage Truck', 'emoji': '🚛'}],
  'H': [{'name': 'Helicopter', 'emoji': '🚁'}, {'name': 'Hovercraft', 'emoji': '🛥️'}],
  'I': [{'name': 'Ice Cream Truck', 'emoji': '🚚'}],
  'J': [{'name': 'Jeep', 'emoji': '🚙'}, {'name': 'Jet', 'emoji': '🛩️'}],
  'K': [{'name': 'Kayak', 'emoji': '🛶'}, {'name': 'Kart', 'emoji': '🏎️'}],
  'L': [{'name': 'Limousine', 'emoji': '🚓'}, {'name': 'Loader', 'emoji': '🚜'}],
  'M': [{'name': 'Motorcycle', 'emoji': '🏍️'}, {'name': 'Metro', 'emoji': '🚇'}],
  'N': [{'name': 'Narrowboat', 'emoji': '🚤'}],
  'O': [{'name': 'Oil Tanker', 'emoji': '⛽'}],
  'P': [{'name': 'Police Car', 'emoji': '🚓'}, {'name': 'Pickup Truck', 'emoji': '🛻'}],
  'Q': [{'name': 'Quad Bike', 'emoji': '🏍️'}],
  'R': [{'name': 'Rocket', 'emoji': '🚀'}, {'name': 'Rickshaw', 'emoji': '🛺'}],
  'S': [{'name': 'Scooter', 'emoji': '🛴'}, {'name': 'Submarine', 'emoji': '🛳️'}],
  'T': [{'name': 'Tractor', 'emoji': '🚜'}, {'name': 'Train', 'emoji': '🚆'}, {'name': 'Taxi', 'emoji': '🚕'}],
  'U': [{'name': 'Unicycle', 'emoji': '🚲'}, {'name': 'Ute', 'emoji': '🚙'}],
  'V': [{'name': 'Van', 'emoji': '🚐'}, {'name': 'Vespa', 'emoji': '🛵'}],
  'W': [{'name': 'Wheelchair', 'emoji': '🦽'}, {'name': 'Wagon', 'emoji': '🚃'}],
  'X': [{'name': 'X-ray Truck', 'emoji': '🚚'}],
  'Y': [{'name': 'Yacht', 'emoji': '🛥️'}, {'name': 'Yamaha', 'emoji': '🏍️'}],
  'Z': [{'name': 'Zeppelin', 'emoji': '🛩️'}],
};

// --- Colors ---
final Map<String, List<Map<String, String>>> colors = {
  'A': [{'name': 'Amber', 'emoji': '🟧'}, {'name': 'Aqua', 'emoji': '🟦'}],
  'B': [{'name': 'Blue', 'emoji': '🟦'}, {'name': 'Beige', 'emoji': '⬜'}, {'name': 'Brown', 'emoji': '🟫'}],
  'C': [{'name': 'Cyan', 'emoji': '🟦'}, {'name': 'Crimson', 'emoji': '🟥'}],
  'D': [{'name': 'Denim', 'emoji': '🟦'}, {'name': 'Dark Green', 'emoji': '🟩'}],
  'E': [{'name': 'Emerald', 'emoji': '🟩'}, {'name': 'Eggplant', 'emoji': '🟪'}],
  'F': [{'name': 'Fuchsia', 'emoji': '🟪'}],
  'G': [{'name': 'Green', 'emoji': '🟩'}, {'name': 'Gold', 'emoji': '🟨'}, {'name': 'Gray', 'emoji': '⬜'}],
  'H': [{'name': 'Honey', 'emoji': '🟨'}, {'name': 'Hot Pink', 'emoji': '🟪'}],
  'I': [{'name': 'Indigo', 'emoji': '🟦'}, {'name': 'Ivory', 'emoji': '⬜'}],
  'J': [{'name': 'Jade', 'emoji': '🟩'}, {'name': 'Jet Black', 'emoji': '⬛'}],
  'K': [{'name': 'Khaki', 'emoji': '🟫'}],
  'L': [{'name': 'Lavender', 'emoji': '🟪'}, {'name': 'Lime', 'emoji': '🟩'}],
  'M': [{'name': 'Magenta', 'emoji': '🟪'}, {'name': 'Maroon', 'emoji': '🟥'}, {'name': 'Mint', 'emoji': '🟩'}],
  'N': [{'name': 'Navy', 'emoji': '🟦'}, {'name': 'Nude', 'emoji': '⬜'}],
  'O': [{'name': 'Orange', 'emoji': '🟧'}, {'name': 'Olive', 'emoji': '🟩'}],
  'P': [{'name': 'Pink', 'emoji': '🟪'}, {'name': 'Purple', 'emoji': '🟪'}, {'name': 'Peach', 'emoji': '🟧'}],
  'Q': [{'name': 'Quartz', 'emoji': '⬜'}],
  'R': [{'name': 'Red', 'emoji': '🟥'}, {'name': 'Rose', 'emoji': '🌹'}],
  'S': [{'name': 'Silver', 'emoji': '⬜'}, {'name': 'Sky Blue', 'emoji': '🟦'}],
  'T': [{'name': 'Turquoise', 'emoji': '🟦'}, {'name': 'Tan', 'emoji': '🟫'}, {'name': 'Teal', 'emoji': '🟩'}],
  'U': [{'name': 'Ultramarine', 'emoji': '🟦'}],
  'V': [{'name': 'Violet', 'emoji': '🟪'}],
  'W': [{'name': 'White', 'emoji': '⬜'}, {'name': 'Wine', 'emoji': '🟥'}],
  'X': [{'name': 'Xanadu', 'emoji': '🟩'}],
  'Y': [{'name': 'Yellow', 'emoji': '🟨'}, {'name': 'Yellow Green', 'emoji': '🟩'}],
  'Z': [{'name': 'Zaffre', 'emoji': '🟦'}],
};