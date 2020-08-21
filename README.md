# Aorus Pro WiFi Z390 Hackintosh Setup

This is my personal setup. It probably won't work for other setups (even with identical hardware).

Sometimes the runtime allocation error will start. Wipe CMOS and setup BIOS again to fix.

## Hardware

- CPU: Intel Core i9-9900K 3.6 GHz 8-Core Processor
- CPU Cooler: Noctua NH-D15
- Motherboard: Gigabyte Z390 AORUS PRO WIFI ATX LGA1151 Motherboard
- Memory: Corsair Vengeance LPX 32 GB (4 x 8 GB) DDR4-3200
- Storage: Samsung 960 EVO 500 GB M.2-2280 NVME Solid State Drive (macOS)
- Storage: Samsung 850 EVO-Series 250 GB 2.5" Solid State Drive (Windows)
- Video Card: MSI Radeon RX 580 8 GB ARMOR OC Video Card
- Thunderbolt Card: Gigabyte Titan Ridge
- Case: Fractal Design Define S ATX Mid Tower Case
- Power Supply: SeaSonic 750 W 80+ Gold Certified Fully Modular ATX Power Supply
- WiFi/BT: Fenvi T919
- Monitor: LG UltraFine 5K

### Hardware Configuration

- GPU in PCIEX16
- WiFi/BT card in PCIeX1_1
- Thunderbolt Card in PCIEX4

## BIOS Configuration

Uses BIOS F11. CFG lock is at 0x5C1 (**DO NOT COPY THIS VALUE**).

- Reset BIOS (CMOS reset)
- Load Optimised Defaults
- Enter Advanced Mode
- Tweaker
  - XMP Profile: Profile1
- Settings
  - IO Ports
    - Internal Graphics: Enabled
    - WiFi: Disabled
    - Above 4G Decoding: Enabled
    - Thunderbolt(TM) Configuration
      - Security Level: No Security
      - Discrete Thunderbolt(TM) Configuration
        - Thunderbolt Usb Support: Enabled
        - GPIO3 Force Pwr: Enabled
          - This is not strictly necessary to boot with the LG 5k connected at boot, but is required for non-Thunderbolt ports on a dock to work on boot
    - USB Configuration
      - Legacy USB Support: Disabled
      - XHCI Hand-off: Enabled
- System Info.
  - System Date: Current date
  - System Time: Current time
- Boot
  - Preferred Operating Mode: Advanced Mode

Note that CSM Support is left as enabled; disabling CSM Support causes a boot hang on reboot. For more information see [Issue #1](https://github.com/JosephDuffy/aorus-pro-wifi-z390-hack/issues/1).

Boot in to OpenCore and use Modified GRUB Shell. Run `setup_var_3 0x5C1 0x00` to remove CFG Lock (MSR 0xE2 write protection). Reboot.

## Projects Utilised

| Name                           | Version                                                                                     | Link                                                                                       |
| ------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| BIOS                           | F11                                                                                         | https://www.gigabyte.com/uk/Motherboard/Z390-AORUS-PRO-WIFI-rev-10/support#support-dl-bios |
| OpenCore                       | 0.6.0                                                                                       | https://github.com/acidanthera/OpenCorePkg                                                 |
| Lilu                           | 1.4.5                                                                                       | https://github.com/acidanthera/Lilu                                                        |
| WhateverGreen                  | 1.4.0                                                                                       | https://github.com/acidanthera/WhateverGreen                                               |
| AppleALC                       | 1.5.0                                                                                       | https://github.com/acidanthera/AppleALC                                                    |
| IntelMausiEthernet             | 2.5.0                                                                                       | https://github.com/Mieze/IntelMausiEthernet                                                |
| VirtualSMC                     | 1.1.4                                                                                       | https://github.com/acidanthera/VirtualSMC                                                  |
| NVMeFix                        | 1.0.2                                                                                       | https://github.com/acidanthera/NVMeFix                                                     |
| USBInjectAll                   | 0.7.5                                                                                       | https://github.com/Sniki/OS-X-USB-Inject-All                                               |
| USBMap                         | [f6e28b6](https://github.com/corpnewt/USBMap/tree/f6e28b6f0c7edd5347690a1721f5a2241cbcc35d) | https://github.com/corpnewt/USBMap                                                         |
| SSDT for Thunderbolt 3 Hotplug | SSDT-Z370-TB3HP                                                                             | https://www.tonymacx86.com/threads/in-progress-ssdt-for-thunderbolt-3-hotplug.248784/      |
| Config Sanity Checker          | N/A                                                                                         | https://opencore.slowgeek.com/                                                             |
| OpenCore Desktop Guide         | N/A                                                                                         | https://dortania.github.io/OpenCore-Desktop-Guide/                                         |

## Feature Checklist

| Feature                                                                                                                                   | Working | Notes                                                                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------- |
| FairPlay 1.x:                                                                                                                             | ☑       |                                                                                                |
| FairPlay 2.x/3.x (Netflix/Amazon Prime Video)                                                                                             | ☒       | https://github.com/JosephDuffy/aorus-pro-wifi-z390-hack/issues/5                               |
| FairPlay 4.x (Apple TV+)                                                                                                                  | ☑       |                                                                                                |
| Thunderbolt Hotplug                                                                                                                       | ☑       |                                                                                                |
| Thunderbolt after wake from sleep                                                                                                         | ☑       |                                                                                                |
| [iGPU performance (loading Apple's GuC)](https://dortania.github.io/OpenCore-Desktop-Guide/post-install/drm.html#fixing-igpu-performance) | ☑       | Tested with 400mbps HEVC video from [Jellyfish Bitrate Test Files](http://www.jell.yfish.us/)  |
| Reboot                                                                                                                                    | ☑       | [Requires CSM to be enabled](https://github.com/JosephDuffy/aorus-pro-wifi-z390-hack/issues/1) |
| Hardware Acceleration                                                                                                                     | ☑       | h264/HEVC                                                                                      |
| CPU Power States                                                                                                                          | ☑       | Ranges from 800MHz up to 5GHz (Turbo Boost)                                                    |
| Shutdown                                                                                                                                  | ☑       | Requires ErP or CSM to be enabled                                                              |
| Multimonitor on boot                                                                                                                      | ☑       | Dual-DP LG 5k and 4k over HDMI                                                                 |
| LG 5k UltraFine                                                                                                                           | ☑       | Full 5k HDR                                                                                    |
| Unlock with Watch                                                                                                                         | ☑       |                                                                                                |
| Bluetooth                                                                                                                                 | ☑       | Cannot turn off and back on without wake/sleep or reboot                                       |
| WiFi                                                                                                                                      | ☑       |                                                                                                |
| iMessage                                                                                                                                  | ☑       |                                                                                                |
| Handoff                                                                                                                                   | ☑       |                                                                                                |
| Airdrop                                                                                                                                   | ☑       |                                                                                                |
| Hardware Sensors                                                                                                                          | ☑       | CPU/GPU/RAM usage, etc. via iStat Menus                                                        |
| Onboard Audio                                                                                                                             | ☑       | Only 3.5mm output tested                                                                       |
| USB Audio                                                                                                                                 | ☑       |                                                                                                |
| Sleep/Wake                                                                                                                                | ☑       | Stays asleep. Wakes for powernap and goes back to sleep.                                       |

## Anonymisation Git Hook

Provided in the `hooks` directory is a pre-commit hook to anonymise the config plist files to remove sensitive information, such as serial numbers.

To have this automatically run setup git to use the `hook` directory:

```
git config core.hooksPath hooks
```
