whiptail --msgbox 'Replacing progpowminer-v0.15.0-dev0-cuda9.1 with the Bitcoin Interest fork of ethminer-v0.15.0 
that supports the ProgPoW algorithm.' --backtitle 'ProgPow' --title 'Replacing progpowminer-v0.15.0-dev0-cuda9.1' 15 55
clear
wget https://www.bitcoininterest.io/downloads/bci_progpow_linux.zip
unzip bci_progpow_linux.zip
sudo rm -rf /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
sudo mv progpow_linux /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
chmod +x /root/miner_org/ethminer-v0.15.0/*
rm bci_progpow_linux.zip
cd /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
ln -s progpowminer_9.2 progpowminer
cd
whiptail --msgbox 'Go to http://simplemining.net and setup a new rig group for progpowminer-v0.15.0-dev0-cuda9.1 that now supports ProgPoW.' --backtitle 'ProgPow' --title 'ProgPoW' 
15 55
clear
echo "                                                                           
                             /######,                                          
                           (/(/*/(#%%%/**,                                     
                         /(/(//*,*/#,**/,/*,                                   
                        (((//*/*/*,*,****/%#%#                                 
                       ((((#%#%%%%,*,****/%%%%%                                
                      *%%%%%%%%%%%(/,***//(////                                
                      %%%%%%%#(//**////******,,*,.                             
                      %#/(///***(%%%#(////(&@ &#&&#                            
                      /*#%%%#(@@ &#*/**,,..#(&&,,                              
                   ,%%%####//%&&&&%   .*,*  *(#//                              
                       //////.(&&(    *  /*  ,////                             
                      *///////////     /*//    ,///                            
                      //////////.     .     #   .///.                          
                     #(((///////    .          ,/(#%%*                         
                    *%%%%%%%%%(//.              %%%%%%(                        
                    %%%%%%%%%%%%%                /%%%%%(                       
                   %%%%%%%%%%%%                   ,%%%%%.                      
                   %%%%%%%%%%#                     .%%%%%                      
                  #%%%%%%%%%(                       .%%%%/                     
                  %%%%%%%%%%                         .#%%%                     
                 /%%%%%%%%%*                          ,#%%(                    
                 %%%%%%%%%%                            ,%%%                    
                 %%%%%%%%%                              ,%%                    
                 %%%%%%%%./.   //   ,,                   ,%,      /  *         
                 (%%%%%/  ((#,#//#,#//                           */(/          
                 .(%%#*   ///#(//##//,                           *///          
               ...  .      (/////#///                            *//           
             ,.....        ((///////*                            //,           
              .,...  ,     #(///////                        .   .//            
             ....,,,,,,,  /##(/////.                ..    ..///////            
          .,,****//*,,,,,,,,#(/////...................,,.,*/////*/*,,..        
          ..,,,*******////////((/(////////////////////////*******,,,..         
                   ..........................................               "
