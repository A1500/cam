<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src="groupEntityStatic.js"></script>
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

.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

tr{
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
}

.td {
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.query.cmd.SomEntityStaticCmd" method="groupEntityStatic" global="true" autoLoad="false">
		<model:record>
			<model:field name="ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="COUNT" type="string" />
			<model:field name="COUNT_BUILD" type="string" />
			<model:field name="RATE_BUILD" type="string" />
			<model:field name="COUNT_UNBUILD" type="string" />
			<model:field name="RATE_UNBUILD" type="string" />
			<model:field name="COUNT_E" type="string" />
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
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel">登记时间:</td>
					<td class="FieldInput" colspan="2" >
						<input type="text" id="cxsj_q" format="Y-m-d" style="width:85" onclick="WdatePicker()" /> -----
						<input type="text" id="cxsj_z" format="Y-m-d" style="width:85" onclick="WdatePicker()" />
					</td>
					<td class="FieldButton">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">社会团体举办实体情况统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr style="border-width: 0px">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" /></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle" width="300" align="center" rowspan="2">地&nbsp;&nbsp;区</td>
							<td class="tdTitle" width="100" align="center" rowspan="2">社会团体<br/>总数</td>
							<td class="tdTitle" width="200" align="center" colspan="2">已建立举办实体</td>
							<td class="tdTitle" width="200" align="center" colspan="2">未建立举办实体</td>
							<td class="tdTitle" width="100" align="center" rowspan="2">举办实体数</td>
						</tr>
						<tr>
							<td class="tdTitle" width="100" align="center" >社会团体数</td>
							<td class="tdTitle" width="100" align="center" >比例</td>
							<td class="tdTitle" width="100" align="center" >社会团体数</td>
							<td class="tdTitle" width="100" align="center" >比例</td>
						</tr>
						<tr repeat="true">
							<td align="center" class="td">
								<a href="#">
								<label readonly="true" style="height: 20px;line-height:20px;" onclick="toShi(this)" field="NAME" /></label>
								<label style="display: none" readonly="true" field="ID" /></label>
								</a>
							</td>
							<td align="center" class="td">
								<label field="COUNT" ></label>
							</td>
							<td align="center" class="td">
								<label field="COUNT_BUILD" ></label>
							</td>
							<td align="center" class="td">
								<label field="RATE_BUILD" ></label>
							</td>
							<td align="center" class="td">
								<label field="COUNT_UNBUILD" ></label>
							</td>
							<td align="center" class="td">
								<label field="RATE_UNBUILD" ></label>
							</td>
							<td align="center" class="td">
								<label field="COUNT_E" ></label>
							</td>
						</tr>
					</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date %></span></div></td>
				</tr>
				</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>