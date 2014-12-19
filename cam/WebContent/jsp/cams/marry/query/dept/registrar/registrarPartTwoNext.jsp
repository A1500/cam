<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
	String titel ="婚姻登记员基本情况统计分析（二）";
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="registrarPartTwoNext.js"></script>
<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
}

tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}
.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>

<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets> 
	<model:dataset id="ds" cmd="com.inspur.cams.marry.query.dept.cmd.MemsRegistrarPartTwoCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="PARTY_NUM"/>
			<model:field name="PARTY_RATE"/>
			<model:field name="UNDERGRADUATES_NUM"/>
			<model:field name="UNDERGRADUATES_RATE"/>
			<model:field name="JUNIOR_NUM"/>
			<model:field name="JUNIOR_RATE"/>
			<model:field name="YEAR5_NUM"/>
			<model:field name="YEAR5_RATE"/>
			<model:field name="YEAR6_10_NUM"/>
			<model:field name="YEAR6_10_RATE"/>
			
			<model:field name="YEAR11_20_NUM"/>
			<model:field name="YEAR11_20_RATE"/>
			<model:field name="YEAR21_NUM"/>
			<model:field name="YEAR21_RATE"/>
			<model:field name="DEPARTURE_NUM"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv">
				<div align="center" style="width: 90%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;font-weight:bold;"><%=titel %></span></div>
				</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				<tr style="border-color: #000000;">
					<td colspan="4" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" rowspan="2" width="3%" align="center" >单位</td>
							<td class="tdTitle" rowspan="2" width="3%"  align="center"  >总数（人）</td>
							<td class="tdTitle" colspan="2" width="3%" align="center"  >政治面貌</td>
							<td class="tdTitle" colspan="4" width="3%" align="center"  >学历</td>
							<td class="tdTitle" colspan="8" width="3%" align="center"  >从事工作时间</td>
							<td class="tdTitle" rowspan="2" width="3%" align="center"  >离岗</br>人数</td>
						</tr>
						<tr>
							<td class="tdTitle" width="3%" align="center"  >党员</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >本科</br>以上</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle"  width="3%" align="center" >全日</br>大专</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle" width="3%" align="center"  >5年以下</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >6~10年</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle"  width="3%" align="center" >11~20年</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >21年以上</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
						</tr>
						<tr  repeat="true">
							<td align="center" ><label style="width: 150px;"field="ITEM_NAME"></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="PARTY_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="PARTY_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="UNDERGRADUATES_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="UNDERGRADUATES_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="JUNIOR_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="JUNIOR_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR5_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR5_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR6_10_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR6_10_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR11_20_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR11_20_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR21_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR21_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="DEPARTURE_NUM"/></label></td>
						</tr>
						</tbody>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>