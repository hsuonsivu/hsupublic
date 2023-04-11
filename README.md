# Open source software by Heikki Suonsivu

## Various open source physical objects by Heikki Suonsivu

These are licensed, unless otherwise stated in program files or included license text,
under [Creative Commons CC-BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

I mostly use OpenSCAD for modeling, it will export STL. As I use
hull() a lot, these might be difficult to import to other cad
programs. Some of the models are really slow in OpenSCAD, so use F6
(or whatever in your computer) to render before changing viewing angle.

Please return improvements to me to be included in the
main distribution.

### canon-tripod-1-top.scad

I had old Canon tripod-1, and its rubbery top part disintegrated with
age. This is a replacement. Print with TPU.

### coasterholder3.scad

If you have a dead 5.25inch hard drive, you can recycle the disk
platters inside to make nice coasters for you bar. This is a holder
for coasters from a 8 platter Micropolis disk. Other hard disks might
need some adapting. See also "suklaarasiankansi.scad". 

### disk525to35.scad

This is an adapter to put 3.5 inch disk drive to a 5.25 drive slot. It
is designed to not to need screws, however, with certain cases that
might not work well due to funky mechanisms to lock things in
place. Maybe fixed in a future versions to allow screws to be used for
outside attachments.

printing time on Tronxy X5SA/Pro 400 or Anycubic Chiron takes about 18
hours, and uses about 200g of filament. No supports are needed, rotate
so that locking sticks on the bed, and on moving bed printers bed
moves in direction of locking sticks to avoid falling over.

To save filament printing time, default is to make the thing with
various cutouts.

Locking mechanism uses locking sticks, when pushed in, they push
knobs/keys into drive/case screw holes. Only side screw holes are
supported.

If you enable simple version, there is no locking
mechanism, and the adapter only locks with springs, and this does not
keep things in place very well.

Full height 3.5 inch drives will not fit as they are same height as
5.25 slot. Those are very rare anyway. Maybe this could be adapted by
removing top and bottom from disk position.

See options in the file.

### hammasharjateline.scad

Organizer for various things in the bathroom. Very specific, so not
very usable unless you use exactly same electric toothbrush and shaver
as me.

### license.scad

The default license file.

### lundiacarrier.scad

Carrying multiple lundia shelf plates is difficult as they tend to slide over each other. So I made a handle. You need to add two locking bands ([such as](https://www.tokmanni.fi/kiinnityshihna-pikalukko-25-mm-2-5-m-2-kpl-6419860608952).

