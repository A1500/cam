<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>信访管理查看</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var username ='<%=request.getParameter("username")%>';
			var idCard ='<%=request.getParameter("idCard")%>';
			var peopleId ='<%=request.getParameter("peopleId")%>';
			var objectType ='<%=request.getParameter("objectType")%>';
		</script>
		<script type="text/javascript" src="petitionDetail.js"></script>
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

<next:Panel  title="信访管理" autoHeight="true" width="100%" collapsible="true">
	<next:Html>
		<form id="editForm"   dataset="PetitionDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" style="width:20%">姓名：</td>
				<td class="FieldInput" style="width:30%"><label id="name" name="name" field="name" ></label></td>
			
				<td  class="FieldLabel" style="width:20%">身份证件号码：</td>
				<td class="FieldInput" style="width:30%"><label id="idCard" name="idCard" field="idCard"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >优抚对象类别：</td>
				<td class="FieldInput"><label id="objectType" name="objectType" field="objectType" dataset="ObjectTypeDataset"></label></td>
				<td  class="FieldLabel" >信访时间：</td>
				<td class="FieldInput"><label name="petitionDate" field="petitionDate" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >信访内容：</td>
				<td class="FieldInput" colspan="3"><label name="petitionContent" field="petitionContent" cols="122%" rows="3"></label></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3"><label name="note" field="note" cols="122%" rows="3"></label></td>
			</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="bptpetitionGrid"  stripeRows="true" height="100%" width="100%" dataset="PetitionDataset" title="信访管理">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:RadioBoxColumn></next:RadioBoxColumn>
	
		<next:Column id="name" header="姓名" field="name" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="petitionDate" header="信访时间" field="petitionDate" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="petitionContent" header="信访内容" field="petitionContent" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column header="附件" field="" width="200" editable="false" renderer="downLoad">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="PetitionDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
