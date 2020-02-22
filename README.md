# Aorus Pro WiFi Z390 Hackintosh Setup

This is my personal setup. It probably won't work for other setups (even with identical hardware).

## Hardware

- CPU: Intel Core i9-9900K 3.6 GHz 8-Core Processor
- CPU Cooler: ARCTIC Liquid Freezer 240 74 CFM Liquid CPU Cooler
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
  - Platform Power
    - ErP: Enabled (Fixes boot after shutdown)
  - IO Ports
    - Internal Graphics: Enabled
    - WiFi: Disabled
    - Above 4G Decoding: Enabled
    - USB Configuration
      - Legacy USB Support: Disabled
      - XHCI Hand-off: Enabled
- Boot
  - Preferred Operating Mode: Advanced Mode

Note that CSM Support is left as enabled; disabling CSM Support causes a boot hang on reboot. For more infomation see [Issue #1](https://github.com/JosephDuffy/aorus-pro-wifi-z390-hack/issues/1).

Boot in to OpenCore and use Modified GRUB Shell. Run `setup_var_3 0x5C1 0x00` to remove CFG Lock (MSR 0xE2 write protection).

## Projects Utilised

| Name | Version | Link |
|------|---------|------|
| OpenCore | 0.5.5 | https://github.com/acidanthera/OpenCorePkg |
| Lilu | 1.4.1 | https://github.com/acidanthera/Lilu |
| WhateverGreen | 1.3.6 | https://github.com/acidanthera/WhateverGreen |
| AppleALC | 1.4.6 | https://github.com/acidanthera/AppleALC |
| IntelMausiEthernet | [2.5.0d0](https://github.com/Mieze/IntelMausiEthernet/tree/f3c69cec20efd24fa467cf16f44ccaae61336766) | https://github.com/Mieze/IntelMausiEthernet |
| VirtualSMC | 1.1.1 | https://github.com/acidanthera/VirtualSMC |
| USBMap | [f6e28b6](https://github.com/corpnewt/USBMap/tree/f6e28b6f0c7edd5347690a1721f5a2241cbcc35d) | https://github.com/corpnewt/USBMap |

## Feature Checklist

| Feature | Working | Notes |
|---------|---------|-------|
| Thunderbolt Hotplug | ☒ |  |
| Thunderbolt after wake from sleep | ☒ |  |
| DRM content in Safari | ☒ | Likely needs shivigva=80. Will wait for 10.15.4 |
| Reboot | ☑ |  |
| Hardware Acceleration | ☑ | h464/HEVC |
| Apple TV Playback | ☑ |  |
| CPU Power States | ☑ | Ranges from 800MHz up to 5GHz (Turbo Boost) |
| Shutdown | ☑ | Requires ErP to be enabled |
| Multimonitor on boot | ☑ | Dual-DP LG 5k and 4k over HDMI |
| LG 5k UltraFine | ☑ | Full 5k HDR |
| Unlock with Watch | ☑ |  |
| Bluetooth | ☑ |  |
| WiFi | ☑ |  |
| iMessage | ☑ |  |
| Handoff | ☑ | Handoff is flaky even on official hardware |
| Airdrop | ☑ |  |
| Hardware Sensors | ☑ | CPU/GPU/RAM usage, etc. via iStat Menus |
| Onboard Audio | ☑ | Only 3.5mm output tested |
| USB Audio | ☑ |  |
| Sleep/Wake | ☑ | Stasy asleep. Wakes for powernap and goes back to sleep. |

## Anonymisation Git Hook

Provided in the `hooks` directory is a pre-commit hook to anonymise the config plist files to remove sensitive information, such as serial numbers.

To have this automatically run setup git to use the `hook` directory:

```
git config core.hooksPath hooks
```
