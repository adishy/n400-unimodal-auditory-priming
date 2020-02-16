#==================================================================================#
#                                                                                  #
#   Paradigm: N400 Sound-spoken word paradigm                                      #
#                                                                                  #
#   Lab: Language, Memory and Brain Lab                                            #
#                                                                                  #
#   Desciption: 122 sounds paired with either cong or                              #
#   incong spoken words.                                                           #
#                                                                                  #
#   Written by: Netri Pajankar, pajankan@mcmaster.ca                               #
#               Adianes Herrera, herrea2@mcmaster.ca                               #
#                                                                                  #                   
#==================================================================================#
#
#	
#
#####################################################################################
# Header block
#####################################################################################

scenario = "N4SW";
no_logfile = true;

# config les pulses!!
write_codes = false;
pulse_width = 10;

# font
default_font_size = 32;
default_font = "MS Mincho";

response_matching = simple_matching;
active_buttons = 1;
button_codes = 10;

default_attenuation = .1; #attenuates sound by 10 dB
#####################################################################################
# SDL block
#####################################################################################

begin;

sound { wavefile { preload = false; } wavep; } prime;
sound { wavefile { preload = false; } wavet; } target;

trial {
	start_delay = 2000; #CHANGE ME FOR INTERTRIAL INTERVAL
	stimulus_event {
		picture {
			text { caption = "+"; } blankText;
			x = 0; y = 0;
		} blankPic;
		
		#duration = 10;
	} blankEvent;

	stimulus_event {
		sound prime;
		delta_time = 0;
		code = "C";		# C: congruent; IC: incongruent
		#port_code = 5;
	} primeEvent;
	
	stimulus_event {
		sound target;		
		time = 1500;	
		#port_code = 1; # 1: congruent; 2: incongruent
	} targetEvent;
} wordPairTrial;   

#####################################################################################
# PCL block
#####################################################################################

begin_pcl;

# Experiment-specific parameters

string congruentPairsFileName = "";
string incongruentPairsFileName = "IncongruentPairs.txt";

#See line 396 for SOA and ISI. Interpairs: duration of audio file played.
#int silencePadding = 100; # ms ORIGINALLY 100 *****
int interPairs = 1800; # ms     ORIGINALLY 1250 *****
#double jbdnasf = 1.343; # Variables whose values are determined from input

# 1 Read word list and load sound files
# Format:
# S01 R01
# S02 U02

# Column 1: Sound filename, Column 2: Word filename, Column 3: "related"/"unrelated"
array <string> sounds_and_words[0][3];
string input_filename = "sound_word_list.txt";
input_file fp = new input_file;

# Opening the file specified by input_filename
fp.open( input_filename );

#Read in first line
string row = fp.get_string();
int num_rows = 0;

#Loop until there are no more lines in the file
loop until !fp.last_succeeded() 
begin
	num_rows = num_rows + 1;
		
	# We get the string "S_01,W01_R" from the file
	array<string> filenames[2];

	# We split it into an array with two strings: [ "S_01", "W01_R" ]
	row.split(",", filenames);
	
	string sound_filename = filenames[1];

	string word_filename = filenames[2];

	# We take the word file name "W01_R" and split it on _ to get an array to extract R or UR -> ["W01", "R"]
	array <string> word_filename_components[2];

	word_filename.split("_", word_filename_components);

	string r_or_ur = word_filename_components[2]; #'R', 'U'	
	
	array <string> row_elements[0];
	row_elements.add(sound_filename);
	row_elements.add(word_filename);
	row_elements.add(r_or_ur);
	
	sounds_and_words.add(row_elements);
	
	# Load sound .wav file
	#wavefile sf = new wavefile(sound_filename + ".wav");
	#sf.load(); 
	#sounds_and_words[numWords][0] = new sound(sf)

	# Load word .wav file
	#wavefile wf = new wavefile(word_filename + ".wav");
	#wf.load()
	#sounds_and_words[numWords][1] = new sound(wf);
	
	row = fp.get_string();
end;
fp.close();


#Loop until there are no more lines in the file
loop int i=1 until i>num_rows
begin
	term.print("Row: "); 
	term.print(i); 
	term.print(" Sound filename: " + sounds_and_words[i][1]); 
	term.print(" Word filename: " + sounds_and_words[i][2]);
	term.print_line(" Related: " 		+ sounds_and_words[i][3]);
	i = i + 1
end;

### NOTICE: i was originally initialized to 2, NOT 1
#loop int i=1 until i>numPairs
#begin

#	term.print_line(i);

	# for prime
#	int primeIndex = wordPairArray[i][1];

#	primeEvent.set_stimulus(wordSoundArray[primeIndex]);
	
#	if (wordPairArray[i][3]==1) then # Congruent
#		primeEvent.set_event_code("C");
#	else
#		primeEvent.set_event_code("IC");
#	end;
	
	#targetEvent.set_port_code(wordPairArray[i][3]); ## USED to be primeEvent...port_code

	# for target
	#int targetIndex = wordPairArray[i][2]; #102
	#wordSoundArrat[102]
	#targetEvent.set_stimulus(wordSoundArray[targetIndex]);
	
	#wordPairTrial.present();
	#played = played + 1;
	#term.print("played: "); term.print_line(played);
	
	#i = i + 1;
#end;




 

