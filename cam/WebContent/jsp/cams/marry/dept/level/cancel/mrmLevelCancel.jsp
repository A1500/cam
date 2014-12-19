<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.marry.util.MrmApplyType"%>
<%@ page import="com.inspur.comm.util.IdHelp" %>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>撤销婚姻登记机关等级资格申报表</title>
<%
String applyId=request.getParameter("applyId");
String organType=request.getParameter("organType");
String method=request.getParameter("method");
String deptId=request.getParameter("deptId");
String handle=request.getParameter("handle");
String applyType=MrmApplyType.MRM_CANCEL;

String organArea=BspUtil.getCorpOrgan().getOrganCode();
String cityCode=organArea.substring(0,4)+"00000000";
String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"FULL_NAME");
String organName= BspUtil.getCorpOrgan().getOrganName();
%>
<next:ScriptManager/>
<script>
var applyId='<%=request.getParameter("applyId")%>';
var appId='<%=IdHelp.getUUID32()%>';
var curDate ='<%=DateUtil.getDay()%>';
var method='<%=request.getParameter("method")%>';
var deptId='<%=request.getParameter("deptId")%>';
var myDate = new Date();
var organType='<%=request.getParameter("organType")%>';
var skinValue='<%=request.getParameter("skinValue")%>';
var deptCode='<%=request.getParameter("deptCode")%>';
var applyType ='<%=applyType%>';
var cityName ='<%=cityName.substring(0,3)%>';
var organName ='<%=organName%>';

</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelCancel.js"></script>
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
			<model:field name="applyTime" type="string" rule="require" />
			<model:field name="reason" type="string" rule="require|length{500}" />
		</model:record>
	</model:dataset>	
	<model:dataset id="deptNameDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
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
	<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>
<next:Panel>
  <next:TopBar>
    <next:ToolBarItem symbol="->"></next:ToolBarItem>
    <%
		if(!"END".equals(method)){
	%>
    <next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
    <%
		} 
	%>
	<%
		if( "true".equals(handle) ){
	%>
     <next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
    <%
		} 
	%>
	
	<%
		if( "0".equals(organType) ){
	%>
     	<next:ToolBarItem iconCls="select"  text="同意撤销" handler="submitEnd"/>
     	<next:ToolBarItem iconCls="select"  text="不同意撤销" handler="cancelEnd"/>
    <%
		} 
	%>
	
	
    <next:ToolBarItem iconCls="undo" text="返回" handler="undo"></next:ToolBarItem>
  </next:TopBar>
  <next:TabPanel>
     <next:Tabs>
        <next:Panel autoHeight="true" title="撤销婚姻登记机关等级资格申报表">
	       <next:Html>
					<form id="editForm"  dataset="applyDs" onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="700" align="center" class="noprint">
							<tr>
								<td colspan="4" align="center">
									<br><br>
									<font size="5" style="">撤销婚姻登记机关<br><br>等级资格申报表</font><br><br><br><br><br>
								
									<div align="left">
									<p align="left" style='text-indent: 100.0pt' >
									撤销等级资格单位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									撤 消 等 级：
									 <label  field="applyLevel"  style="font-size: 20px;text-decoration: underline"  dataset="evaluLevelDataSet"></label>
									<br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 单 位： <label field="cancelOrganName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
								</p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 时 间：
										<%
										if("INSERT".equals(method) || "UPDATE".equals(method)){
										%>
										<input type="text" id="creatDate" field='applyTime'  name="申报时间" format="Y-m-d"  
										style="font-size: 17px;" readonly="readonly" onclick="LoushangDate(this)"/> 
										<%
										}else{
										%>	
											<label field="applyTime"  style="font-size: 20px;text-decoration: underline"/>
										<%
										} 
										%>
									<br><br>
									</p>
									</div> 
								</td>
							</tr>
						    <tr>
								<td align="center" width="30%">撤消等级资格单位名称</td>
								<td width="40%"> <label field="organName" style="font-size: 17px"></label></td>
								<td width="15%" align="center">撤消等级</td>
								<td width="15%"> <label   field="applyLevel"  style="font-size: 20px"  dataset="evaluLevelDataSet"></label>
								</td>
							</tr>
							<tr>
							    <td rowspan="5" align=center>撤消原因</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("INSERT".equals(method) || "UPDATE".equals(method)){
									%>
										<textarea id="reason" field="reason" name="撤消原因" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="6" 
										></textarea>
									<%
									}else{
									%>	
										<textarea field="reason" readonly="readonly" name="撤消原因" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="6" 
										></textarea>
									<%
									} 
									%>
								</td>
							</tr>
							<tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr>
							<tr>
								<td rowspan="4"  align="center">申请撤销<br>地市级人民政府<br>民政部门意见</td>
								<td colspan="3">
								<%
									if("12".equals(organType) && "true".equals(handle) ){
									%>
									<select id="cityOpinionId" name="选择申请撤销地市级人民政府民政部门意见" field="cityOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>						
									<%
									}else{
									%>	
										<label field="cityOpinionId"  dataset="opinionDataSet"/>				
									<%
									} 
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("12".equals(organType) && "true".equals(handle)){
									%>
									<textarea field="cityOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>						
									<%
									}else{
									%>	
										<textarea field="cityOpinion" readonly="readonly" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>						
									<%
									} 
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label field="cityOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
									<%
									if("12".equals(organType) && "true".equals(handle)){
									%>
									<input type="text" field="cityAuditTime"  title="地市级人民政府审核时间" format="Y-m-d"  
									style="font-size: 17px;" readonly="readonly" onclick="LoushangDate(this)"/>			
									<%
									}else{
									%>	
										<label field="cityAuditTime"/>
									<%
									} 
									%>
								</td>
							</tr>	
							
							<tr>
								<td rowspan="4" align="center">申请撤销<br>省级人民政府<br>民政部门意见</td>
								<td colspan="3" >
									<%
									if("11".equals(organType) && "true".equals(handle)){
									%>
									<select id="provinceOpinionId" field="provinceOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>					
									<%
									}else{
									%>	
										<label field="provinceOpinionId"  dataset="opinionDataSet"/>				
									<%
									} 
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("11".equals(organType) && "true".equals(handle)){
									%>
									<textarea field="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>				
									<%
									}else{
									%>	
										<textarea field="provinceOpinion" readonly="readonly" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>				
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
								<td colspan="3" align="right">
									<%
									if("11".equals(organType) && "true".equals(handle)){
									%>
									<input type="text" field="provinceAuditTime"  title="省级人民政府审核时间" format="Y-m-d"  
									style="font-size: 17px;" readonly="readonly" onclick="LoushangDate(this)"/> 				
									<%
									}else{
									%>	
										<label field="provinceAuditTime"/>
									<%
									} 
									%>
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
