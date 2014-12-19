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
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="page_disability.js"></script>
<script type="text/javascript" src="../../prsComm.js"></script>
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.prs.query.cmd.PrsDisabilityCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="OTHER" type="string" />
			
			<model:field name="YB_1" type="string" />
			<model:field name="YZ_1" type="string" />
			<model:field name="YG_1" type="string" />
			
			<model:field name="YB_2" type="string" />
			<model:field name="YZ_2" type="string" />
			<model:field name="YG_2" type="string" />
			
			<model:field name="YB_3" type="string" />
			<model:field name="YZ_3" type="string" />
			<model:field name="YG_3" type="string" />
			
			<model:field name="YB_4" type="string" />
			<model:field name="YZ_4" type="string" />
			<model:field name="YG_4" type="string" />


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
					<td class="FieldLabel" nowrap>退役时间:</td>
					<td class="FieldInput" colspan="3" ><input type="text" id="cxsj_q"
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_z" 
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					<td>
					
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
				style="font-size: large;">山东省退役士兵统计表</span></div>
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
							<td class="tdTitle" width="15%" align="center" rowspan="3">单&nbsp;&nbsp;&nbsp;&nbsp;位</td>
							<td class="tdTitle" width="70%" align="center" colspan="12" >残疾退役士兵</td>
						</tr>
						<tr>
							<td class="tdTitle" width="8%" align="center" colspan="3">一级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">二级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">三级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">四级</td>
						</tr>
						<tr>
							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

						</tr>
						
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								onclick="test(this)" style="width: 20%;height: 20px;line-height:20px;" field="ORGAN_NAME" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'2')"  field="YZ_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'3')"  field="YG_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>

							<td align="right"><a href="#"><label onclick="querydetail(this,'4')"  field="YB_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'5')"  field="YZ_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'6')"  field="YG_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'7')"  field="YB_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'8')"  field="YZ_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'9')"  field="YG_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'10')"  field="YB_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'11')"  field="YZ_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'12')"  field="YG_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'13')"  field="YB_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
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