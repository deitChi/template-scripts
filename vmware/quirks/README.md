# Passthrough USB Keyboard on VMWARE

SSH to esxi, and find the required device

```bash
lsusb -v | grep -E '(^Bus|HID)'

Bus 001 Device 001: ID 0e0f:8002 VMware, Inc. Root Hub
Bus 002 Device 001: ID 0e0f:8002 VMware, Inc. Root Hub
Bus 003 Device 001: ID 0e0f:8001 VMware, Inc. Root Hub
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 003: ID 0781:5583 SanDisk Corp. Ultra Fit
Bus 002 Device 003: ID 0424:2660 Standard Microsystems Corp. Hub
Bus 002 Device 004: ID 05ac:911c Apple, Inc. Hub in A1082 [Cinema HD Display 23"]
Bus 002 Device 006: ID 05ac:921c Apple, Inc. A1082 [Cinema HD Display 23"]
        HID Device Descriptor:
          bcdHID               1.11
Bus 002 Device 007: ID 1532:0204 Razer USA, Ltd
        HID Device Descriptor:
          bcdHID               1.11
        HID Device Descriptor:
          bcdHID               1.11
        HID Device Descriptor:
          bcdHID               1.11
```

This is what's required

```bash
Razer Keyboard
1532:0204 Razer USA

Lenovo Mouse
17ef:608d
```

Add the follwing to your VMX file (or via GUI VM Advanced Settings).

```bash
usb.generic.allowHID = "TRUE"
usb.quirks.device0 = "0x1532:0x0204 allow"
usb.quirks.device1 = "0x17ef:0x608d allow"
```

The next step is to have the ESXi to not hide the devices.
Add the follwing to your ESXi /etc/vmware/config file.

```bash
usb.quirks.device0 = "0x1532:0x0204 allow"
usb.quirks.device1 = "0x17ef:0x608d allow"
```

And lastly add an exception for the keyboard device during ESXi boot. Either as an option or directly to the boot config file (in my case on my USB stick).
Add this to the /bootbank/boot.cfg file.

```bash
kernelopt=autoPartition=FALSE CONFIG./USB/quirks=0x1532:0x0204::0xffff:UQ_KBD_IGNORE
```