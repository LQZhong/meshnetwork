import os 
import pandas as pd


# run shell command
def run_shell_command(command):
    os.system(command)



if __name__ == '__main__':

    # first we need to parse the data from pcap to csv with tshark

    # filename as user input
    filename = input('Enter the filename: ')

    parsing_command = f'tshark -r {filename}.pcap -Tfields -E separator=, -e frame.time -e ip.src -e ip.dst -e udp.port -e frame.len > {filename}.csv'

    run_shell_command(parsing_command)

    # Now the data should be available as a csv


    df = pd.read_csv(f'{filename}.csv')
    df = df.drop(columns = df.columns[0])
    df.columns = ['timestamp', 'src_ip', 'dst_ip', 'src_port', 'dst_port', 'length']
    df['timestamp'] = pd.to_datetime(df['timestamp'])
    df = df.set_index('timestamp')

    df.to_csv(f'{filename}.csv')

    

