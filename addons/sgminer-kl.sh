whiptail --msgbox 'Replacing sgminer-brian112358-x16r-v0.4.0 with sgminer-kl-1.0.5' --backtitle 'sgminer-kl' --title 'Replacing sgminer-brian112358-x16r-v0.4.0' 15 55
clear
wget https://github.com/KL0nLutiy/sgminer-kl/releases/download/kl-1.0.5fix/sgminer-kl-1.0.5_fix-linux.zip
unzip sgminer-kl-1.0.5_fix-linux.zip
sudo rm -rf /root/miner_org/sgminer-brian112358-x16r-v0.4.0
sudo mv sgminer-kl-1.0.5_fix-linux /root/miner_org/sgminer-brian112358-x16r-v0.4.0
rm sgminer-kl-1.0.5_fix-linux.zip
whiptail --msgbox 'Go to http://simplemining.net and setup a new rig group for 
sgminer-brian112358-x16r-v0.4.0 that is now sgminer-kl-1.0.5' --backtitle 'sgminer-kl-1.0.5' --title 
'sgminer-kl-1.0.5' 15 55
clear
echo "              777??777\n           7777I77+~::?7\n          7777+I~     ,I7:\n         77++7+=        
+77\n        7+++~+++        =+?7\n       ,II +7+I?++?,   +++++:\n       ?  +7777++++++  +?:I++\n       
+ ,777777+++++ ++++II+7\n      +  ??777?++++++  :++=:+7\n      7  ~?7++++++++=   ?7I+++~\n      I  ?  
?  :+++    ~:I=++++\n     I7: ,      ,+7     :+:++=++\n      ?   ~     ++      =+?,+~:+~\n     ++?      
:++++      ++::+:++\n     7+++7?+++++++++     :+++,+?+\n     7+I:++7+++++:   === : 7++:+++\n     
?++++++++        === = ~+++7+\n      +++++++           =   ,  :+:\n      +: + +  ==~:  =           
::\n        ++     =              ,  +\n     +,  :    =                 ==\n      ~:    =?==:   ~==          
,\n      : =    =++   = ==:\n               ?  ===="
