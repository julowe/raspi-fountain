# Raspberry Pi Fountain Style Case
Case for Raspberry Pi/RetroPi in shape of a fountain basin.

This repo contains an OpenSCAD file for basin (with base), including friction fit posts for statues and raspi.

And two models (the statues), of gargoyles and a central column. Remember to scale up the central column...

## Printing

Printed at 0.12mm layer height mostly on Ender 3 with Marble PLA, to fair success.

Just did lazy way of creating 5.2mm cube voids in bottom of gargoyle and column models so they would fit on friction fit posts on basin. In hindsight, just using the 5mm diameter heatset inserts and having holes in the basin top (vs somewhat fragile posts) would probably have been better

## Assembly
All heatset insert void were made for 5mm diameter m3 versions. Along with holes and screw-head insets on bottom of base. Roughly need:

3 M3 12mm for base
1 M3 16mm? for base (or you know, fix the basin model so you don't have to hack away plastic to get power cord to fit)
1 M3 5mm for pi corner retainer (ideally would be a M2.5 and associated heatset insert, but lacking them and the will, I filed the mounting hole on the pi larger)
4 M3 12mm for fan

Pi currently oriented with power and hdmi cables coming out smaller hole, USB cables coming out of larger hole.

Fan red wire attached to 3V (vs 5V) for quieter running. Pins bent out and labeled on base, but look up RasPi pinout for 3V and ground to see where to attach.
