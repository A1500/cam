<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>
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
		<script type="text/javascript" src="bptDemobilizedillCheck_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptDemobilizedillCheckQueryCommand" global="true" method="queryDemobilizedillCheck">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptDemobilizedillnessCheck">
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="toOrgan" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="view" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
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
				
				<td class="FieldLabel">身份证号:</td>
				<td class="FieldInput"><label name="idCard" field="idCard" title="身份证号" ></td>  
			</tr>
			<tr>
				<td class="FieldLabel">现家庭住址:</td>
				<td class="FieldInput" colspan="3"><label name="address" field="address" title="户口薄住址" style="width:85%"></td>  
			</tr>	 
			<tr>
				<td class="FieldLabel" nowrap>送检医院：</td>
				<td class="FieldInput"><input type="text" name="hospital" field="hospital" title="送检医院"   /><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>送检日期：</td>
				<td class="FieldInput" ><input type="text" name="toCheckDate" field="toCheckDate" format="Y-m-d" style="width: 100px;"  title="送检时间" maxlength="10" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >送检疾病：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="toCheckIllness" field="toCheckIllness" style="width: 88%" title="送检疾病"></textarea><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >检查结果：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="checkResult" field="checkResult" title="检查结果" style="width: 88%"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >是否符合标准：</td>
				<td class="FieldInput" colspan="5"><select name="advice" field="advice" onchange="hidden(this.value)" title="是否符合标准">
					  <option dataset="view"></option>
				    </select> </td>
			</tr>
			<tr id='hsystem' style="display:none">
				<td  class="FieldLabel" >系统：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="system" field="system" style="width: 88%"></textarea> </td>
			</tr>
			<tr id='hill'  style="display:none">
				<td  class="FieldLabel" >疾病：</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="illness" field="illness" style="width: 88%"></textarea> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >专家签字：</td>
				<td class="FieldInput" ><input type="text" name="sign" field="sign"   /> </td>
				<td  class="FieldLabel" >签名日期:</td>
				<td class="FieldInput" colspan="3"><input type="text" name="signDate" field="signDate" style="width: 100px;" format="Y-m-d" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap >送检单位：</td>
				<td class="FieldInput" ><label type="text" name="toOrgan" field="toOrgan"  title="送检单位" ></label>
				<input type="hidden" name="toOrganId" field="toOrganId" title="送检单位" ></td>
				<td class="FieldLabel" nowrap >送检日期：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="toOrganDate" field="toOrganDate" format="Y-m-d" style="width: 100px;" maxlength="10" title="送检时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
			</tr>
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/demobilizedillcheck.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="method" name="method"  value="queryDemobilizedillCheck"/>
			<input type="hidden" id="scaconfPath" value="intoMigration/intoMigrationPrintDao"/>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
