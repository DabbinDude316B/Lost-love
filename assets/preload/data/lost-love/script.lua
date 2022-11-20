local angleshit = 1;
local anglevar = 1;
local allowCountdown = false;

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'nothing');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

function onEndSong()
	if  misses < 5 then
		setProperty('inCutscene', true);
		startDialogue('dialogue2', 'nothing');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onBeatHit()
    if curBeat > 15 then
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle',angleshit*3)
        setProperty('camGame.angle',angleshit*3)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
        doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	setProperty('dad.alpha', 100)
	setProperty('iconP2.alpha', 100)
	triggerEvent('Alt Idle Animation', 1, '-alt')
	end
end

function onCreate()
	setProperty('gf.alpha', 0)
	setProperty('dad.alpha', 0)
	setProperty('iconP2.alpha', 0)

	return Function_Continue
end

function onEndSong()
	if isStoryMode and misses > 10 then
		setProperty('inCutscene', true);
		startDialogue('dialogue2', 'nothing');
		return Function_Stop;
	end
	return Function_Continue;
end

function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length') do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'FADENOTE_assets');
			else
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'GlitchNotes');
			end
		end
	end
end