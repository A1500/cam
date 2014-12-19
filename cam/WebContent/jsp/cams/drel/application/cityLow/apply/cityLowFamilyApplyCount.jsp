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
	String titel ="城市低收入家庭信息统计表";
	
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src="cityLowFamilyApplyCount.js"></script>
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
	text-align: left;
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
	height:25px; 
	line-height:25px; 
	overflow:hidden; 
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
	<model:dataset id="lowFamilyCountDataSet" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" pageSize="-1" global="true" method="lowFamilyCount">
		<model:record >
			<model:field name="totalIncome" mapping="TOTALINC"/>
			<model:field name="totalProp" mapping="TOTALPRO"/>
			<model:field name="familyNum" mapping="NUM"/>
			<model:field name="apanageName" mapping="NAME"/>
			<model:field name="apanageId" mapping="ID"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	 	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form id="queryForm" style="width: 100%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">统计时间:</td>
					<td class="FieldInput" width="20%"  colspan="2">
	                     <input type="text" id="startDate" format="Y-m-d" name="startDate" readonly="readonly" onclick="LoushangDate(this)" 
	                     style = "width:46%;padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
	                 	~<input type="text" id="endDate" format="Y-m-d" name="startDate" readonly="readonly" onclick="LoushangDate(this)" 
	                     style = "width:46%;padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
	                
	                </td>
					<td class="FieldButton" >
						<button onclick="query()">查 询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
		<div>
			<div>
				<div align="center" style="width: 90%;">
				<div align="center"><span id="reportTitle"
					style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<div align="right" class="L5form">
				<button onclick="exportExcel()" >导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle">单位：户 、元</span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"> </span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="lowFamilyCountDataSet" align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" align="center" >行政区划</td>
							<td class="tdTitle" width="3%"  align="center"  >户数</td>
							<td class="tdTitle" width="3%"  align="center"  >平均家庭收入</td>
							<td class="tdTitle" width="3%"  align="center"  >平均家庭资产</td>
							
						</tr>
					
					<tr  repeat="true"> 
							<td style="display: none">
								<label readonly="true" field="apanageId" /></label>
				            </td>
							<td align="center">
								<a href="#">
									<label style="width: 100px;cursor: hand;" field=apanageName  onclick="queryNextLevel(this)" /></label>
								</a>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="familyNum" /></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="totalIncome"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="totalProp"/></label>
							</td>
							
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