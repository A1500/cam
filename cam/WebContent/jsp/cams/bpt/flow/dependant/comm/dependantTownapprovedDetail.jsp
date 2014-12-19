<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
	String peopleId=request.getParameter("peopleId");
	String familyId=request.getParameter("familyId");	
	String applyId=request.getParameter("applyId");
	%>
<html>
	<head>
		<title>三属县级审核明细表</title>
	</head>
	<next:ScriptManager/>
	<script type="text/javascript">
		function init() {
						var ds = L5.DatasetMgr.lookup("ds");
							ds.setParameter("apply_Id",'<%=request.getParameter("applyId")%>');
							ds.load();
							ds.on("load",change);
					}
			function func_Close(){
				window.close();
			}
	function change(){
		var ds1 = L5.DatasetMgr.lookup("ds");
		var obj = ds1.get("isApprove");
		if(obj=="1"){
			document.getElementById("ia1").style.display="none";
			document.getElementById("ia2").style.display="none";
			document.getElementById("ia3").style.display="";
			document.getElementById("ia4").style.display="";
		}else if(obj=="0"){
			document.getElementById("ia1").style.display="";
			document.getElementById("ia2").style.display="";
			document.getElementById("ia3").style.display="none";
			document.getElementById("ia4").style.display="none";
		}else{
			document.getElementById("ia1").style.display="none";
			document.getElementById("ia2").style.display="none";
			document.getElementById("ia3").style.display="";
			document.getElementById("ia4").style.display="";
		}
	}
		</script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDependantQueryCommand" method="queryTownApproved">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDependant"></model:record>
	</model:dataset>
	<!--同意认定 -->
	<model:dataset id="isApproveEnum" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
	<!--是否享受待遇 -->
	<model:dataset id="isSureEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

 <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
 <next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>	
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" rowspan="2" style="width: 15%">村（居）委会审核</td>
				<td class="FieldLabel" style="width: 10%">负责人</td>
				<td class="FieldInput"><label name="acceptIncharge" field="acceptIncharge" /></td>
				<td class="FieldLabel">审核日期</td>
				<td class="FieldInput"><label name="acceptDate" id="acceptDate" field="acceptDate"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">审查意见</td>
				<td class="FieldInput" colspan="3"><label id="acceptAdvice" name="acceptAdvice" field="acceptAdvice" ></label></td>
			</tr>
	   		<tr>
	   				<td class="FieldLabel" rowspan="2" style="width: 15%">乡（镇、街道）审核</td>
					<td  class="FieldLabel">负责人</td>
					<td class="FieldInput"><label name="countiesAduitIncharge" field="countiesAduitIncharge"/></td>
					<td  class="FieldLabel" >审核日期</td>
					<td class="FieldInput"><label name="countiesAduitApproveDate"id="countiesAduitApproveDate" field="countiesAduitApproveDate"></td>	
			</tr>
	   		<tr>
	   				<td class="FieldLabel" >审核意见</td>
					<td class="FieldInput" colspan="3"><label name="countiesAduitAdvice" field="countiesAduitAdvice"></label></td>
			</tr>
			<tr>
				<td  class="FieldLabel" rowspan="3" style="width: 15%">县（市、区）审批</td>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><label name="townAduitIncharge" field="townAduitIncharge"/></td>
				<td  class="FieldLabel" > 审批日期</td>
				<td class="FieldInput"><label name="townAduitApproveDate" id="townAduitApproveDate" field="townAduitApproveDate"></td>
				</tr>
			<tr>
				<td  class="FieldLabel" >是否同意认定</td>
				<td class="FieldInput" id="is2"><label name="isApprove" id="isApprove" field="isApprove" dataset="isApproveEnum"></td>
				<td  class="FieldLabel" id="ia1">是否享受待遇</td>
				<td class="FieldInput" id="ia2">
					<label name="isSure" id="isSure" field="isSure" dataset="isSureEnum"/>
				</td>
				<td  class="FieldLabel" id="ia3" ></td>
				<td class="FieldInput" id="ia4"  ></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >审批意见</td>
				<td class="FieldInput" colspan="3"><label name="townAduitAdvice" field="townAduitAdvice"></label></td>
			</tr>
			</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
</html>
