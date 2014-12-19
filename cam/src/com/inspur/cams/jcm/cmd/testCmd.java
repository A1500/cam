package com.inspur.cams.jcm.cmd;
import java.io.IOException;
import org.loushang.next.chart5.BarData;
import org.loushang.next.chart5.BaseChartCommand5;
public class testCmd extends BaseChartCommand5{
    //实现execute方法（遵循Loushang5开发模式）
public void execute() throws IOException{
    //创建柱状图数据对象
        BarData data = new BarData();
        //使用addItem(String name, String value)方法，向数据对象中添加数据
        //参数name：显示的数据名称或类型描述   value：显示的数据值
        data.addItem("1月","50");
        data.addItem("2月", "10");
        data.addItem("3月", "47.34");
        data.addItem("4月", "63");
        data.addItem("5月", "38");
        data.addItem("6月", "82");
        data.addItem("7月", "42");
        data.addItem("8月", "58");
        data.addItem("9月", "34");
        data.addItem("10月", "50");
        data.addItem("11月", "24");
        data.addItem("12月", "40");
        //将添加的数据输出到前台客户端
        writeData(data);
    }
}
