<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>定期认证列表</title>
<next:ScriptManager />
<script type="text/javascript">
			var username ='<%=request.getParameter("username")%>';
			var idCard ='<%=request.getParameter("idCard")%>';
			var peopleId ='<%=request.getParameter("peopleId")%>';
			var objectType ='<%=request.getParameter("objectType")%>';
		</script>
<script type="text/javascript" src="regularIdentificationDetail.js"></script>
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
	<model:dataset id="RegularIdentificationDataset"
		cmd="com.inspur.cams.bpt.manage.cmd.BptRegularIdentificationQueryCommand"
		method="queryRegularIdentification" global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptRegularIdentification">
			<model:field name="objectTypeContext" type="string" />
		</model:record>
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="定期认证" autoHeight="true" width="100%">
	<next:Html>
		<form id="editForm" dataset="RegularIdentificationDataset"
			onsubmit="return false" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width: 20%">姓名：</td>
				<td class="FieldInput" style="width: 30%"><label id="name"
					name="name" field="name"></label></td>

				<td class="FieldLabel" style="width: 20%">身份证件号码：</td>
				<td class="FieldInput" style="width: 30%"><label id="idCard"
					name="idCard" field="idCard"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">优抚对象类别：</td>
				<td class="FieldInput"><label id="objectType"
					name="objectType" field="objectType" dataset="ObjectTypeDataset"></label></td>

				<td class="FieldLabel">认定时间：</td>
				<td class="FieldInput"><label name="identificationDate"
					field="identificationDate" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">认定结果：</td>
				<td class="FieldInput" colspan="3"><label
					name="identificationResult" field="identificationResult"
					cols="122%" rows="3"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注：</td>
				<td class="FieldInput" colspan="3"><label name="note"
					field="note" cols="122%" rows="3"></label></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="bptregularidentificationGrid"
	stripeRows="true" height="100%" width="100%"
	dataset="RegularIdentificationDataset" title="定期认证">
	<next:Columns>
		<next:RowNumberColumn header="序号" width="45" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="name" header="姓名" field="name" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别"
			field="objectType" width="200" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="identificationDate" header="认定时间"
			field="identificationDate" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="identificationResult" header="认定结果"
			field="identificationResult" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="120">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="RegularIdentificationDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
