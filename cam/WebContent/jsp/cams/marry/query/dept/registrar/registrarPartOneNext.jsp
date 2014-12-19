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
	String titel ="婚姻登记员基本情况统计分析（一）";
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="registrarPartOneNext.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.query.dept.cmd.MemsRegistrarPartOneCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="XZDW_NUM"/>
			<model:field name="XZDW_RATE"/>
			<model:field name="CGGLSYDW_NUM"/>
			<model:field name="CGGLSYDW_RATE"/>
			<model:field name="QEBKSYDW_NUM"/>
			<model:field name="QEBKSYDW_RATE"/>
			<model:field name="MAN_NUM"/>
			<model:field name="MAN_RATE"/>
			<model:field name="WOMAN_NUM"/>
			<model:field name="WOMAN_RATE"/>
			
			<model:field name="HANZU_NUM"/>
			<model:field name="HANZU_RATE"/>
			<model:field name="SHAOSHU_NUM"/>
			<model:field name="SHAOSHU_RATE"/>
			<model:field name="AVG_AGE"/>
			<model:field name="UNDER35AGE"/>
			<model:field name="UNDER35AGE_RATE"/>
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
							<td class="tdTitle" colspan="6" width="3%" align="center"  >性质</td>
							<td class="tdTitle" colspan="4" width="3%" align="center"  >性别</td>
							<td class="tdTitle" colspan="4" width="3%" align="center"  >民族</td>
							<td class="tdTitle" colspan="3" width="3%" align="center"  >年龄</td>
						</tr>
						<tr>
							<td class="tdTitle" width="3%" align="center"  >行政</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >参公</br>管理</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle"  width="3%" align="center" >全额</br>拨款</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle" width="3%" align="center"  >男</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >女</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle"  width="3%" align="center" >汉族</td>
							<td class="tdTitle" width="3%" align="center"  >%</td>
							<td class="tdTitle" width="3%" align="center" >少数</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
							<td class="tdTitle"  width="3%" align="center" >平均</td>
							<td class="tdTitle"  width="3%" align="center" >35岁以下</td>
							<td class="tdTitle"  width="3%" align="center" >%</td>
						</tr>
						<tr  repeat="true">
							<td align="center" ><label style="width: 150px;" field="ITEM_NAME"  /></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="XZDW_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="XZDW_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="CGGLSYDW_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="CGGLSYDW_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="QEBKSYDW_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="QEBKSYDW_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="MAN_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="MAN_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="WOMAN_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="WOMAN_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="HANZU_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="HANZU_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SHAOSHU_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SHAOSHU_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="AVG_AGE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="UNDER35AGE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="UNDER35AGE_RATE"/></label></td>
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