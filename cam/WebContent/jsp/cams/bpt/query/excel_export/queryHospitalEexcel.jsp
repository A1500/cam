<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	
%>
<Excel:tablelist filename="优抚医院发展情况工作统计表" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="21" align="center"><Excel:font size="12">优抚医院发展情况工作统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="21" border="1" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="1">
		    <Excel:td  width="40" valign="center" rowspan="3" align="center"><Excel:font size="13">地市</Excel:font></Excel:td>
		    <Excel:td  width="70" valign="center" rowspan="3" align="center"><Excel:font size="13">医院名称</Excel:font></Excel:td>
		    <Excel:td  width="70" valign="center" rowspan="3" align="center"><Excel:font size="13">行政级别</Excel:font></Excel:td>
		    <Excel:td  width="80" valign="center" rowspan="2" align="center"><Excel:font size="13">全年资金投入</Excel:font></Excel:td>
		    <Excel:td   colspan="4" align="center"><Excel:font size="13">自身建设情况</Excel:font></Excel:td>
		    <Excel:td   colspan="2" align="center"><Excel:font size="13">服务人员情况</Excel:font></Excel:td>
		    <Excel:td   colspan="4" align="center"><Excel:font size="13">康复疗养情况</Excel:font></Excel:td>
		    <Excel:td   colspan="6" align="center"><Excel:font size="13">精神病防治情况</Excel:font></Excel:td>
		    <Excel:td  width="70"  rowspan="2" align="center"><Excel:font size="13">年纯收入</Excel:font></Excel:td>
		  </Excel:tr >
		  <Excel:tr border="1">
		    <Excel:td  width="80"  align="center"><Excel:font size="13">新建改建扩建</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">新增大型设备</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">现有床位</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">其中新增床位</Excel:font></Excel:td>
		    <Excel:td  width="50"  align="center"><Excel:font size="13">医护人员</Excel:font></Excel:td>
		    <Excel:td  width="100"  align="center"><Excel:font size="13">管理和后勤保障人员</Excel:font></Excel:td>
		    <Excel:td  width="40"  align="center"><Excel:font size="13">床位</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">优抚对象</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">社会人员</Excel:font></Excel:td>
		    <Excel:td  width="40"  align="center"><Excel:font size="13">轮养</Excel:font></Excel:td>
		    <Excel:td  width="100"  align="center"><Excel:font size="13">全市复退军人精神病患者</Excel:font></Excel:td>
		    <Excel:td  width="100"  rowspan="2" align="center"><Excel:font size="13">是否建立防治网络</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">住院治疗</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">巡回医疗</Excel:font></Excel:td>
		    <Excel:td  width="80"  align="center"><Excel:font size="13">电话咨询</Excel:font></Excel:td>
		    <Excel:td  width="100" valign="center"  align="center"><Excel:font size="13">社会精神病患者治疗</Excel:font></Excel:td>
		  </Excel:tr >
		  
		  <Excel:tr border="1">
		    <Excel:td  width="38"  align="center"><Excel:font size="13">万元</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">平方米</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">台</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">张</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">张</Excel:font></Excel:td>
		    <Excel:td  width="45"  align="center"><Excel:font size="13">人</Excel:font></Excel:td>
		    <Excel:td  width="55"  align="center"><Excel:font size="13">人</Excel:font></Excel:td>
		    <Excel:td  width="28"  align="center"><Excel:font size="13">张</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="38"  align="center"><Excel:font size="13">人次</Excel:font></Excel:td>
		    <Excel:td  width="43"  align="center"><Excel:font size="13">万元</Excel:font></Excel:td>
		  </Excel:tr >
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td valign="center" align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td  align="center" width="180"><%=record.get("UNIT_FULLNAME")==null?"":record.get("UNIT_FULLNAME")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("ADMINISTRATIVE_LEVEL")==null?"":record.get("ADMINISTRATIVE_LEVEL")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("PUTFUNDS")==null?"":record.get("PUTFUNDS")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NEWEXPANSION")==null?"":record.get("NEWEXPANSION")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NEWEQUIPMENT")==null?"":record.get("NEWEQUIPMENT")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("YEAR_ACTUAL_BED")==null?"":record.get("YEAR_ACTUAL_BED")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("ADD_BED")==null?"":record.get("ADD_BED")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("SERVICE")==null?"":record.get("SERVICE")%></Excel:td>

            <Excel:td  align="center" width="180"><%=record.get("REAR_SERVICE_NUM")==null?"":record.get("REAR_SERVICE_NUM")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("RESORT")==null?"":record.get("RESORT")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("YEAR_BPT_NUM")==null?"":record.get("YEAR_BPT_NUM")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("SOCIETY_NUM")==null?"":record.get("ADDRESS")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NUMINYEAR")==null?"":record.get("NUMINYEAR")%></Excel:td>
            <Excel:td  align="center" width="180"><%=record.get("MENTALNUM")==null?"":record.get("MENTALNUM")%></Excel:td>
            <Excel:td  align="center" width="180"><%=record.get("IFPREVENTIONNET")==null?"":record.get("IFPREVENTIONNET")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("HOSPITALIZATION")==null?"":record.get("HOSPITALIZATION")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("MOBILEMEDICAL")==null?"":record.get("MOBILEMEDICAL")%></Excel:td>
			<Excel:td  align="center" width="120"><%=record.get("TELCONSULTATION")==null?"":record.get("TELCONSULTATION")%></Excel:td>
            <Excel:td  align="center" width="170"><%=record.get("TREATMENTALNUM")==null?"":record.get("TREATMENTALNUM")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("INCOME")==null?"":record.get("INCOME")%></Excel:td>
		</Excel:tr>
		<%
			}
			Record record=dataset.getRecord(0);
		%>
		<Excel:tr border="1">	
			 <Excel:td  valign="center" align="right" rowspan="5"><Excel:font size="13">合计:</Excel:font></Excel:td>
		
			<Excel:td    align="right"  ><Excel:font size="13">共计:</Excel:font></Excel:td>
			 <Excel:td   align="right" ><%=record.get("ADMINISTRATIVE_LEVEL_SUM1")==null?"":record.get("ADMINISTRATIVE_LEVEL_SUM1")%></Excel:td>
			 
			<Excel:td  valign="center"  align="right" rowspan="5"><%=record.get("PUTFUNDS_SUM")==null?"":record.get("PUTFUNDS_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("NEWEXPANSION_SUM")==null?"":record.get("NEWEXPANSION_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("NEWEQUIPMENT_SUM")==null?"":record.get("NEWEQUIPMENT_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("YEAR_ACTUAL_BED_SUM")==null?"":record.get("YEAR_ACTUAL_BED_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("ADD_BED_SUM")==null?"":record.get("ADD_BED_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("SERVICE_SUM")==null?"":record.get("SERVICE_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("REAR_SERVICE_NUM_SUM")==null?"":record.get("REAR_SERVICE_NUM_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("RESORT_SUM")==null?"":record.get("RESORT_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("YEAR_BPT_NUM_SUM")==null?"":record.get("YEAR_BPT_NUM_SUM")%>
				</Excel:td>
			<Excel:td valign="center" align="right" rowspan="5"><%=record.get("SOCIETY_NUM_SUM")==null?"":record.get("SOCIETY_NUM_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("NUMINYEAR_SUM")==null?"":record.get("NUMINYEAR_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("MENTALNUM_SUM")==null?"":record.get("MENTALNUM_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("IFPREVENTIONNET_SUM")==null?"":record.get("IFPREVENTIONNET_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("HOSPITALIZATION_SUM")==null?"":record.get("HOSPITALIZATION_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("MOBILEMEDICAL_SUM")==null?"":record.get("MOBILEMEDICAL_SUM")%>
				</Excel:td>
			<Excel:td  valign="center" align="right" rowspan="5"><%=record.get("TELCONSULTATION_SUM")==null?"":record.get("TELCONSULTATION_SUM")%>
				</Excel:td>
			<Excel:td valign="center"  align="right" rowspan="5"><%=record.get("TREATMENTALNUM_SUM")==null?"":record.get("TREATMENTALNUM_SUM")%>
				</Excel:td>
			<Excel:td  valign="center"  align="right" rowspan="5"><%=record.get("INCOME_SUM")==null?"":record.get("INCOME_SUM")%>
				</Excel:td>
		</Excel:tr>
		<Excel:tr border="1">	
			<Excel:td    align="right"  ><Excel:font size="13">正县:</Excel:font></Excel:td>
			<Excel:td   align="right" ><%=record.get("ADMINISTRATIVE_LEVEL_SUM2")==null?"":record.get("ADMINISTRATIVE_LEVEL_SUM2")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1">	
			<Excel:td    align="right"  ><Excel:font size="13">副县:</Excel:font></Excel:td>
			<Excel:td   align="right" ><%=record.get("ADMINISTRATIVE_LEVEL_SUM3")==null?"":record.get("ADMINISTRATIVE_LEVEL_SUM3")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1">	
			<Excel:td    align="right"  ><Excel:font size="13">正科:</Excel:font></Excel:td>
			<Excel:td   align="right" ><%=record.get("ADMINISTRATIVE_LEVEL_SUM4")==null?"":record.get("ADMINISTRATIVE_LEVEL_SUM4")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1">	
			<Excel:td    align="right"  ><Excel:font size="13">副科:</Excel:font></Excel:td>
			<Excel:td   align="right" ><%=record.get("ADMINISTRATIVE_LEVEL_SUM5")==null?"":record.get("ADMINISTRATIVE_LEVEL_SUM5")%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>