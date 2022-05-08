import os 
import pandas as pd




if __name__ == '__main__':

    # First we need to parse the data from pcap to csv with tshark

    # Filename as user input
    filename = input('Enter the filename: ')

    parsing_command = f'tshark -r {filename}.pcap -Tfields -E separator=, -e frame.time -e ip.src -e ip.dst -e udp.srcport -e udp.dstport -e udp.length > {filename}.csv' #  The parser is just ooptimized for UDP sofar
    os.system(parsing_command)

    # Now the data should be available as a csv

    # To do some adjustments for better readability we use panda to transform the csv file into a dataframe 
    df = pd.read_csv(f'{filename}.csv')
    df = df.drop(columns = df.columns[0]) # first column is unnecessary

    df.columns = ['timestamp', 'src_ip', 'dst_ip', 'src_port_udp', 'dst_port_udp', 'udp_length'] # The parser is just ooptimized for UDP sofar
    df['timestamp'] = pd.to_datetime(df['timestamp'])
    df = df.set_index('timestamp')

    df.to_csv(f'{filename}.csv')

    

