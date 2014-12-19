<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%
BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
String photoId = command.findPhotoId(request.getParameter("peopleId"));
String photoTable = "COM_PHOTO";
if(photoId!=null && photoId.length()>0){
	photoTable = photoTable+"_"+photoId.substring(0,6);
}
%>
<html>
	<head>
		<title>人员体检表编辑</title>
		<next:ScriptManager/>
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		function print() {
			var url="../../../../../comm/print/jspcommonprint.jsp?";
			var width = 1024;
			var height = 768;
		    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		}
		</script>
		<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="bptphysicalexamination_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptPhysicalExaminationQueryCommand" global="true" method="queryInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPhysicalExamination">
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="telMobile" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="print" text="生成" handler="print" />
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0" width="98%" >
			<tr>
				<input type="hidden" name="peopleId" field="peopleId"  />
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label field="name" title="姓名"></label></td>
				<td class="FieldLabel" >性别：</td>
				<td class="FieldInput" ><label  name="sex" field="sex" dataset="SexDataset"  title="性别"/></td>
				<td class="FieldLabel" width="12%" rowspan="4">照片:</td>
				<td nowrap colspan="1" rowspan="4"><img
					name="RELATIONER_PHOTOC_IMG" width=75 height=100 
					src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" 
					align="top" onerror="javascript:this.src='../../../../dataCollection/comm/default.jpg'" alt="暂无图片"/>
					<input type="hidden" id="photoTemp" name="photoTemp">
					<input type="hidden" id="photoId" name="photoId"></td>
			 </tr>
			 <tr>
				<td class="FieldLabel" >出生日期：</td>
				<td class="FieldInput" ><label  name="birthday" field="birthday"   title="出生日期"/></td>
				
				<td class="FieldLabel">联系电话:</td>
				<td class="FieldInput"><label name="telMobile" field="telMobile" title="联系电话" ></td>  
			</tr>
			<tr>
				<td class="FieldLabel">现家庭住址:</td>
				<td class="FieldInput" colspan="3"><label name="address" field="address" title="户口薄住址" style="width:85%"></td>  
			</tr>	 
			<tr>
				<td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label type="text" name="conscriptDate" field="conscriptDate" format="Y-m-d" style="width: 100px;" maxlength="10" title="入伍时间"   ></label></td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput" ><label type="text" name="decruitmentDate" field="decruitmentDate" format="Y-m-d" style="width: 100px;"  title="退伍时间" maxlength="10"  ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap >原部队番号：</td>
				<td class="FieldInput" ><label type="text" name="forcesNo" field="forcesNo" title="原部队番号" ></label></td>
				<td class="FieldLabel" nowrap >退伍证号：</td>
				<td class="FieldInput" colspan="3"><label type="text" name="asdpNo" field="asdpNo" title="退伍证号" ></label></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >检查情况概述：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="inspection" field="inspection" style="width: 88%"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >诊断结论：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="conclusion" field="conclusion" title="诊断结论" style="width: 88%"></textarea><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >会诊小组成员签名：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="signature" field="signature"  style="width: 88%" ></textarea> </td>
			
			</tr>
	   		<tr>
			
				<td  class="FieldLabel" >签名时间:</td>
				<td class="FieldInput" colspan="5"><input type="text" name="hospitalTime" field="hospitalTime" format="Y-m-d" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
			</tr>
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/physicalexamination_print.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="type" name="printQuery" queryData="queryData" value="45"/>
			<input type="hidden" id="method" name="method"  value="queryPhysical"/>
			<input type="hidden" id="scaconfPath" value="intoMigration/intoMigrationPrintDao"/>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
