




KERNEL=4.1.10.AtomoLinuxFSCACHE && \
cd nvidia && \
make clean && \
make  KERNEL_UNAME=$KERNEL SYSSRC=/lib/modules/$KERNEL/source/ module -j 32 && \
echo

#sudo make  KERNEL_UNAME=$KERNEL SYSSRC=/lib/modules/$KERNEL/source/ install -j 32 
