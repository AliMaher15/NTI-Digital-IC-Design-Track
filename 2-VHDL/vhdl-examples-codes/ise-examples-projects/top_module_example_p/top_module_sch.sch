<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="in1" />
        <signal name="out1" />
        <signal name="in2" />
        <signal name="not_and_wire" />
        <port polarity="Input" name="in1" />
        <port polarity="Output" name="out1" />
        <port polarity="Input" name="in2" />
        <blockdef name="and_gate">
            <timestamp>2024-3-18T8:55:16</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="not_gate">
            <timestamp>2024-3-18T8:55:28</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="and_gate" name="XLXI_1">
            <blockpin signalname="not_and_wire" name="in1" />
            <blockpin signalname="in2" name="in2" />
            <blockpin signalname="out1" name="out1" />
        </block>
        <block symbolname="not_gate" name="XLXI_2">
            <blockpin signalname="in1" name="in1" />
            <blockpin signalname="not_and_wire" name="out1" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2240" y="1488" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1232" y="1280" name="XLXI_2" orien="R0">
        </instance>
        <branch name="in1">
            <wire x2="1232" y1="1248" y2="1248" x1="1200" />
        </branch>
        <iomarker fontsize="28" x="1200" y="1248" name="in1" orien="R180" />
        <branch name="out1">
            <wire x2="2656" y1="1392" y2="1392" x1="2624" />
        </branch>
        <iomarker fontsize="28" x="2656" y="1392" name="out1" orien="R0" />
        <branch name="in2">
            <wire x2="2240" y1="1456" y2="1456" x1="2208" />
        </branch>
        <iomarker fontsize="28" x="2208" y="1456" name="in2" orien="R180" />
        <branch name="not_and_wire">
            <wire x2="1920" y1="1248" y2="1248" x1="1616" />
            <wire x2="1920" y1="1248" y2="1392" x1="1920" />
            <wire x2="2240" y1="1392" y2="1392" x1="1920" />
        </branch>
    </sheet>
</drawing>