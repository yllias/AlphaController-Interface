# AlphaController - Delphi Implementation

## Overview

This repository contains the Delphi implementation used as part of the **[AlphaController](https://drive.google.com/file/d/19e3JAtkkvVFHQCaV6ak2ICiuk-VxShHx/view?usp=share_link)** project, developed as part of a diploma thesis at **HTBLuVA Salzburg** in 2020/21 by **Yll Kryeziu** and **Marvin Winkler**.

The AlphaController is a power control unit that optimizes the temperature control of electrical heaters using phase control and burst fire control. It addresses the limitations of an older PWM-based system by providing finer power control and eliminating temperature fluctuations.

### Project Scope

The Delphi application in this repository was developed to interact with a microcontroller-based system, allowing real-time configuration of power control parameters such as percentage of power and operation mode via a user interface. The system also communicates with the **BORIS (WinFact)** simulation software to receive user input and sends configuration data via **UART**.

### Key Features

- Real-time configuration of heater power through a custom Delphi interface.
- Supports multiple control modes:
  - Phase control (including uncorrected, voltage-corrected, and power-corrected modes)
  - Burst fire control
  - Optimized burst fire control using a Delta-Sigma modulator for better performance.
- Communication with the microcontroller via **USB** (using UART).
- Zero-Crossing detection for accurate synchronization with AC mains.
  
## Installation and Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/AlphaController-Delphi.git
    ```
   
2. Open the project in **Delphi RAD Studio**.

3. Compile the project to generate the executable.

4. Connect the microcontroller hardware (ensure proper connection via USB and installation of any necessary drivers).

## Usage

- Launch the compiled Delphi application.
- The user interface will allow you to configure the power settings, operation modes, and other parameters for the heaters connected to the system.
- The application will communicate with the microcontroller to send control signals and read back status information.

## Hardware Requirements

- **Microcontroller**: The system uses a custom-built board featuring an **ATmega644P** microcontroller, connected to Solid State Relays (SSRs) for controlling the heaters.
- **Zero-Crossing Detector**: Ensures accurate timing for switching.
- **Heaters**: Supports control of up to three heaters, with fine power adjustment in 1% steps.

## Modes of Operation

The AlphaController supports seven operational modes:
1. **Permanent ON**
2. **Permanent OFF**
3. **Phase Control (Uncorrected)**
4. **Phase Control (Voltage-Corrected)**
5. **Phase Control (Power-Corrected)**
6. **Burst Fire Control**
7. **Optimized Burst Fire Control** (using a Delta-Sigma modulator)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- **Yll Kryeziu** - Developer, Microcontroller Software
- **Marvin Winkler** - Developer, Hardware Design
