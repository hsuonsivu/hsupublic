# Various open source physical objects by Heikki Suonsivu

These are licensed, unless otherwise stated in program files or included license text,
under [Creative Commons CC-BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

I mostly use OpenSCAD for modeling, it will export STL. As I use
hull() a lot, these might be difficult to import to other cad
programs. Some of the models are really slow in OpenSCAD, so use F6
(or whatever in your computer) to render before changing viewing
angle. Make sure you have manifold as backend (Advanced options). Many
models also need textmetrics (Features/textmetrics) and other libraries. Later models are
usually rotated for printing.

Please return improvements to me to be included in the
main distribution.

I usually try to avoid needing supports by making angles less than 50
degrees or overhangs small enough, so unless otherwise stated, you can
print without supports,if the object is rotated correctly in the slicer.

### canon-tripod-1-top.scad

I had old Canon tripod-1, and its rubbery top part disintegrated with
age. This is a replacement. Print with TPU.

![Image of the tripod 1 with new top](canon-tripod-1-top.jpg)
![Model in openscad showing underside](canon-tripod-1-top.png)

### coasterholder3.scad

If you have a dead 5.25inch hard drive, you can recycle the disk
platters inside to make nice coasters for you bar. This is a holder
for coasters from a 8 platter Maxtor hard disk. Other hard disks might
need some adapting. See also "suklaarasiankansi.scad".

![Image of the costerholder](coasterholder.jpg)
![Second image of the costerholder](coasterholder2.jpg)

### disk525to35.scad

This is an adapter to put 3.5 inch disk drive to a 5.25 drive slot. It
is designed to not to need screws, however, with certain cases that
might not work well due to funky mechanisms to lock things in
place. Maybe fixed in a future versions to allow screws to be used for
outside attachments.

printing time on Tronxy X5SA/Pro 400 or Anycubic Chiron takes about 18
hours, and uses about 200g of filament. No supports are needed, rotate
so that locking sticks are on the bed, and on moving bed printers bed
moves in direction of locking sticks to avoid falling over.

To save filament and printing time, default is to make the thing with
various cutouts.

Locking mechanism uses locking sticks, when pushed in, they push
knobs/keys into drive/case screw holes. For outer screw holes, you can
put the stick in upper or lower position, as computer cases might
have different screw positions.

If you enable simple version, there is no locking
mechanism, and the adapter only locks with springs. This does not
keep things in place very well.

Full height 3.5 inch drives will not fit as they are same height as
5.25 slot. Those are very rare anyway. Maybe this could be adapted by
removing top and bottom from disk position.

This makes openscad very slow, so render (F6) first before rotating or
zooming.

See options in the file.

![Image of the 3.5 inch drive adapter for 5.25 inch slot](disk525to35.jpg)
![Image of the 3.5 inch drive adapter for 5.25 inch slot with a disk installed](disk525to35-2.jpg)
![Model in openscad, rotate to this position for printing](disk525to35.png)

### hammasharjateline.scad

Organizer for various things in the bathroom. Very specific, so not
very usable unless you use exactly same electric toothbrush and shaver
as me. This can be screwed into a wall.

![Model in openscad](hammasharjateline.png)

### license.scad

The default license file.

### lidllaturiteline.scad

### Makefile.lidllaturiteline

Lidl sells wireless phone charger for two phones. It is not very
practical as the mobile phones need to be placed accurately to the
correct position. This holder allows simply dropping the two phones to
the slots, and they will start charging. The desktop version has angle
of 45 degrees which seems convenient, Tesla Model S version has lower
angle to allow better view of the phone screen.

The latest version has adjustable phone height to accommodate phones
with different positions of induction loop.

There is option to make desktop version for single phone using
different wireless charging pad.

The model generates large support underneath if the angle is less than
45 degrees, so printing with lightning fill is recommend to reduce
filament consumption.

Makefile makes both desktop and Tesla Model S versions.

To make a holder for Tesla Model S, change teslamodels to 1, otherwise
desktop version is made. Difference is different base and lower angle
for a Tesla and raise to allow holder to stay in place between trim in
the centre console. Tesla Model S needs narrow legs. For tesla model S
you need 4 3.5mm 19mm(wood) screws to attach the lower parts of the legs.

![Image of charger base for Lidl dual wireless phone charger](lidllaturiteline.jpg)
![Image of charger base for Lidl dual wireless phone charger, Tesla version](lidllaturiteline-tesla.jpg)
![Second image of charger base for Lidl dual wireless phone charger](lidllaturiteline2.jpg)

### kasvikyltit.scad

Bunch of veggie labels for your garden. You can modify the names at
the start of the file. End the list of labels with "". You can have
several labels printed in one go, but you must put names in order of
longest text to shortest text, I was too lazy to fix the related
bug. It will do 2 labels for each name so you can put a label at both
ends of the row.

I have printed these with light colour at bottom and top, and black in
the middle layers to make text more visible.

This uses recursion as I could not easily figure out how to do loops
which change variables.

We had problems with birds picking up yellow labels and throwing them
around. I have no idea what they were thinking, but yellow might not
be the right color choice. Next summer we will try red and make labels
larger. Update: Added structures to keep them better in the
ground. The birds left those in place, but sample is too small to make
any definitive conclusions.

![Veggie Labels in openscad](kasvikyltit-openscad.png)
![Veggie Labels](kasvikyltit.jpg)

### nimikyltit.scad

### Makefile.nimikyltit

Bunch of name labels. These we designed to be put on top of
rack for towels. You can modify the names at the start of the
file. End the list of names with "". You can
have several labels printed in one go. You also need to configure the
size of your printer print area, as it will arrange labels automatically.

Additionally, you can print a holder for name labels to hang to a
wall. This needs to be printed on its side, and it is very narrow
print, so for bedslingers, you need to position the print to direction
of the bed movement and use brim.

I have printed the labels with black at the bottom and lighter color on top
to make text more visible.

The design expects a small gap between wall and rack. We installed
washers behind the rack to add a bit of gap.

This uses recursion as I could not easily figure out how to do loops
which change variables.

![Image of the name label](nimikyltit.jpg)
![Name labels in openscad](nimikyltit-openscad.png)
![Image of the label holder](nimikylttiteline.jpg)
![Label holder in openscad.](nimikylttiteline.png)

### lundiacarrier.scad

Carrying multiple lundia shelf plates is difficult as they tend to
slide over each other. So I made a handle. You need to add two locking
straps ([such
as](https://www.tokmanni.fi/kiinnityshihna-pikalukko-25-mm-2-5-m-2-kpl-6419860608952)). This
is likely useful to carry other stuff as well.

![Image of the lundia shelf carrier handle with straps](lundiacarrier.jpg)

### mittatesti.scad

Calibration tool to measure x,y and z axis. Some printers such as my
Tronxy need x/y axis movements to be calibrated. You can tune Number
of cubes and whether filament- and time-saving holes are printed.
For filaments which tend to warp and deform, this does not work very
well. Use PLA.

![Image of the the clibration tool for 3d printers](mittatesti.jpg)
![20cm model in openscad](mittatesti-20cm.png)

### paperiteline.scad

### Makefile.paperiteline

Holder for paper towel rolls. Left and right parts can be printed at
the same time if your printer is large enough. Left and right parts
are locked together with a stick you push through on the right
side. Then replacing a roll, you can insert the stick to a temporary
hole left of the locking hole.

When pulling out a paper, pull a whole sheet and then quickly rip it
off.

![Image of the paper roll holder installed](paperiteline.jpg)

### plantsupport.scad

One of our office plants was about to collapse and needed
support. This is very specific to size of planter and plant.

![Image of the support for a plant](plantsupport.jpg)

### presshandle.scad

I built a press for large engineering drawings to iron them
out. Basically it is a table with another table plate on top with
hinges. This is a handle for it. Might be useful for some other
application as well.

![Image of the handle as installed](presshandle.jpg)

### sinisentuolinjalka.scad

One of the chairs in our office was missing a plug in one of its
feet. This is a replacement. Print with TPU with 100% fill. The chair
does not have any label in it so I do not know what brand or type it
is.

![Chair foot plug in openscad](sinisentuolinjalka.png)
![Photo of the chair fitted with printed foot](sinisentuolinjalka.jpg)

### suklaarasiankansi.scad

You can turn your dead 5.25 inch hard disk into a stylish chocolate
box. This is for Maxtor 8 platter drive. Unfortunately, this model
does not work with any other disk model, so you need to find a dead
Maxtor IT-1140 drive. The screws are positioned so that the existing
holes can be used. The screws I used were random picks from my junk
box. There may be some size problems with this one as the printer I
used had calibration problems with x and y axis. Do a test print and
adjust.

![Image of the chocolate box](suklaarasiankansi.jpg)

### termostaatin-piuhapidike.scad

I needed a holder for smart zigbee thermostat cables for programming
in batch, so a small holder was needed. Not really useful for anything
else.

### vasara.scad

(Project stalled) Thought I needed electric hammer, so started
designing one but found a commercially available product so this project
stalled very early. Maybe some day...

![Model in openscad, normal](vasara.png)

### sipulinistutin.scad

I needed to plant some seeds and onions, and wanted a tool for the job
to avoid stressing my back. This attaches to 25mm diameter metal
tube. When planting stuff, drop seeds from top of the tube while
pulling the sharp edge to open a narrow dig so that the seeds drop to
bottom of it. You need to maintain constant speed and drop seeds at
steady intervals. Or just keep pouring them while pulling
quickly. After planting a row, turn the tool 90 degrees and cover the
dig. Some of the onions turned out to be too large for 25mm tobe, so a
larger version would be needed for larger tubes. However, it worked
with other seeds fine. No supports are needed to print.

![Model in openscad, normal](sipulinistutin.png)
![Plant seeder installed to a 25mm tube](sipulinistutin.jpg)

### kynnyskulma.scad

If you need to roll heavy wheeled items over a doorstep, this
threshold ramp will help a bit. The model will split the part to
multiple parts which attach to each other, so you need to configure
your printer width. For small printers, you can print the parts in
vertical configuration, but they are more difficult to attach to each
other. For heavy items, you might want to up infill % from
defaults. You can do a small test print to test attachments. No supports are needed to print.

![Model in openscad, normal](kynnyskulma-normal-openscad.png)
![Model in openscad, vertical](kynnyskulma-vertical-openscad.png)
![Threshold ramp in use to help getting a heavy barbeque over the door threshold](kynnyskulma.jpg)

### masklock.scad

A CPAP mask lock replacement. Needs supports, works best with tree
supports.

![Model in openscad](masklock.png)

### batterybarcover.scad

Covers li-ion between battery connector bars. Small openings can be
snapped off to provide holes for BMS cables. Supports two types of
battery bars. No supports are needed to print.

![3 battery bar covers in openscad](batterybarcover.png)
![Photo of battery bar covers installed in a battery pack](batterybarcoverphoto.jpg)

### batteryterminalcover.scad

Covers li-ion battery pack terminals. Small openings can be snapped
off to provide holes for BMS cables. Use a small cable binder to
lock. No supports are needed to print.

![battery terminal cover in openscad](batteryterminalcover.png)
![Photo of battery terminal cover installed in a battery pack](batteryterminalcover.jpg)
![Another picture of the terminal cover installed in a battery pack](batteryterminalcover-2.jpg)

### bedcontrollerpart.scad

A plastic part of my bed controller broke, here is a new one. The bed
brand is Tempur and the motor bed seems to be from Germany. No supports are
needed to print.

![Bed controller spare part openscad](bedcontrollerpart.png)
![Bed controller spare part in use](bedcontrollerpart.jpg)

### doublebedholder.scad

Keeps two normal beds together for double occupancy. Limited
tunability for different beds, distance between feet and feet
diameter/square edge. No supports needed to print.

![Double bed holder in openscad](doublebedholder.png)
![Double bed holder in use](doublebedholder.jpg)

### rakki-kiinnike.scad

Spare part for rack-mount power strip. Modded original from Tero Kivinen. Can be printed with no supports when vertical, but likely needs a brim. 

![rakki-kiinnike in openscad](rakki-kiinnike.png)
![This is the part this will replace. Original in picture.](rakki-kiinnike.jpg)


### tunturi460wheel.scad

Spare part for Tunturi E460 exercise bike. The original back wheels
intended for easier moving the bike around disintegrate with
time. This is a replacement. I printed these with TPU and 100%
fill. Maybe overkill, less fill might work. When printing with TPU,
you likely need supports option, otherwise TPU may not stick to the
bed. PLA prints without this option, and the part looks more like
original, but that is not really visible as long as you install them
with support side towards the center.

![Part installed and the disintegrated original.](tunturi460wheel.jpg)

### isonappi.scad

Lost a button of my Ernst Brendler overcoat. This is a copy. Crude,
but close enough. For easier printing, is has support option,
otherwise it will need supports enabled in the slicer.

![Button installed to the overcoat.](isonappi.jpg)

### mask.scad

Party mask. Fragile and not very flexible.  Copied idea from someone
else, but implemented this myself.  Todo: attachments to glasses,
improved flexibility.

![Party mask in scad.](mask.png)

### roboteeth.scad
### Makefile.roboteeth

During halloween you must beware of aggressive robots! This is a set
of teeth and face for UR UR5e cobot with Robotiq Adaptive
Gripper. Needs screws to attach head. The teeth clip into
gripper. Tune down the gripping force to avoid too painful bites.

Use Makefile.roboteeth to generate all needed parts with openscad. No
supports needed.

![Robot with bite](roboteeth.png)

### powerknob.scad

Our office was missing a knob in electrical cabinet. This is a
spare. More modern style though, but works. No supports needed.

![Power knob in scad.](powerknob.png)
![Power knob installed.](powerknob.jpg)

### blanketcontrollerholder.scad

I have an electric heated blanket for cold winter nights. This is a
holder for the controller. Heated blanket is [Nedis from
Tokmanni](https://www.tokmanni.fi/lampopeitto-nedis-180-x-200-cm-5412810334773). Only
works if the bed is next to a wall. Likely fits with other brands of
blankets as well. The model is in 4 parts to allow printing in a small
printer such as ankermake 5C. For some printers with low accuracy, you
might need to increase tolerance to make attachments work. For me,
Ankermake worked, but Anycubic print needed filing. No supports needed.

![blanketcontrollerholder in scad.](blanketcontrollerholderwhole.png)
![blanketcontrollerholder in scad (print=2).](blanketcontrollerholder2.png)
![blanketcontrollerholder in scad (print=3).](blanketcontrollerholder3.png)
![blanketcontrollerholder in use.](blanketcontrollerholder.jpg)

### tunturie460holder.scad

### Makefile.tunturie460holder

Tablet stand for Tunturi E460 exercise bike to allow browsing the
Internet while exercising. Tablet dimensions taken from an old
iPad. Needs 5 20mm 3.5mm screws (countersink). Use
Makefile.tunturie460holder to generate all needed parts with
openscad. One of the parts is for testing screw if you want to change
screw type, no other use. Top clip should be printed with flexible
material, such as TPU. The angle of the pad is tunable, though this
has not been fully tested for large angles.

If "strong" option is enabled, the model will trick slicer to generate
100% fill around the screwholes, making them stronger. This is useful
if you slice with lightning fill. What it does is generate very thin
concentric voids around the screw holes. Notice that "strong" option
will make the model very slow to process in openscad, and you need to
check that your print settings have "Hole Horizontal Expasion" set to
0.0, otherwise the slicer will expand the voids and reverse the effect
by making the print weaker.

No supports are needed.

![tunturie460holder in scad.](tunturie460holder.png)
![tunturie460holder installed for use.](tunturie460holder1.jpg)
![tunturie460holder installed for use from back.](tunturie460holder2.jpg)
![tunturie460holder screw sample.](tunturie460holder-screw.jpg)

### measurementcardcover.scad

A case for Clausal Computing Oy's data acquisition board designed to be
installed in Famatel electrical box. Has openings for most
connectors. Needs one 3.5mm 20mm screw for closing, other edge is closed with clips.

Use print=1 for print model. No supports are needed.

![The case in scad.](measurementcardcover.png)
![The case installed in electrical box.](measurementcardcover.jpg)

### kaapelipidikkeet.scad

Holder and base for electrical bus bars for Famatel electrical
box. Supports two bus bars, each for 12 cables. The bus bars clip to
the holder and stay in place, but you can secure them with 4mm
countersink 30mm screws for added strength. Allows all electrical box
opening cuts to be used. The bus bars used are intended for DIN rail
installation, but this holder does not use DIN format, instead it fits
the screw base. This may not be of any sort of standard, but neither
is the T supports in the electrical box for which this is designed for.

Use print=1 for print model. No supports are needed.

![Cable holder in scad.](kaapelipidikkeet.png)
![Cable holder installed.](kaapelipidikkeet.jpg)

### lampcork.scad

I have a old design table lamp which had its top loose from the
base. The base is made of glass and upper part made of copper got
loose, and the the upper is screwed through a cork stopper within top
of the glass. The cork self-destructed when we tried to extract it for
fix, so I designed a replacement for the cork part. It needs to be
printed with TPU to get a snug fit for the glass part. The design may
need some improvement, as it is a bit too loose, but that is mostly
the shape and diameter fix. I printed with 50% fill, however, slightly
less dense fill and small increase in diameter might make it better
fit. Transparent TPU95 worked.

The table lamp was designed by Lisa Johansson-Pape, and was
manufactured by Orno, when it was owned by Stockmann. The lampshade
was restored by Varjostinnurkka in Helsinki.

The original screw fits into the slot in the part, so this replaces
the cork, otherwise it is as original.

The model also includes top screw for the lampshade, as I managed to
loose the original in the process. You need a suitable short
countersink screw to insert in the printed top part, use soldering
iron to make it fit snugly, then use suitable glue to fix the cover in
place.

print=1 prints the cork replacement, and print=4 prints the lampshade
screw parts. No supports are needed for printing.

![Cork replacement in scad.](lampcork.png)
![The lamp after fixing the base and new shader.](lampcork.jpg).
![Top screw replacement in scad.](lamptopscrew.png)
![Top screw in place.](lamptopscrew.jpg).

### filmscanframe.scad
### Makefile.filmscanframe

A frame to scan film strips in a flat bed scanner, for both negatives
and positives. This is designed for Epson Perfection V850 Pro, so it
has Epson's positioning knobs. The positioning knobs can be turned
over the frame as with them the frame is too wide for A4 pocket.

I am using vuescan to scan the film strips.

The motivation for this was that Epson included a strip frame which
can scan only 3 strips at the time, and it has glass, which can cause
nasty optical errors and adds another optial layer reducing scan
quality, and it is has very smooth surfaces, causing reflections which
show up in pictures. This one has 4 strips, max 6 images each, for
total of 24 images to scan in one go.

This has strip at approximately 2mm over glass, which apparently Epson
is the focus point for this scanner when using film/negative
settings. It does not have focus change tabs like the Epson's own
frame, but when I tried to find the optimal height using Epson's
frame, I could not really see much difference between different
heights. The material I have been scanning is mostly taken with medium
consumer cameras so there are not that many pixels there anyway.

The frames are cheap enough that you can permanently store the strips
in the frame. At the current filament prices they cost approximately 2
euro per piece as printed, using about 100g of filament. I use plastic
binder pockets to store the frames.

The clips and film hole knobs require accurate printer. When using
less accurate printer, for a new frame, it seems to be better to
install covers without film first to make sure that all clips are ok
and there are no strings etc which would show in the final scan. 

There are multiple options in the beginning of the file for debugging.

The frame supports 35mm (135), 46mm (127), 16mm (110), and 912 films (use
Makefile to generate frames for difference formats).

Frame separators are used to flatten the film as negatives are often
curved. One issue I noticed with this is that most films seem to have
shrunk, so I had to add shrink factor to compensate for this. This is
relevant for 35mm film as the gap between frames is very small
(2mm). The value is tunable (set filmshouldbesize and filmshrunksize).

No supports are needed to print. I use black PLA to print
these. Lighter colours may cause reflections. 

![filmscanframe in scad.](filmscanframe.png)
![filmscanframe for 46mm film in scad.](filmscanframe46.png)
![filmscanframe with film and cover not installed](filmscanframe.jpg)
![filmscanframe with film and cover installed](filmscanframe2.jpg)

### circletemplate.scad

Templates to estimate radius/diameter of a curve. Handy when making a
3d model of an existing part. This can measure both outside and inside
curves.

This needs further development, the parts should have a hole which one
can run a string through to attach all of them together. Also, it
tries to arrange the parts to fit to a bed, but does rather miserable
job doing that.

To make values more visible, you can print bottom and top in different
color, such as black/white, with multicolor printer or by manually
switching filament during printing.

![circletemplates in openscad.](circletemplate.png)

### ruokasuppilo.scad

We had complaints that onion peels are not dropping to the compost bin
when pushed over the edge of the kitchen table above the compost bin,
but float in the air and get outside of the bin. So we needed a
funnel. This very large, requiring 400x400x450 printer to print, and
takes 2-3 days to print.

Still needs some improvements.

![ruokasuppilo installed.](ruokasuppilo.jpg)

### leafbatteryfan.scad
### Makefile.leafbatteryfan

Nissan Leaf has a serious problem with battery temperature management,
which means during winter it is too cold and during summer it is too
warm, limiting capacity and quick charging. The problem is worst
during wintertime when the range is already reduced due to other
effects. The problem becomes much worse if the battery is old and/or
has bad cells. This fan case can be installed to the service hatch
between rear seats, replacing the metal plate normally protecting the
hatch. In the summer this could also help keep battery cooler, though
the effect is likely very limited. While moving, there is not much to
do about the heat as airflow will pass around the battery pack. When
parked, pushing warm air from inside the car to above the battery will
somewhat reduce cooling of the battery and will warm up the battery if
done for long enough. The set also includes a filter which will avoid
hurting fingers in the spinning fan and reduce dust collecting over
the battery (though dust will get through from below while driving).

You need a strip of seal below, normal window/door seal works, a
92mm computer fan at 12V, which is quite common size, some filter
material to cover the filter part, and 3 29mm long 3.5mm countersink
screws, and screws to attach the fan.

I also built connector box to install wiring and jack connector for
power, which is connected to the car 12V socket. The connector box
snaps in the front of the base.

If you need to warm up the battery for a trip:

- Preferably have a car in semi-warm place or 16A 230V socket.

- Turn on car heating to 29.5 degrees C

- Turn on semi circulation (press circulation button, then press it
  again keeping it down until both circulation buttons leds blink
  twice. You need a bit of air coming in to allow the fan to push it
  into the battery space.

- Turn on the leafbatteryfan.

- Method 1: Lock the the doors using the door lock button while
  sitting inside doors closed, exit the car, and use mechanical key to
  lock the driver door. This may require changing settings of the door
  locking using Leafspy or similar. If the settings are default, the
  only way to lock all doors from outside while the car is on is to
  make sure you have the key with you, leave the driver window open,
  lock the doors usign lock button through window, press auto window
  up button, and lock the driver door with mechanical key. My auto
  window up does not work reliably.

- Method 2: If you have Leafspy app (strongly recommended), you can
  set option to turn the locking for driver door only, thus allowing
  locking all other doors, then exit the car and close the driver door
  with mechanical key.

If the car is in a garage at around 15 C, the fan seems to be able to
heat up the battery to 24-28 degrees within 12-24 hours, if cabin
temperature is set to 29 degrees C. This also balances the cells as
the car is on for a long time, and the BMS can do its magic. When
outside, it seems to keep the battery approximately 10-15 C above
ambient when connected to a 6A 230V supply.

Notice that if you cannot use full power, such as domestic socket at
minimal 6A 230V, the car will slowly drain the main battery. At 10A or 16A
there seems to enough power to allow charging while doing this, unless
it is very cold. Leaf limits heating to whatever is available from the
socket when plugged in, but it seems that it cannot limit heater low
enough that the car would still charge when connected to very low
power feed.

The connector box is for connectors and power switch. I used random
parts of my parts bin on a small proto board.

No supports are needed to print. Use Makefile.leafbatteryfan to create
all parts.

![leafbatteryfan case in scad.](leafbatteryfan.png)
![leafbatteryfan all parts needed.](leafbatteryfanallparts.jpg)
![leafbatteryfan screws and nuts needed.](leafbatteryfanscrews.jpg)
![leafbatteryfan seal installed.](leafbatteryfan-seal.jpg)
![leafbatteryfan connector board.](leafbatteryfanconnectorboard.jpg)
![leafbatteryfan connector board from other angle.](leafbatteryfanconnectorboard2.jpg)
![leafbatteryfan ready to install.](leafbatteryfan-ready-to-install.jpg)
![leafbatteryfan installed in a leaf with no filter yet.](leafbatteryfan-installed-without-filter.jpg)
![leafbatteryfan infrared image from underside of the car while fan is on.](leafbatteryfan-underside-infrared-image.jpg)
![leafbatteryfan infrared video after the fan has been running for around 12 hours.](leafbatteryfan-infrared-video.mp4)

### circletemplateiso.scad

I larger version of circletemplate, which is for measuring diameters of larger objects such as trees.
This one also has holes to tie the parts together with a bolt and nut, and hole for a strap.

To make values more visible, you can print bottom and top in different
color, such as black/white, with multicolor printer or by manually
switching filament during printing.

![circletemplatesiso in openscad.](circletemplateiso.png)

### hsu.scad

### hsutest.scad

Collected some modules or functions into a library to use in my
models. hsutest is a test file for some functions in the library.

Modules

function countersinkd returns countersink diameter when using
ruuvireika module to create screw holes. 

cylindervoids cuts tiny voids in cylinder shape, to make objects
potentially stronger by replacing fill with 100% fill in specified
area. Note that you need to check your slicer settings, as defaults
may cause voids to be expanded or deleted.

ruuvireika makes a hole for screw, including countersink shape. This
is intended to be used to cut out the hole for screw. I normally use wood screws for 3D prints.

ruuvitorni makes a tower for a screw to be used with ruuvireika above.

triangle makes a triagle with given x,y,z size. Fourth parameter tells
which orientation the triangle should be (0-11 for off-center
triangles and 12-23 for centered triangles). To see the shapes
generated, call triangletest() in openscad.

lighten makes a printable shape to make structures consume less
filament. This does not save much unless the structure is large, as
making fill at low fill percentage is very efficient, and additional
walls required to make this negate the savings.

roundedbox makes a cube with rounded edges. Third parameter is corner diameter.

tassu makes a shape to place in corners of a model to improve bed
adhesion, useful in particular for materials which are prone to
warping and using wide brim is not practical.

ring makes a cylinder with inside cut out, given diameter, wall thickness and height.

cone makes a hollow cone or cylinder, such as one made with cylinder
with d1 and d2 parameters. The cone is open at bottom.

tubeclip makes a round barrel shape for making clips for various boxes
other other attachments. Essentially two spheres hulled together.

spring makes a spring, with flat ends and mid plate. Mid plate splits
the spring direction to avoid spring creating torsion when
compressing. You need cylinder around the spring to avoid it bending
easily, and 3D printed springs are generally not very reliable. The
spring can be printed vertically and needs no supports. It takes
height, diameter, end plate thickness, spring thickness. In particular
spring thickness is very material specific. See flatspring for mode
durable design.

onehinge creates a hinge to make hinged structures such as opening
boxes with hinged covers. This is intended for hinges which become
permanent part of the model and are printed in-place.

printareacube creates a box for the printer's print area to test if
you print is going to fit. You need manually to adjust the model
inside the cube. Use difference and # in openscad so you can leave it
in the model.

antiwarpwall makes a heat cage to be used with ABS and other materials
which tend to warp if you do not have a heat enclosure for your
printer. It is intended to be used with brim, so there is a tiny hole
to allow outside brim only option in the slicer.

roundedcylinder makes a cylinder with rounded corners

roundedboxxyz makes a box with rounded corners with different roundings for xy and z directions.

supportbox makes a box support structure for parts if you do
not want to use slicer's supports.

supportcylinder makes a round support structure for parts if you do

flatspring makes a flat, more durable spring, which can be printed
sideways to make layers in strong direction.

function textlen calculates x size of given string.

portaat makes stairs, to be used for 3d modeling of buildings.

function length_and_depth_to_diameter calculates diameter of circle
when width and depth are given. This is useful in some situations when designing 3D models.

knobaxle and knob make knobs which rotate freely, so that various
cranks can be made. The axle can be printed in design orientation,
knob prints better upside down. Use same parameters when using these.

### windowframe
### windowcut
### windowtemplate
### function windowheight

modules to add windows to objects. I use 2mm polycarbonate for window
material. windowframe and windowcut take position, height and size of
window. Height should be the top of the frame, which is somewhat
unintuitive, as usually the windows are printed with window opening
towards bed. windowheight function returns the thickness of window
structure, so use that to calculate the height option for windowframe
and windowcut. Windowframe and windowcut parameters should be same.

The usage is
1. Use windowframe to create the upper and lower frame for the window.
2. Use windowcut to cut out the space for the window and the opening.
3. Slice the model so that window opens down
3. Set stop point to first layer above the top of the window (in slicer,
   the layer where print would continue over the polycarbonate/glass). 
4. Use windowtemplate to print out templates for windows, these help cutting 
   polycarbonate or whatever material you use to proper shape. Make sure that
   material is cut to at most the template size. There is tolerance so the window
   can safely be smaller, however, if it is too small, it might not stay in place
   then layers are printed on top, which may make edges ugly.
5. Start print, and when printer stops at stop point, drop window insert and
   continue the print.

### lattialista.scad

### Makefile.lattialista

I needed some skirting board parts for my home, this makes ones
compatible with the back boards.

Makes list parts for my kitchen and hall, corner part replacing original part, and backplate which these snap on.

This is roughly compatible with Nokia-made plastic skirting board
system, which is no more manufactured, but was commonly used in 1970's
concrete apartment buildings in Finland.

![lattialista.scad in openscad.](lattialista.png)

### tunturie460holder.scad

### Makefile.tunturie460cupholder

Cup holder for Tunturi E460 exercise bike.

If "strong" option is enabled, the model will trick slicer to generate
100% fill around the screwholes, making them stronger. This is useful
if you slice with lightning fill. What it does is generate very thin
concentric voids around the screw holes. Notice that "strong" option
will make the model very slow to process in openscad, and you need to
check that your print settings have "Hole Horizontal Expasion" set to
0.0, otherwise the slicer will expand the voids and reverse the effect
by making the print weaker.

The model also includes hanger for headphones.

Screws to attach the cupholder is 3.5mm diameter, 30mm long.

set print=1 to print the parts.

No supports are needed.

![tunturi e460 cupholder in scad.](tunturie460cupholder.png)
![tunturi e460 headphone hanger in scad.](tunturie460cupholderheadphonehanger.png)

#### towerkansi.scad

Our tower game box was missing top cover, made a new one.

![Tower game cover in scad.](towerkansi.png)
![Tower game cover installed.](towerkansi.jpg)

#### kaihdinpidike.scad

My apartment window shutter knob holder disintegrated, made a replacement.
Also makes round hole protectors for the outer window.

![Original disintegrated part.](kaihdinpidike-original.jpg)
![Kaihdinpidike in scad.](kaihdinpidike.png)



### akkunapa.scad

### Makefile.akkunapa

Protective covers for car battery terminals. Note that these do not seem to be very standardized, so might not work for all batteries.

![Battery terminal covers in scad.](akkunapa.png)

### eggcase.scad

### Makefile.eggcase

Case for ceramic egg by Anja Suonsivu.

![Egg case in scad.](eggcase.png)
![Egg case in use.](eggcase.jpg)

### tippadosetti.scad

Eye doctor said I need eye drops for my dry eyes, so I made a
dispenser for pipettes.  set print=1 for printing. For some printers
or materials you may need to increase axledtolerance and/or reduce
axleendl to make the hinge work.

![tippadosetti in scad.](tippadosetti.png)
![tippadosetti in use.](tippadosetti.jpg)

### raisepad.scad

Simple pads to raise furniture items a bit. Prints four. No supports needed.

![raisepad in scad.](raisepad.png)

### flyswatter.scad

Keeping windows open during summer brings in bugs. This is a basic
weapon against them. If printing with tpu, you get more flexible
weapon, but it needs to be a bit thicker, so edit tpu setting in the
beginning of the file.  You need a large printer..

![flyswatter in scad.](flyswatter.png)

### berrypicker.scad

### Makefile.berrypicker

Picker tool for bilberries (In Finnish mustikka). Latest version has
opening bottom mechanism so you can empty the berries to a bucket
easily. The model has two springs, one intergrated, one printed
separately, so provide lock mechanism return. No supports needed,
other than built-in support for tall plunger to allow printing with bed
slingers.

Don't forget close the bottom after emptying berries!

![berrypicker in scad.](berrypicker.png)

### berrycleaner.scad

### Makefile.berrycleaner

Tool to help with cleaning berries. Berries roll out, while leaves and
other non-round objects stay or drop through slits. The model includes
a top part for cleaning and bottom part to store non-berry stuff
dropping through slits. 

![berrycleaner in scad.](berrycleaner.png)
![berrycleaner base and top in scad.](berrycleanerall.png)

### utensilbox.scad

### Makefile.utensilbox

Simple utensil boxes which can be stacked. Size and number of slots can be tuned to fit a specific furniture. No supports needed, you need to press out the lifting holes after printing.

![Top box in scad.](utensilboxtop.png)
![Lower box with 2 slots in scad.](utensilbox2slot.png)
![Lower box in scad.](utensilboxbottom.png)

### yrttiviljelma.scad

A growing box for herbs from Lidl needed adaption for ready-grown
herbs sold in Finnish grocery stores. We made new top, cups and covers
which are large enough to fit the ready-grown herbs. Some of the herbs
grow fine in this thing, such as basil and some others. To avoid water
loss due to evaporation you need to use covers for unused cups, so
there is a holder for unused covers. The top needs to be printed in multiple parts as it is larger than most printers.

Credits for Sampo Kellomaki, who
did the first version.

![Parts for yrttiviljelma in scad.](yrttiviljelmaparts.png)
![Holder for extra covers in scad.](yrttiviljelmaholder.png)
![Suppilo in scad.](yrttiviljelmasuppilo.png)
![Suppilo in use.](yrttiviljelmasuppilo.jpg)

### treemeter.scad

Handy measurement tool to figure out sizes of trees, to find out if the trees should be spaced (12 cm) or if the tree is fully grown (27cm).  Also includes 6cm for pre-thinning.

![treemeter in Openscad.](treemeter.png)
![treemeter in use.](treemeter.jpg)

### stevensonshield.scad

### Makefile.stevensonshield

A stevenson shield to protect outside air sensors such as temperature
and moisture sensors.  Makefile generates all parts. The strange shape
of the wall attachment is trying to avoid rain droplets bouncing off
and getting inside the shield.

The model includes corner plates to attach various electronics to. The
model is stacked, with towers supporting next shield. Clips are used
so the model should not need other joiners, but if needed, drop of
glue to towers might do the trick.

The model can be tuned, but likely trying to make it too small will
make it too weak. When editing in openscad, print=0 setting gives you
cut-through model.

The base includes attachment which is intended for wall
installation. You may also install this to a 62mm diameter pole with
pole attachement parts. The screws needed are 3.5mm 30mm wood
screws. 62mm is the common pole in Finland, often used for car block
heater boxes in parking areas.

This is a complex model and thus can be slow to view and process. It
also takes quite a bit of time to print. Makefile generates some sets
of parts to allow parts printed in few sessions.

The shield includes a bug screen inside to avoid spider nets and bug
nests inside.

Tunables in stevensonshield.scad:

shields: number of shields, not including top cover. It does not have
a height limit, but likely it becomes too wobbly if made too high.

forceinfill: For some reason, slicers (cura and prusaslicer) get
confused on what is inside and what is outside, and do not generate
infill for the base. While I have successfully printed the base
without infill, this will add some rudimentary infill to support the
base. Alternatively, if this option is not on, extra supports are
generated for towers.

plated: circumference of the baseplate. This will control the
circumference of the shield, make it larger if you have larger thing
to put inside. Other variables are based on this.

bugprotection: enable bug protection mesh. Bottom of mesh has a small
part which suitable opening can be snapped off to allow cables
through. The base includes small clips to hold bug mesh in place.

cabletunnel: makes a short tunnel for easier routing of
cables. However, not compatible with bugprotection screen as bugs can
pass through the tunnel.

There are plenty of variables which can be tuned, you can try your
luck. Many variables may have unintended effects when changing them,
none of these have been tested for large alterations, other than
number of shields, which controls the height of the model.

No supports are needed to print. Towers are prone to collapsing so
they should be printed in sets, as they have a bit of attachment to
each other for stability.

![stevensonshield in Openscad.](stevensonshield.png)
![stevensonshield with screen in Openscad.](stevensonshield2.png)
![stevensonshield installed.](stevensonshield.jpg)

### hyllynpidike.scad

Spare part, shelf support was missing in furniture.

### expandable-businesscard-holder.scad

Business card holders which attach to each other. This was my first
ever 3d model, so looking at code may cause headache.

![expandable-businesscard-holder in Openscad.](expandable-businesscard-holder.png)

### kaiuttimen-jalka.scad

Foot for high-end speaker which apparantly is intended to insulate the
speaker from floor. This is copy of the original. Likely best to print
upside down with plenty of skirt.

### batterysorter.scad

This is intended for storing various batteries, in particular for
rechargeable ones.

### kivisen-jalka.scad

Tero Kivinen made a gaming table and this is a foot for its square steel legs.

### viemaritulppa.scad

We have part missing in the floor drain, this is a replacement.

### rattistopperi.scad

### momowheelfiller.scad

My momo racing wheel broke, and I tried to fix is with these two
parts. Rattistopperi is a part which limits the wheel movement range,
and original had completely disintegrated. Momowheelfiller was a form
for the inside of the wheel which had broken down, with the idea that
it could be fixed with epoxy and glass fiber. This failed as epoxy
escaped the form and the wheel was ruined beyond repair. Maybe someone has use for these.

### rainmeter.scad

### Makefile.rainmeter

A simple rain meter, which uses balanced cups to meter amount of
rain. Use the Makefile to build the parts.

The hole for magnet is designed round magnet which has diameter of
6.4mm and thickness of 3.2mm. 
place.

No supports are needed to print. The openscad file includes option
"adhesion" which is enabled by default, this will create some adhesion
structures around higher objects or objects which have shown tendency
to warp. You can disable this option and use slicer's brim if these
do not work well enough.

Makefile will make all parts. These include:

- Meter part itself.

- Weather cover for the unit which also includes rain collecting
  funnel.

- Grill to cover the funnel which is part of weather cover, to protect
  funnel from leaves.

- Attachments for flat surface, a 62mm pole, and vertical
  surface. These all assume 35mm wood screws to be used. The unit
  itself will stand on flat surface, but can be screwed into place
  with flat attachment. The attachments use a clip to keep the unit in
  place, but you can use a 3.5mm screw to secure the unit.

- Plastic tweezers to help putting magnet into its slot.

- Very small part to lock the magnet in place after the magnet is in
  its slot. Narrow bent-nose pliers are very useful to install this
  after putting the magnet in. This allows magnets to be recovered
  from the print later. The lock part has a tiny ball clip and keeps
  the magnet in place quite well.

- A tool to help placing the magnet into its slot. This does not work
  very well and it is overkill anyway, so this is not printed by
  default. Tiny magnets are difficult to handle as dropping them will
  almost certainly lead into lost magnet stuck to a metal table leg
  somewhere. This part requires accurate printer. This should be
  considered work-in-progress.

- rainmeterall.stl will print all parts except wall and pole
  attachments. Pick the attachment which you will use and print that.

- rainmeterattachments.stl will print both wall and 62pole attachments, as
  those are the largest. This is in case you have use for both.

- hallmetersensortester.stl is an addition to test hall sensor. In the
  end we used reed switch so this is obsolete.

- rainmetermagnetsensorbase.stl makes an electronics box for
  reedswitch board and d1mini. If you want to use some other
  electronics, modify this to suit your implementation.

We used d1mini esp32 board with a reedswitch between GND and pin 4 to
detect swing. With the 90mm funnel it corresponded to 1.62mm of rain
for a swing, so this is not accurate enough, so I updated the funnel
to 180mm, so it is now 0.4mm of rain per swing.

![rainmeter in Openscad.](rainmeter.png)
![rainmeter installed.](rainmeter.jpg)

### bicyclebottleholder.scad

My bicycle bottle holder disintegrated, this is a
replacement. Attachment is designed for my bicycle, brand Sarda (not
expensive one).

No supports are needed to print.

You can add cable binders to secure the holder better. It might work with screws used
originally, but 3D printed plastic might not be strong enough.

![Bicycle bottleholder in Openscad.](bicyclebottleholder.png)

### suihkupaa.scad

Our office shower mixers were replaced, and the new shower heads do not
properly fit in the old fittings. This is an adapter to work around the problem.

No supports are needed to print.

### showertray.scad

Tray for shower for shampoos etc.

Our setup has pipes behind the vertical car, you might not need the
openings for those so they can be disabled in showertray.scad with
"pipes" option..

No supports are needed to print.

### postilaatikkokyltti.scad

Mailbox sign designed for Orthex mailbox
(https://www.tokmanni.fi/postilaatikko-valikansi-harmaa-6411760556135).
The model includes locking pin to keep the sign in place.

Change "texts" and "textsizes", and possibly adjust width if necessary. No supports needed.

![postilaatikkokyltti in Openscad.](postilaatikkokyltti1.png)
![postilaatikkokyltti, backside in Openscad.](postilaatikkokyltti2.png)

### tolpanhattu.scad

Mailbox top to protect it from rainwater. No supports needed.

### sivellinteline.scad

Holder for paint brushes. No supports needed.

### pikkupoyta.scad

### Makefile.pikkupoyta

Tiny table with folding legs. I do not know what this was for other than use for something related to fingernails. No supports needed.

### cpap-ppe-adapter.scad

I tested PPE mask with CPAP device. This is very specific to the mask
as CPAP devices use one port, PPE masks have separate in and out
ports, so this combines the ports. It kind of works, but not very well. No supports needed.

### saunasuoja.scad

We had problems with people tuning sauna temperature without
authorization, so we needed to protect the sauna thermostat.

![Saunasuoja installed.](saunasuoja.jpg)

### ankermakeenclosure

### Makefile.ankermakeenclosure

Unfinished heat cover for ankermake 3D printer. No supports needed.

### lival-varaosa.scad

Spare part for lival desk lamp.

### powerstrip.scad

Model for powerstrip to be used for holders. This is from Tero Kivinen.

### mousetrap.scad

### Makefile.mousetrap

Mousetrap with creeping featurism.  Multiple parts. Needs accurate
printer. No supports needed.

This has caugth one mouse this far. There seems to be problem with
swinging plates not moving under the mice, in particular small
ones. Removing caugth mouse from the trap is a bit of challenge, the
storage box where the mice should end into does not have doors in the
input side so mice tend to hide under the swing plate. I need to some
sort of one-way door.

![Mouse trap in Openscad.](mousetrap.png)
![Mouse trap](mousetrap.jpg)

### ankermaketopbox.scad

A box for ankermake 3D printer, mostly for having a label for material
type, and holder for tweezers. No supports needed. Labels can be
printed with two materias for bettery text visibility.

### powerstrip2.scad

Adapted from Tero Kivinen's model, a different type of power strip.

### kyltti.scad

Angled label for table. Text plate can be printed with two materials to improve text visibility. No supports needed.

### lidldiffusor.scad

Lidl led desk lamp has very brigth leds, so I needed a diffusor to
ease strain on my eyes and reduce shade effects. No supports needed.

![Lamp before installing diffusor](lidldiffusorbefore.jpg)
![Lamp after installing the diffusor](lidldiffusorafter.jpg)

### filamentroll centering.scad

Center support for a broken filament roll. No supports needed.

### kangaspuuosat.scad

Spare parts for a loom. No supports needed.

### polecover.scad

cover for end of metal square tube. No supports
needed. badweldworkaround enables a cut at two corners for bed welding
work.

![Pole cover in scad.](polecover.png)

### power-strip-attachment.scad

Attach power strips to your wall etc. No supports needed.

![Power strip attachment in scad.](power-strip-attachment.png)

### vedonpoistaja.scad

Strain relief part. No supports needed.

### filamentholderwide.scad

### Makefile.filamentholderwide

Holder for wide filament rolls. Adapted from paperiteline.scad. No supports needed.

![Wide filament holder in Openscad.](filamentholderwide.png)

### polarbeltclip.scad

spare for polar belt for pulse measurement. There are multiple
versions of this belt clips, this only supports one of them. No supports needed.

![Polar belt clip in Openscad.](polarbeltclip.png)

### kivinen-57.scad

Birthday cake decoration. Uses Porygon.scad library found
from Internet. No supports needed.

### spiceblock.scad

Boxes to store spices. No supports needed.

![Spice boxes in Openscad.](spiceblock.png)

### ryobiadapter.scad

### Makefile.ryobiadapter.scad

Adapter to use cheap Lidl parkside batteries with ryobi and homelite
18V devices. Lidl batteries are less than half the price, but have no
undervoltage protection. This uses xh-m609 voltage protection circuit
to prevent battery damage due to undervoltage. This must not be used
for charging, so use original Lidl charger to charge
batteries. xh-m609 buttons are accessible through buttons in the case
and display is visible through opening. This needs M4x20 and M4x30
screws, latter with countersink, as those I happened to have.

It needs copper plate contacts for the ryobi interface. 1.5mm copper
plate can be cut easily to shapes, for which models are provided, and crimp
connectors are used for other cabling, 6mm. Use 2.5mm cables.

![ryobiadapter from bottom in Openscad.](ryobiadapter-bottom.png)
![ryobiadapter from top in Openscad.](ryobiadapter-top.png)
![ryobiadapter installed.](ryobiadapter.jpg)

### type2.scad

Type 2 EV charger cable holder. The cable can be looped around
it. Also includes model for plug, but that is only used for testing
the model.

![type2 plug while inserting in Openscad.](type2-plug-while-inserting.png)
![type2 plug when in place in Openscad.](type2-plug-when-in-place.png)
![type2 holder in Openscad.](type2-holder.png)
![type2 holder installed and in use.](type2.jpg)

### screwterminalcover.scad

### Makefile.screwterminalcover.scad

Screw terminal covers for the LFP battery packs we have at the
office. They clip to the terminal covers, but you can attach M8 bolt
to the cover for additional strength. It clips into the cover. Change
to count to make multiple terminals in one print.

![screwterminalcover in Openscad.](screwterminalcover.png)

### spicegrinder.scad

"Santa Maria" brand spice grinders are tedious to use, so I added a
handle. I would need a bit more torque but works better than without this.

![spidegrinder installed.](spicegrinder.jpg)

### knob.scad

Our cheese grater knob broke, this is a replacement.

### shellydinadapter.scad

### Makefile.shellydinadapter

DIN rail box for shelly 1PM Gen 4.  Needs some wiring, spring
terminals (or with a bit of mod, screw terminals), and optional on/off
switch. Support option enables support for a longish bridge for on/off
switch.

It has reset button from front panel, but it lacks feel and may need
more testing.

### pussinsulkija.scad

To make yet another version of one the most common objects in the
3D design space, this is my take on bag clip.  As 3D printed materials
tend to flex a bit, male grabbing part is slightly curved to
compensate the flexing.  Adjust l for making longer versions for
larger bags.

### cableroller.scad
### Makefile.cableroller

We 3D print a lot, so we had accumulated large number of empty
filament rolls. We needed a use for those. Turns out that 25m ethernet
cables fit in 1kg filament roll. This is a roller which you can use to
roll cables up easier. Top plate has slot you can initially put the
end of the ethernet cable.

As filament rolls do not seem to have a standardized center hole, this
includes adapeters for 3 most common roll types we had. Likely there
are many more, and with various brands.

To make all parts, use the makefile. Make -n -j -f Makefile.cableroller

*cablerollerbody.stl is the base plate.

*cablerollercrank.stl is the top plate with crank.

*cablerollerbolt.stl has center bolt and crank handle.

cablerollerknob.stl is just the crank handle (previous prints that as well).

**cablerollerclasohlsonadapter.stl is adapter for Clas Ohlson filament roll.

**cablerollerfrontierfilaadapter.stl is adapter for Frontierfila filament roll.

**cablerollernoname72adapter.stl is adapter for random filament roll we have plenty of.

**cablerollersunlurefilladapter.stl is adapter for Sunlu refill adapter.

**cablerolleresuncardboardadapter.stl is adapter for sunlu recycled cardboard adapter

**cablerolleradapters.stl prints all adapters

cablerollernonamecarryhandlebar.stl is handle bar for carry handle.

cablerollercarryhandle.stl is the carry handle body

cablerollerhandlebolts.stl is the bolt for carry handle (two needed)

*cablerollerhandleparts.stl is all parts for carry handle.

You need all *, and one of **.

Bolts may require accurate printer.

![cableroller from top in Openscad.](cableroller.png)
![cableroller being used.](cableroller.jpg)

### headphonehanger.scad

Headphone hangers for wall install.

![Headphone hanger in use.](headphonehanger.jpg)

### dinboxsuko.scad

Schuko socket extension box for DIN electrical box we have for specific schuko socket. 

### belttool.scad

Too to narrow leather belt to narrower size. Used to narrow leather
strap. This was designed to use Lidl Parkside "Precision Hobby Knife"
blades. Note that Lidl has several products with same name with
differing blades. The one I had HG02869 Version 06/2022. From pictures
I assume that blades are not interchangeable. Thinning is not reliable
and should be used carefully, it can eat into the material due to 3D
printed part flexing too much. This needs better design to prevent
this (separate bottom is likely culprit).

### paperrollholder.scad

Holder for kitchen paper rolls. Top screws in to prevent roll exiting in case of mishap.

