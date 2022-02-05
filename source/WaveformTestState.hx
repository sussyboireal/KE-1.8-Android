package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxStrip;
import flixel.util.FlxColor;
import haxe.io.Bytes;
import lime.media.AudioBuffer;
import lime.media.vorbis.VorbisFile;
import openfl.geom.Rectangle;
import openfl.media.Sound;

class WaveformTestState extends MusicBeatState
{
	var waveform:Waveform;

	override public function create()
	{
		super.create();

		// fuckin stupid ass bitch ass fucking waveform
		if (PlayState.isSM)
		{
			#if (FEATURE_FILESYSTEM && FEATURE_STEPMANIA)
			waveform = new Waveform(0, 0, PlayState.pathToSm + "/" + PlayState.sm.header.MUSIC, 720);
			#end
		}
		else
		{
			if (PlayState.SONG.needsVoices)
				waveform = new Waveform(0, 0, Paths.voices(PlayState.SONG.songId), 720);
			else
				waveform = new Waveform(0, 0, Paths.inst(PlayState.SONG.songId), 720);
		}
		waveform.drawWaveform();
		add(waveform);

                addVirtualPad(FULL, NONE);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP)
			FlxG.camera.y += 1;
		if (controls.DOWN)
			FlxG.camera.y -= 1;
		if (controls.LEFT)
			FlxG.camera.x += 1;
		if (controls.RIGHT)
			FlxG.camera.x -= 1;
	}
}