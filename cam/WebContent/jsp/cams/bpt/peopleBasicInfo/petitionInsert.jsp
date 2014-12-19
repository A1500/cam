<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>信访管理编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var peopleId = '<%=request.getParameter("peopleId")%>';
			var objectType = '<%=request.getParameter("objectType")%>';
		</script>
		<script type="text/javascript" src="petitionInsert.js"></script>
		<script type="text/javascript" src = "../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 信访 -->
	<model:dataset id="PetitionDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPetitionQueryCommand" global="true" pageSize="5">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPetition">
			<model:field name="objectTypeContext" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="100%" width="100%">
<next:Panel  title="信访管理" height="50%" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	    <next:ToolBarItem text="上传文档" iconCls="upload" handler="uploadFile" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="删除"  iconCls="remove" handler="del"/>
		<next:ToolBarItem text="保存"  iconCls="save" handler="save"/>
		<next:ToolBarItem text="取消"  iconCls="undo" handler="reset"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="PetitionDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" >姓名：</td>
				<td class="FieldInput"><label id="name" name="name" field="name" ></label></td>
			
				<td  class="FieldLabel" >身份证件号码：</td>
				<td class="FieldInput"><label id="idCard" name="idCard" field="idCard"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >优抚对象类别：</td>
				<td class="FieldInput"><%-- <label id="objectTypeContext" name="objectTypeContext" field="objectTypeContext" ></label> --%>
				<label id="objectType" name="objectType" field="objectType" dataset="ObjectTypeDataset"/></td>
				<td  class="FieldLabel" >信访时间：</td>
				<td class="FieldInput"><input type="text" name="petitionDate" field="petitionDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >信访内容：</td>
				<td class="FieldInput" colspan="3" ><textarea name="petitionContent" field="petitionContent" cols="122%" rows="3"></textarea>
					<font color="red">*</font> </td>
			</tr>
	   		
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3"><textarea name="note" field="note" cols="122%" rows="3"></textarea></td>
			
			</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="bptpetitionGrid" stripeRows="true" height="50%"  width="100%" dataset="PetitionDataset" title="信访管理明细">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
		<next:Column id="name" header="姓名" field="name" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别代码" field="objectType" width="200" dataset="ObjectTypeDataset">
		</next:Column>
		<next:Column id="petitionDate" header="信访时间" field="petitionDate" width="90">
		</next:Column>
		<next:Column id="petitionContent" header="信访内容" field="petitionContent" width="120">
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="120">
			<next:TextField/>
		</next:Column>
		<next:Column header="附件" field="" width="200" editable="false" renderer="downLoad">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="PetitionDataset" />
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
<next:Window id="uploadWin" title="上传附件" width="500" height="100" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form">
		<table width="100%">
			
			<tr>
				<td class="FieldLabel" >附件上传</td>
				<td class="FieldInput" ><input type="file" field="edocuments" name='"附件上传"' style="width:350"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="2"><span style="color:red">上传文件最大不能超过5M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>
