# 256-colors-on-vga

A VGA driver to display 256 different colors on a monitor. Two-timing signals are generated in this system, vsync and hsync to synchronize the plotting of vertical and horizontal pixels, respectively. The color data of each pixel is generated using an 8 bit counter whose first 3-bits are for red, the next 3-bits are for green and the last 2-bits are for blue color data while the synchronization signals are generated. This way, as the counter counts, 256 different color combinations are displayed on the screen one after another. This counter is implemented on the FPGA board.



## Overall Schematic

<p align="left">
    <img alt="Schematic" src="https://raw.githubusercontent.com/arasgungore/butterworth-filter/main/Screenshots/overall_schematic.jpg" width="800">
</p>



## Author

👤 **Aras Güngöre**

* LinkedIn: [@arasgungore](https://www.linkedin.com/in/arasgungore)
* GitHub: [@arasgungore](https://github.com/arasgungore)
