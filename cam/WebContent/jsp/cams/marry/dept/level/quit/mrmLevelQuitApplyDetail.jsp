<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>等级评定资格取消表</title>
<%
String applyId=request.getParameter("applyId");
String organType=request.getParameter("organType");
String method=request.getParameter("method");
String organCode=request.getParameter("organCode");
String organName=request.getParameter("organName");
%>
<next:ScriptManager/>
<script>
var applyId='<%=request.getParameter("applyId")%>';
var curDate ='<%=DateUtil.getDay()%>';
var organType='<%=request.getParameter("organType")%>';
var method='<%=request.getParameter("method")%>';
var organCode='<%=request.getParameter("organCode")%>';
var organName=decodeURIComponent('<%=request.getParameter("organName")%>');
var curOrganName = '<%=BspUtil.getParentOrgan().getOrganName()%>';
var curOrganCode = '<%=BspUtil.getParentOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelQuitApplyDetail.js"></script>
<style type="text/css">
<!--
label {
	font-size: 17px;
}
-->
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="applyDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>	
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true" method="getOrganInfo">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisAll">
			<model:field name="foreign" type="string"/>	
			<model:field name="townOpinionId" type="string"/>	
			<model:field name="cityOpinionId" type="string"/>	
			<model:field name="provinceOpinionId" type="string"/>	
			<model:field name="departmentOpinionId" type="string"/>	
		</model:record>
	</model:dataset>
	<model:dataset id="mrmElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryCatalog" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>		
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="MRM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>
<next:Panel>
  <next:TopBar>
    <next:ToolBarItem symbol="->"></next:ToolBarItem>
    <%
		if("UPDATE".equals(method)){
	%>
    <next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
    <next:ToolBarItem iconCls="edit" text="提交" handler="submit"></next:ToolBarItem>
    <%
		}
	%>
    <next:ToolBarItem iconCls="undo" text="取消" handler="undo"></next:ToolBarItem>
  </next:TopBar>
  <next:TabPanel>
     <next:Tabs>
        <next:Panel title="等级评定取消" autoHeight="true">
	       <next:Html>
					<form id="editForm"  dataset="applyDs" onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="700" align="center" class="noprint">
							<tr>
								<td colspan="4" align="center">
									<br><br>
									<font size="5" style="">取消婚姻登记机关等级资格申报表</font><br><br><br><br><br>
									 <div align="left">
									<p align="left" style='text-indent: 100.0pt' >
									取消等级资格单位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									取 消 等 级：
									<label field="applyLevel" dataset="evaluLevelDataSet" style="font-size: 20px;text-decoration: underline">></label><br><br>
									 </p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 单 位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 时 间：
									<label field="applyTime"  style="font-size: 20px;text-decoration: underline">></label>
									<br><br>
									</p>
									</div>
								</td>
							</tr>
						    <tr>
								<td align="center" width="15%">申请取消等级资格单位名称</td>
								<td width="30%"> <label field="organName" style="font-size: 17px"></label></td>
								<td width="30%" align="center">取消等级</td>
								<td width="25%"><label field="applyLevel" dataset="evaluLevelDataSet" style="font-size: 17px"></label></td>
							</tr>
							<tr>
							    <td rowspan="5" align=center>退出<br>原因</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea field="reason" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr>
							<tr>
								<td rowspan="4"  align="center">县级人民政<br>府民政部门<br>意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method)&&"13".equals(organType)){
									%>
									<select id="townOpinionId" field="townOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>
									<%
									}else{
									%>
                                        <label field="townOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<%
									if("UPDATE".equals(method)&&"13".equals(organType)){
									%>
									<textarea field="townOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>
									<%
									}else{
									%>
										<textarea field="townOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
							<label field="townOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="townAuditTime" field="townAuditTime"/>
								</td>
							</tr>	
							<tr>
								<td rowspan="4"  align="center">地市级人民政<br>府民政部门<br>意见</td>
								<td colspan="3">
								<%
									if("UPDATE".equals(method)&&"12".equals(organType)){
									%>
									<select id="cityOpinionId" field="cityOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>						
									<%
									}else{
									%>
									<label field="cityOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								
									</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method)&&"12".equals(organType)){
									%>
									<textarea field="cityOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>						
									<%
									}else{
									%>
										<textarea field="cityOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="cityOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="cityAuditTime" field="cityAuditTime"/>
								</td>
							</tr>	
							
							<tr>
								<td rowspan="4" align="center">省级人民政府<br>民政部门意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method)&&"11".equals(organType)){
									%>
									<select id="provinceOpinionId" field="provinceOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>					
									<%
									}else{
									%>
									<label field="provinceOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>	
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method)&&"11".equals(organType)){
									%>
									<textarea field="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>				
									<%
									}else{
									%>	
									<textarea field="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="provinceOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="provinceAuditTime" field="provinceAuditTime"/>
								</td>
							</tr>
							
							<tr>
								<td rowspan="4" align="center">民政部<br>审批意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "0".equals(organType)){
									%>
									<select id="departmentOpinionId" field="departmentOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>			
									<%
									}else{
									%>	
									<label field="departmentOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "0".equals(organType)){
									%>
									<textarea field="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>			
									<%
									}else{
									%>	
									<textarea field="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="departmentOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="departmentAuditTime" field="departmentAuditTime"/>
								</td>
							</tr>	
					   </table>
					</form>
			   </next:Html>
			</next:Panel>
     </next:Tabs>
  </next:TabPanel>
</next:Panel>
</body>
</html>
