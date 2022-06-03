IBV_CMD=ib_send_bw

msg="#bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]"
# msg="#bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec]"

#host send to local-dpu
log=$IBV_CMD\_MSG_SIZE.txt
echo "host send to local-dpu">$log
echo $msg>>$log
for((msg_size=1;msg_size<=2<<14;msg_size=msg_size*2));
do
    echo $msg_size
   killall $IBV_CMD ssh
   sshpass -p 'mxh'  ssh mxh@192.168.2.89 "killall $IBV_CMD ssh"
    $IBV_CMD -x 1 -n 10000000 -q 1  -s $msg_size | tail -2 >>$log  &
    sshpass -p 'mxh'  ssh mxh@192.168.2.89 "$IBV_CMD 192.168.1.89 -n 10000000 -x 1 -q 1 -s  $msg_size "> /dev/null
done

#host send to remote-dpu
echo "host send to remote-dpu">>$log
echo $msg>>$log
for((msg_size=1;msg_size<=2<<14;msg_size=msg_size*2));
do
    echo $msg_size
   killall $IBV_CMD ssh
   sshpass -p 'mxh'  ssh mxh@192.168.2.89 "killall $IBV_CMD ssh"
    $IBV_CMD  -n 10000000 -q 1 -x 1 -s $msg_size | tail -2 >>$log  &
    sshpass -p 'mxh'  ssh mxh@192.168.2.88 "$IBV_CMD 192.168.1.89 -n 10000000 -x 1 -q 1 -s  $msg_size "> /dev/null 
done

# Notes:It fails to run sshpass ssh "ib_xxx" in dpu first and then to run ib_xxx ip in host
#local-dpu send to host
# log=$IBV_CMD\_MSG_SIZE.txt
# echo "local-dpu send to host">$log
# echo $msg>>$log
# for((msg_size=1;msg_size<=2<<14;msg_size=msg_size*2));
# do
#     killall $IBV_CMD
#     sshpass -p 'mxh' ssh mxh@192.168.2.89 "killall $IBV_CMD"
#     echo $msg_size
#     $IBV_CMD 192.168.2.89 -x 1 -n 10000000 -q 1  -s $msg_size | tail -2 >>$log  &
#     sshpass -p 'mxh'  ssh mxh@192.168.2.89 "$IBV_CMD -n 10000000 -x 1 -q 1 -s  $msg_size "> /dev/null 
# done


# #remote-dpu send to host
# log=$IBV_CMD\_MSG_SIZE.txt
# echo "remote-dpu send to host">$log
# echo $msg>>$log
# for((msg_size=1;msg_size<=2<<14;msg_size=msg_size*2));
# do
#     killall $IBV_CMD
#     sshpass -p 'mxh'  ssh mxh@192.168.2.88 "killall $IBV_CMD"
#     echo $msg_size
#     sshpass -p 'mxh'  ssh mxh@192.168.2.88 "$IBV_CMD -n 10000000 -x 1 -q 1 -s  $msg_size "> /dev/null &
#     $IBV_CMD 192.168.2.88 -x 1 -n 10000000 -q 1  -s $msg_size | tail -2 >>$log  
# done