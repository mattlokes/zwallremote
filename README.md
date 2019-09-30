# zwallremote
zwallremote (Zigbee Wall Remote) is a device based on TI's CC2530 Zigbee Tranciever with built in 8051. Which allows you to reuse your existing light switches to control Tradfi, Hue or other Zigbee Light Link lights.

In fact it actaully acts as a small cheap zigbee remote for all sorts of diffrent uses. For my use case i use it to send commands to zigbee2mqtt which are passed onto HomeAssistant for controlling my Tradfri light network. However there is no reason you could not use it to turn your TV on play music on some smart speakers.

# Basics
After booting, the zwallremote polls once a second to detect the state of the screw terminal. If there is a change in state it will send a ZCL_TOGGLE_CMD to the co-ordinator, currently a fixed address in the firmware. I measured current use to be approximately 2uA so it should be capable of running for over 2 years on a single CR2032 coin cell (depending on how many times the light switch is used). 

# PCB

No known issues, worked first time with my cheap aliexpress CC2530 modules. Pretty Simple

# Firmware
You can either:
1. Can use precompiled binary in firmware/bin/
  - Will need to change the address of your co-ordinator (currently 0x0012_4B00_02C5_A0A6)
    - Line 2053 of the hex file, its reverse byte ordered, see https://imgur.com/1fYdB8f.
  - TODO give script for manipulate the hex file
  
2. Comple it yourself:
  - Will need IAR workbench 8051.
  - TI's Z-Stack Home 1.2.2a.44539.
  - The files are just modification to the SampleSwitch example application so just replace files as required.
  - Patience, Prayer and Screaming.
  
# Zigbee2mqtt changes

1. You need to add ZWallRemote to "const devices" list of dictionaries in "node_modules/zigbee-shepherd-converters/devices.js":

```python
const devices = [
...
  {
      zigbeeModel: ['ZWallRemote0'],
      model: 'ZWallRemote0',
      vendor: 'Custom devices (DiY)',
      description: 'Matts Wall Switch Remote (https://github.com/mattlokes/ZWallRemote)'
      supports: 'on/off',
      fromZigbee: [ fz.cmdToggle ],
      toZigbee: [],
  },
...
]
```

2. Add "ZWallRemote0" to the "const mapping" dictionary in "lib/extension/homeassistant.js"

```python
const mapping = { 
 ...
    'ZWallRemote0': [ configurations.sensor_action ]
 ...
 }
```
