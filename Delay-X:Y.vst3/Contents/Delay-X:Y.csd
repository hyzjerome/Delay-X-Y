<Cabbage> bounds(0, 0, 0, 0)
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1") colour(255, 255, 255)
rslider bounds(298, 150, 100, 100), channel("gain"), range(0, 1, 0, 1, 0.01), text("Gain"), trackerColour(0, 0, 255, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
;rslider bounds(134, 8, 60, 60) channel("Depth") range(0, 100, 0, 1, 0.001), text("Depth")
;rslider bounds(238, 12, 60, 60) channel("Rate") range(0, 10, 0, 1, 0.001), text("Rate")
groupbox bounds(14, 10, 284, 271) channel("groupbox10002") colour(202, 219, 255, 255) fontColour(0, 120, 144, 255) outlineColour(255, 156, 26, 255) text("Delay Pad")
xypad bounds(56, 50, 200, 200) channel("xDepth", "yRate") ballColour(0, 140, 255, 255) rangeX(0, 100, 0) rangeY(0, 10, 0)
rslider bounds(320, 54, 60, 60) channel("Reverb") range(0, 1, 0, 0.5, 0.001), text("Reverb") textColour(0, 0, 0, 255) trackerColour(0, 0, 255, 255)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

garvbL init 0
garvbR init 0

instr 1
kGain cabbageGetValue "gain"

a1 inch 1
a2 inch 2

kDepth chnget "xDepth"
kRate chnget "yRate"
alfo lfo kDepth, kRate
adelay vdelay (a1+a2)/2, alfo+40, 1000

krvb chnget "Reverb"

outs (a1+adelay)*kGain, (a2+adelay)*kGain

vincr garvbL, (a1+adelay)*kGain*krvb
vincr garvbR, (a2+adelay)*kGain*krvb
endin

instr verb
	denorm garvbL, garvbR
aL, aR freeverb garvbL, garvbR, 0.9, 0.4, sr, 0
	outs aL, aR
	clear garvbL, garvbR
	endin 
	
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
i "verb" 0 600000
</CsScore>
</CsoundSynthesizer>
