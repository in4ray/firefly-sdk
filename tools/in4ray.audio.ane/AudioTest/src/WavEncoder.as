package
{
	import flash.utils.*;
	
	/**
	 * Very simple static .wav encoder class
	 * Encoding .wav files is not particularly difficult but there are some details you should know before using this class for other projects
	 * 
	 * Guide to .wav format:
	 * https://ccrma.stanford.edu/courses/422/projects/WaveFormat/
	 */
	public class WavEncoder
	{	
		public static function encode( samples:ByteArray ):ByteArray
		{
			var position:int = samples.position;
			samples.position = 0;
			
			var input:ByteArray = new ByteArray();
			input.endian = Endian.LITTLE_ENDIAN;
			
			while( samples.bytesAvailable ) {
				input.writeShort( samples.readFloat() * 0x7fff );
			}
			
			var output:ByteArray = new ByteArray();
			output.length = 0;
			output.endian = Endian.LITTLE_ENDIAN;
			output.writeUTFBytes( "RIFF" );
			output.writeInt( uint( input.length + 44 ) );
			output.writeUTFBytes( "WAVE" );
			output.writeUTFBytes( "fmt " );
			output.writeInt( uint( 16 ) );
			output.writeShort( uint( 1 ) );
			output.writeShort( 2 );
			output.writeInt( 44100 );
			output.writeInt( uint( 44100 * 2 * ( 16 >> 3 ) ) );
			output.writeShort( uint( 2 * ( 16 >> 3 ) ) );
			output.writeShort( 16 );
			output.writeUTFBytes( "data" );
			output.writeInt( input.length );
			output.writeBytes( input );
			
			return output;
		}
	}
}