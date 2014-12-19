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
	//http://localhost:8080/cam/jsp/cams/drel/application/cityLow/apply/cityLowFamilyAvgCount.jsp?countCol=INCOME
	String countCol =request.getParameter("countCol");//INCOME,AREA
	//System.out.println(countCol);
	String titel="";
	String titel1="";
	String method="";
	int[] limit = {};
	String danwei="元";
	if("INCOME".equals(countCol)){
		 titel ="城市低收入家庭人均可支配收入统计表";
		 titel1="年人均可支配收入段";
		 method="lowFamilyAvgIncCount";
		 limit =new int[]{600,800,1000};
		 danwei="元";
	}
	if("AREA".equals(countCol)){
		titel="城市低收入家庭人均居住面积统计表";
		titel1="人均居住面积段";
		method="lowFamilyAvgAreaCount";
		limit=new int[]{10,20,50};
		danwei="平方米";
	}
	
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';	
	if(organCode=="370000000000"){
		organCode="370100000000";
	}
	var countCol='<%=countCol%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src="cityLowFamilyAvgCount.js"></script>
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
	<model:dataset id="lowFamilyCountDataSet" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" pageSize="-1" global="true" method="<%=method %>" autoLoad="false">
	
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
					 <div align="right"><span class= "btTitle">单位：户、人</span></div>
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
							<td class="tdTitle" width="3%" align="center" rowspan="3">行政区划</td>
							<td class="tdTitle" width="3%"  align="center"  rowspan="3">户数</td>
							<td class="tdTitle" width="3%"  align="center"  rowspan="3">人数</td>							
							<td class="tdTitle" width="3%"  align="center" colspan="<%=(limit.length+1)*2 %>" ><%=titel1 %></td>
							
						</tr>
						<tr>
							
							<%
							for(int i=0;i<(limit.length);i++){ 
								if(i==0){	%>							
							<td class="tdTitle" width="3%" align="center" colspan="2">低于<%=limit[i] %><%=danwei %>（含）</td>
							<%}if(i>0){%>
							<td class="tdTitle" width="3%"  align="center"  colspan="2"><%=limit[i-1] %><%=danwei %>—<%=limit[i] %><%=danwei %>（含）</td>
							<%} if(i==(limit.length-1)){	%>
							<td class="tdTitle" width="3%"  align="center"  colspan="2">高于<%=limit[i] %><%=danwei %></td>							
							<%}
							} %>	
							
							
						</tr>
						<tr>	
						<%	for(int i=0;i<(limit.length);i++){
							if(i==0){	%>
							<td class="tdTitle" width="3%"  align="center"  >户数</td>
							<td class="tdTitle" width="3%"  align="center"  >人数</td>
							<%}if(i>0){%>
							<td class="tdTitle" width="3%"  align="center"  >户数</td>
							<td class="tdTitle" width="3%"  align="center"  >人数</td>
							<%} if(i==(limit.length-1)){	%>
							<td class="tdTitle" width="3%"  align="center"  >户数</td>
							<td class="tdTitle" width="3%"  align="center"  >人数</td>
							<%}
							} %>	
																				
						</tr>
					
					<tr  repeat="true"> 
							<td style="display: none">
								<label readonly="true" field="ID" /></label>
				            </td>
							<td align="center">
								<a href="#">
									<label style="width: 100px;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)" /></label>
								</a>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="TOTALF" /></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="TOTALH"/></label>
							</td>
							<%	for(int i=0;i<(limit.length);i++){ %>
							<% if(i==0){	%>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="F<%=i+1 %>"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="H<%=i+1 %>"/></label>
							</td>
							<%}if(i>0){%>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="F<%=i+1 %>"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="H<%=i+1 %>"/></label>
							</td>
							<%} if(i==(limit.length-1)){	%>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="F<%=i+2 %>"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="H<%=i+2 %>"/></label>
							</td>
							<%}
							} %>								
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