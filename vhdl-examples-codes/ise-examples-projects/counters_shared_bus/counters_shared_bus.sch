<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(1:0)" />
        <signal name="XLXN_2(3:0)" />
        <signal name="XLXN_3(3:0)" />
        <signal name="XLXN_4(3:0)" />
        <signal name="XLXN_5(3:0)" />
        <signal name="XLXN_6(3:0)" />
        <signal name="XLXN_7(1:0)" />
        <signal name="XLXN_8(3:0)" />
        <signal name="XLXN_9(1:0)" />
        <signal name="i_clk" />
        <signal name="XLXN_11">
        </signal>
        <signal name="i_rst" />
        <signal name="out_count(3:0)" />
        <signal name="i_function(1:0)" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18(3:0)" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20(3:0)" />
        <signal name="XLXN_21" />
        <port polarity="Input" name="i_clk" />
        <port polarity="Input" name="i_rst" />
        <port polarity="Output" name="out_count(3:0)" />
        <port polarity="Input" name="i_function(1:0)" />
        <blockdef name="bus_fsm">
            <timestamp>2024-3-18T9:52:17</timestamp>
            <rect width="288" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="352" y="-172" height="24" />
            <line x2="416" y1="-160" y2="-160" x1="352" />
        </blockdef>
        <blockdef name="johnson_counter">
            <timestamp>2024-3-18T9:52:34</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="bcd_counter">
            <timestamp>2024-3-18T9:56:8</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="ring_counter">
            <timestamp>2024-3-18T9:52:45</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="mux">
            <timestamp>2024-3-18T9:53:39</timestamp>
            <rect width="288" x="64" y="-256" height="256" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="352" y="-236" height="24" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
        </blockdef>
        <block symbolname="bus_fsm" name="XLXI_1">
            <blockpin signalname="i_clk" name="i_clk" />
            <blockpin signalname="i_rst" name="i_rst" />
            <blockpin signalname="i_function(1:0)" name="i_function(1:0)" />
            <blockpin signalname="XLXN_1(1:0)" name="o_Sel2(1:0)" />
        </block>
        <block symbolname="johnson_counter" name="XLXI_2">
            <blockpin signalname="i_clk" name="i_clk" />
            <blockpin signalname="i_rst" name="i_rst" />
            <blockpin signalname="XLXN_2(3:0)" name="o_johns_count(3:0)" />
        </block>
        <block symbolname="bcd_counter" name="XLXI_3">
            <blockpin signalname="i_clk" name="i_clk" />
            <blockpin signalname="i_rst" name="i_rst" />
            <blockpin signalname="XLXN_4(3:0)" name="o_bcd(3:0)" />
        </block>
        <block symbolname="ring_counter" name="XLXI_4">
            <blockpin signalname="i_clk" name="i_clk" />
            <blockpin signalname="i_rst" name="i_rst" />
            <blockpin signalname="XLXN_3(3:0)" name="o_ring_count(3:0)" />
        </block>
        <block symbolname="mux" name="XLXI_5">
            <blockpin signalname="XLXN_2(3:0)" name="i_johnson(3:0)" />
            <blockpin signalname="XLXN_3(3:0)" name="i_ring(3:0)" />
            <blockpin signalname="XLXN_4(3:0)" name="i_bcd(3:0)" />
            <blockpin signalname="XLXN_1(1:0)" name="i_S2(1:0)" />
            <blockpin signalname="out_count(3:0)" name="o_out4(3:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="624" y="1536" name="XLXI_1" orien="R0">
        </instance>
        <branch name="XLXN_1(1:0)">
            <wire x2="1056" y1="1376" y2="1376" x1="1040" />
            <wire x2="1056" y1="1376" y2="1584" x1="1056" />
            <wire x2="2224" y1="1584" y2="1584" x1="1056" />
        </branch>
        <branch name="XLXN_2(3:0)">
            <wire x2="1088" y1="800" y2="800" x1="784" />
            <wire x2="1088" y1="800" y2="1392" x1="1088" />
            <wire x2="2224" y1="1392" y2="1392" x1="1088" />
        </branch>
        <branch name="XLXN_3(3:0)">
            <wire x2="1808" y1="784" y2="784" x1="1600" />
            <wire x2="1808" y1="784" y2="1456" x1="1808" />
            <wire x2="2224" y1="1456" y2="1456" x1="1808" />
        </branch>
        <branch name="XLXN_4(3:0)">
            <wire x2="2224" y1="1520" y2="1520" x1="2208" />
            <wire x2="2208" y1="1520" y2="1680" x1="2208" />
            <wire x2="2736" y1="1680" y2="1680" x1="2208" />
            <wire x2="2736" y1="784" y2="784" x1="2592" />
            <wire x2="2736" y1="784" y2="1680" x1="2736" />
        </branch>
        <instance x="2224" y="1616" name="XLXI_5" orien="R0">
        </instance>
        <branch name="i_clk">
            <attrtext style="alignment:SOFT-TVCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1200" y="992" type="branch" />
            <wire x2="384" y1="1280" y2="1280" x1="256" />
            <wire x2="528" y1="1280" y2="1280" x1="384" />
            <wire x2="528" y1="1280" y2="1376" x1="528" />
            <wire x2="624" y1="1376" y2="1376" x1="528" />
            <wire x2="384" y1="1280" y2="1296" x1="384" />
            <wire x2="1872" y1="1296" y2="1296" x1="384" />
            <wire x2="400" y1="800" y2="800" x1="336" />
            <wire x2="336" y1="800" y2="912" x1="336" />
            <wire x2="528" y1="912" y2="912" x1="336" />
            <wire x2="528" y1="912" y2="1280" x1="528" />
            <wire x2="384" y1="1136" y2="1280" x1="384" />
            <wire x2="1200" y1="1136" y2="1136" x1="384" />
            <wire x2="1216" y1="784" y2="784" x1="1200" />
            <wire x2="1200" y1="784" y2="992" x1="1200" />
            <wire x2="1200" y1="992" y2="1136" x1="1200" />
            <wire x2="1872" y1="784" y2="1296" x1="1872" />
            <wire x2="2208" y1="784" y2="784" x1="1872" />
        </branch>
        <iomarker fontsize="28" x="256" y="1280" name="i_clk" orien="R180" />
        <branch name="i_rst">
            <wire x2="320" y1="1440" y2="1440" x1="256" />
            <wire x2="448" y1="1440" y2="1440" x1="320" />
            <wire x2="576" y1="1440" y2="1440" x1="448" />
            <wire x2="608" y1="1440" y2="1440" x1="576" />
            <wire x2="624" y1="1440" y2="1440" x1="608" />
            <wire x2="576" y1="1440" y2="1664" x1="576" />
            <wire x2="1680" y1="1664" y2="1664" x1="576" />
            <wire x2="400" y1="864" y2="864" x1="320" />
            <wire x2="320" y1="864" y2="1440" x1="320" />
            <wire x2="448" y1="1312" y2="1440" x1="448" />
            <wire x2="864" y1="1312" y2="1312" x1="448" />
            <wire x2="864" y1="848" y2="1312" x1="864" />
            <wire x2="1216" y1="848" y2="848" x1="864" />
            <wire x2="1680" y1="848" y2="1664" x1="1680" />
            <wire x2="2208" y1="848" y2="848" x1="1680" />
        </branch>
        <iomarker fontsize="28" x="256" y="1440" name="i_rst" orien="R180" />
        <branch name="out_count(3:0)">
            <wire x2="2656" y1="1392" y2="1392" x1="2640" />
            <wire x2="2784" y1="1392" y2="1392" x1="2656" />
        </branch>
        <iomarker fontsize="28" x="2784" y="1392" name="out_count(3:0)" orien="R0" />
        <branch name="i_function(1:0)">
            <wire x2="608" y1="1568" y2="1568" x1="352" />
            <wire x2="624" y1="1504" y2="1504" x1="608" />
            <wire x2="608" y1="1504" y2="1568" x1="608" />
        </branch>
        <iomarker fontsize="28" x="352" y="1568" name="i_function(1:0)" orien="R180" />
        <instance x="400" y="896" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1216" y="880" name="XLXI_4" orien="R0">
        </instance>
        <instance x="2208" y="880" name="XLXI_3" orien="R0">
        </instance>
    </sheet>
</drawing>