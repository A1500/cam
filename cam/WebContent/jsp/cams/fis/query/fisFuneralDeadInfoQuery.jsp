<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<html>
	<head>
		<title>火化数据分殡仪馆统计</title>
		<next:ScriptManager />
		<style>
		.body2 {
			background-color: #EAF4FD;
		}
		
		.table2 {
			border-collapse: collapse;
		}
		
		.input2 {
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
		
		.tr2{   
			yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
		} 
		
		.td2 {
			border-style: solid;
			border-color: #000000;
			border-width: 1px;
		}
		.tdIma {
			background-image: url(line.bpm);
			background-repeat: no-repeat;
		}
		</style>
		<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
			String date = sdf.format(new Date());
			int i = 0;
		%>
<script type="text/javascript">
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
		<script type="text/javascript" src="fisFuneralDeadInfoQuery.js"></script>
		<script type="text/javascript" src="../comm/fisDeadInfoDetailComm.js"></script>
		<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
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
	<!-- 分馆查逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queryDeadInfoSumByUnit" pageAble="flase">
	</model:dataset>
	<!-- 优惠类型 -->
	<model:dataset id="fisReducationTypeDic" cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queryByReductionDic" autoLoad="true">
	 <model:record>
	 		<model:field name="value" mapping="PREFERENTIAL_TYPE_NAME" type="string" />
			<model:field name="text" mapping="PREFERENTIAL_TYPE_NAME" type="string" />
	 </model:record>
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
	<fieldset><legend>查询条件
	<img class="GroupBoxExpandButton"
						src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" /> </legend>
				<div>
					<form class="L5form">
						<table width="100%" >
							<!--<tr style="height:0px;">
						       <td class="FieldLabel" >殡仪馆名称:</td>
						        <td class="FieldInput" ><input type="text" name="户口所在地"
									id="qOrganName" readonly="readonly"/> &nbsp;
									<button style="cursor: hand" onclick="forOrganHelp(this.id)">选择</button>
								<td style="display: none;"><input type="text" id="qOrganId" />
						        </td>
						        <td class="FieldLabel" >享受惠民政策:</td>
						        <td class="FieldInput" >
						        	<select id="qQreferentialTypeName">
						        		<option dataset="fisReducationTypeDic"></option>
						        	</select>
						        </td>
						     </tr>
						     --><tr>
						      	<td class="FieldLabel" >火化时间:</td>
						        <td class="FieldInput" >
							        <input type="text" id="SCremationTime"
									onpropertychange="changeDateStyle(this)" onblur="check(this)"
									format="Y-m-d" maxlength="10" value="2012-04-01"/><img
									src="../../../../skins/images/default/rl.gif" align="middle"
									onclick="getDay(this);"> &nbsp;至&nbsp; <input type="text"
									id="ECremationTime" onpropertychange="changeDateStyle(this)"
									onblur="check(this)" format="Y-m-d" maxlength="10"  value="2012-04-30"/><img
									src="../../../../skins/images/default/rl.gif" align="middle"
									onclick="getDay(this);">
							    </td>
						        <td  nowrap="nowrap" class="FieldLabel" colspan="2">
									<button onclick="query()">查 询</button>&nbsp;<button type="reset">重 置</button>
							    </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<!--逝者信息列表结束 -->
<next:Panel id="editDeadPanel"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"   width="100%"  
	height="100%" autoScroll="true">
	<next:Html>
		<div align="center" id="reDiv" style="display: none;overflow-y: scroll;">
		<div align="center" style="width: 95%;">
		<div align="center"><span id="reportTitle"
			style="font-size: large;">火化数据分殡仪馆统计报表</span></div>
		</div>
		<div align="right" class="L5form">
		<button onclick="exportExcel()">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 650px" class="table2"
			cellpadding="0" cellspacing="0" border="0">
			<tr class="tr2">
				<td colspan="2" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="2" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">统计时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table width="650px" class="table2" dataset="fisFuneralDeadInfoDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center">序号</td>
					<td class="tdTitle" align="center">殡仪馆编号</td>
					<td class="tdTitle" align="center">殡仪馆名称</td>
					<td class="tdTitle" align="center">火化数(具)</td>
				</tr>
				<tr repeat="true" class="tr2">
					<td class="td2" width="50px" align="center"><label
						field="ROWNUM"></label></td>
					<td class="td2" align="center"><label field="UNIT_ID"
						size="20" /></td>
					<td class="td2" align="right"><label field="UNIT_NAME"
						size="20" onclick="forUnitDetail(this.parentNode.parentNode)" /></td>
					<td class="td2" width="40%" align="center"><label field="NUM"
						size="20" onclick="javascript:forDetail(this.parentNode.parentNode)" /></td>
				</tr>
			</table>
			<table width="650px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="4" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date%></span></div>
				</tr>
			</table>
		</table>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>