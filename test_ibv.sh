IBV_CMD=ib_send_bw
msg="#bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]"
# msg="#bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec]"

log=$IBV_CMD\_MSG_SIZE.txt
echo $msg>$log
for((msg_size=1;msg_size<=2<<14;msg_size=msg_size*2));
do
    echo $msg_size
    $IBV_CMD -n 10000000 -q 1 -s $msg_size | tail -2 >>$log  &
    sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -q 1 -s  $msg_size "> /dev/null
    # $IBV_CMD -n 10000000 -s $msg_size | tail -2 >>$log  &
    # sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -s  $msg_size "> /dev/null
done

# log=$IBV_CMD\_QP_PAIRS.txt
# echo $msg>$log
# for msg_size in 64 256
# do
#     for((qp_pairs=1;qp_pairs<=32;qp_pairs++));
#     do 
#         echo "qp_pairs" $qp_pairs
#         echo "qp_pairs" $qp_pairs>>$log
#         $IBV_CMD -n 10000000 -q $qp_pairs -s $msg_size | tail -2>>$log  &
#         sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -q $qp_pairs -s  $msg_size "> /dev/null
#     done
# done

# log=$IBV_CMD\_RECV_LIST.txt
# echo $msg>$log
# for msg_size in 64 256
# do
#     echo $msg_size
#     for((recv_list_size=1;recv_list_size<=1024;recv_list_size*=2));
#     do 
#         echo "recv_list_size" $recv_list_size
#         echo "recv_list_size" $recv_list_size>>$log
#         $IBV_CMD -n 10000000 -q 1 -s $msg_size -t $recv_list_size | tail -2 >>$log  &
#         sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -q 1 -s $msg_size -t $recv_list_size "> /dev/null
#         # $IBV_CMD -n 10000000 -s $msg_size -t $recv_list_size | tail -2 >>$log  &
#         # sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -s $msg_size -t $recv_list_size "> /dev/null
#     done
# done


# log=$IBV_CMD\_POST_LIST.txt
# echo $msg>$log
# for msg_size in 64 256
# do
#     echo $msg_size
#     for((post_list=1;post_list<=100;post_list++));
#     do 
#         echo "post_list" $post_list
#         echo "post_list" $post_list>>$log
#         $IBV_CMD -n 10000000 -q 1 -s $msg_size -I $post_list | tail -2 >>$log  &
#         sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -q 1 -s $msg_size -I $post_list "> /dev/null
#         # $IBV_CMD -n 10000000 -s $msg_size -I $post_list | tail -2 >>$log  &
#         # sshpass -p 'mxh'  ssh mxh@192.168.1.22 "$IBV_CMD 192.168.1.11 -n 10000000 -s $msg_size -I $post_list "> /dev/null
#     done
# done