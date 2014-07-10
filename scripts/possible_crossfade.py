
import os, time
import gobject
import pygst
pygst.require("0.10")
import gst

gst.MILLISECOND = gst.SECOND / 1000

def get_crossfade(duration):
    # To crossfade, we add an alpha channel to both streams. Then a video
    # mixer mixes them according to the alpha channel. We put a control
    # on the alpha channel to linearly sweep it over the duration of the
    # crossfade. The returned bin should get placed in a gnloperation.
    # The reason to put the alpha and final ffmpegcolorspace conversion
    # in this bin is that are only applied during the crossfade and not
    # all the time (saves some processing time).
    bin = gst.Bin()
    alpha1 = gst.element_factory_make("alpha")
    alpha2 = gst.element_factory_make("alpha")
    mixer  = gst.element_factory_make("videomixer")
    color  = gst.element_factory_make("ffmpegcolorspace")

    bin.add(alpha1, alpha2, mixer, color)
    alpha1.link(mixer)
    alpha2.link(mixer)
    mixer.link(color)

    controller = gst.Controller(alpha2, "alpha")
    controller.set_interpolation_mode("alpha", gst.INTERPOLATE_LINEAR)
    controller.set("alpha", 0, 0.0)
    controller.set("alpha", duration * gst.MILLISECOND, 1.0)

    bin.add_pad(gst.GhostPad("sink1", alpha1.get_pad("sink")))
    bin.add_pad(gst.GhostPad("sink2", alpha2.get_pad("sink")))
    bin.add_pad(gst.GhostPad("src",   color.get_pad("src")))

    return bin, controller # return the controller otherwise it will go out of scope and get deleted before it is even applied

class Main:
    def __init__(self):
        dur1 = 5000 # duration (in ms) to play of first clip
        dur2 = 5000 # duration (in ms) to play of second clip
        dur_crossfade = 500 # number of milliseconds to crossfade for

        # we play two clips serially with a crossfade between them
        # using the gnonlin gnlcomposition element.
        comp = gst.element_factory_make("gnlcomposition")

        # setup first clip
        src1 = gst.element_factory_make("gnlfilesource")
        comp.add(src1)
        src1.set_property("location", "/home/lane/work/sshow/src/test1.mp4")
        src1.set_property("start",          0    * gst.MILLISECOND)
        src1.set_property("duration",       dur1 * gst.MILLISECOND)
        src1.set_property("media-start",    0    * gst.MILLISECOND)
        src1.set_property("media-duration", dur1 * gst.MILLISECOND)
        src1.set_property("priority",       1)

        # setup second clip
        src2 = gst.element_factory_make("gnlfilesource")
        comp.add(src2)
        src2.set_property("location", "/home/lane/work/sshow/src/test2.mp4")
        src2.set_property("start",  (dur1-dur_crossfade) * gst.MILLISECOND)
        src2.set_property("duration",       dur2 * gst.MILLISECOND)
        src2.set_property("media-start",    0    * gst.MILLISECOND)
        src2.set_property("media-duration", dur2 * gst.MILLISECOND)
        src2.set_property("priority",       2)

        # setup the crossfade
        op = gst.element_factory_make("gnloperation")
        fade, self.controller = get_crossfade(dur_crossfade)
        op.add(fade)
        op.set_property("start",   (dur1-dur_crossfade) * gst.MILLISECOND)
        op.set_property("duration",       dur_crossfade * gst.MILLISECOND)
        op.set_property("media-start",    0             * gst.MILLISECOND)
        op.set_property("media-duration", dur_crossfade * gst.MILLISECOND)
        op.set_property("priority",       0)
        comp.add(op)

        # setup the backend viewer
        queue = gst.element_factory_make("queue")
        sink  = gst.element_factory_make("autovideosink")

        pipeline = gst.Pipeline("pipeline")
        pipeline.add(comp, queue, sink)

        def on_pad(comp, pad, element):
            sinkpad = element.get_compatible_pad(pad, pad.get_caps())
            pad.link(sinkpad)

        comp.connect("pad-added", on_pad, queue)
        queue.link(sink)

        self.pipeline = pipeline

    def start(self):
        self.running = True
        bus = self.pipeline.get_bus()
        bus.add_signal_watch()
        bus.enable_sync_message_emission()
        bus.connect("message", self.on_message)
        self.pipeline.set_state(gst.STATE_PLAYING)

    def on_exit(self, *args):
        self.pipeline.set_state(gst.STATE_NULL)
        self.running = False

    def on_message(self, bus, message):
        t = message.type
	if t == gst.MESSAGE_EOS:
            self.pipeline.set_state(gst.STATE_NULL)
            self.on_exit()
	elif t == gst.MESSAGE_ERROR:
            err, debug = message.parse_error()
	    print "Error: %s" % err, debug
            self.on_exit()

loop = gobject.MainLoop()
gobject.threads_init()
context = loop.get_context()

m = Main()
m.start()

while m.running:
    context.iteration(True)
