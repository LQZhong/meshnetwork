import pandas as pd

def get_iperf_data(df):
    
    """_summary_

    Args:
        df (pd.DataFrame): iperf log as csv

    Returns:
        pandas Dataframe with timestamp as datetime format, and all iperf information
    
    
    """
    
    df.columns = ['timestamp', 'source', 'src_port_udp', 'destination', 'dst_port_udp', 'a','intervall', 'data','datarate']
    df.timestamp = pd.to_datetime(df.timestamp, exact=False, format= '%Y%m%d%H%M%S')
    df = df.drop(columns=['a','intervall'])
    
    return df

def get_pcap_udp_data(df):
    
    """_summary_

    Args:
        df (pd.DataFrame): UDP data from pcap file, prefiltered for udp only with wireshark

    Returns:
        pandas Dataframe with timestamp as datetime format, packet length as int, source and destination ip as string, source and destination port as int
    
    """
    
    df.Time = pd.to_datetime(df.Time) # Change Time col to date time timestamp format
    df = df.rename(columns={'Time': 'timestamp'}) 
    
    info = pd.DataFrame(df.Info.str.split(' ',1).tolist(), columns = ['src_port_udp','rest']) # Grep UDP src port from Info column
    
    df['src_port_udp'] = info.src_port_udp
    
    info = pd.DataFrame(info.rest.str.split(' > ',1).tolist(), columns = ['>','rest'])[['rest']] # Cut > from Info column
    
    df['dst_port_udp'] = pd.DataFrame(info.rest.str.split(' Len=',1).tolist(), columns = ['dst_port_udp','len']).dst_port_udp # Grep UDP dst port from Info column
    df['len'] = pd.DataFrame(info.rest.str.split(' Len=',1).tolist(), columns = ['dst_port_udp','len']).len # Grep UDP len from Info column
    df = df.drop(columns=['Info'])
    return df

def get_ping_data(df):
    """
    _summary_

        Args:
            df (pandas DataFrame): ping log data ( csv)
        Returns:
            cleaned DataFrme
        
    _description_
            This functions renamed the ping data columns and delete unnecessary columns
    """
    
    df.columns = [['timestamp', 'idx', 'domain', 'delay']]
    df = df.drop(columns=['domain', 'idx'])
    
    return df
    