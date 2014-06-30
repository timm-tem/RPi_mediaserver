import pifacedigitalio
pifacedigital = pifacedigitalio.PiFaceDigital()

# without anything pressed
pifacedigital.input_port.value

pifacedigital.input_pins[0].value

pifacedigital.switches[0].value

# pressing the third switch
pifacedigital.input_port.value

bin(pifacedigital.input_port.value)

pifacedigital.input_pins[2].value  # this command is the same as...

pifacedigital.switches[2].value  # ...this command

