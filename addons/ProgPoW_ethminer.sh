whiptail --msgbox 'Replacing ethminer-v0.15.0 with the Bitcoin Interest fork of ethminer-v0.15.0 that supports the ProgPoW algorithm.' --backtitle 'ProgPow' --title 'Replacing ethminer-v0.15.0' 15 55
clear
wget https://www.bitcoininterest.io/downloads/bci_progpow_linux.zip
unzip bci_progpow_linux.zip
sudo rm -rf /root/miner_org/ethminer-v0.15.0
sudo mv progpow_linux /root/miner_org/ethminer-v0.15.0
chmod +x /root/miner_org/ethminer-v0.15.0/*
rm bci_progpow_linux.zip
cd /root/miner_org/ethminer-v0.15.0
ln -s progpowminer_9.1 ethminer
cd
whiptail --msgbox 'Go to http://simplemining.net and setup a new rig group for ethminer-v0.15.0 that 
now supports ProgPoW.' --backtitle 'ProgPow' --title 'ProgPoW' 15
55
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
