package josx.rcxcomm;

/**
 * A Packet handler that implements the outer LNP packet format.
 * It uses the Tower call to send and receive LNP packets.
 **/
public class LNPHandler extends PacketHandler {

  private byte op;
  private boolean gotPacket = false;
  private byte [] inPacket = new byte [259];
  private int inPacketLength;

  public LNPHandler() {
    LLC.init();
  }

  /** Send a packet.
   * @param packet the bytes to send
   * @param len the number of bytes to send
   * @return true if the send was successful, else false
   */
  public boolean sendPacket(byte [] packet, int len) {
    synchronized (this) {
      return LLC.sendBytes(packet, len);
    }
  }  

  /** Receive a packet.
   * @param buffer the buffer to receive the packet into
   * @return the number of bytes received
   */
  public int receivePacket(byte [] buffer) {
    gotPacket = false;
    for(int i=0;i<inPacketLength;i++) buffer[i] = inPacket[i];
    return inPacketLength;
  }

  /**
   * Search for the next paket or ack and read it into the relevent buffer
   * an set the flag to say we've got it. Implements the keep-alive sends.
   **/
  private void getOp() {
    while (true) {
      int r = LLC.read();
      if (r < 0) return;
      op = (byte) r;
      if (op == (byte) 0xf0 || op == (byte) 0xf1) {
        gotPacket = true;
        inPacket[0] = op;
        inPacket[1] = (byte) LLC.receive();
        int extra = inPacket[1] + 1; // Add 1 for the checksum
        for(int i=0;i<extra;i++) inPacket[i+2] = (byte) LLC.receive();
        inPacketLength = extra+2;
        return;
      }
    }
  }

  /**
   * Check if a packet is available
   * @return true if a Packet is available, else false
   */
  public boolean isPacketAvailable() {
    synchronized (this) {
      if (gotPacket) return true;
      getOp();
      return gotPacket;
    }
  }
}
