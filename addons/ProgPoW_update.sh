whiptail --msgbox 'Replacing progpowminer-v0.15.0-dev0-cuda9.1 with the Bitcoin Interest fork of ethminer-v0.15.0 
that supports the ProgPoW algorithm.' --backtitle 'ProgPow' --title 'Replacing progpowminer-v0.15.0-dev0-cuda9.1' 15 55
clear
wget -O bci_progpow_linux_v16rc1.zip "https://www.dropbox.com/s/ovp7o6qie8x7b9z/bci_progpow_linux_v16rc1.zip?dl=1"
unzip bci_progpow_linux_v16rc1.zip
sudo rm -rf /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
sudo mv bci_progpow_linux  /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
chmod +x /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1/*
rm bci_progpow_linux.zip
cd /root/miner_org/progpowminer-v0.15.0-dev0-cuda9.1
ln -s progpowminer_cuda9.2_v16rc1 progpowminer
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
