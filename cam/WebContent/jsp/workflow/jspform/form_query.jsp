<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){	
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
<next:ScriptManager />
</head>

<body>
<model:datasets>
	<model:dataset id="formDataSet" cmd="org.loushang.workflow.jspform.formdef.cmd.JspFormQueryCmd" autoLoad="true" pageSize="10">
		<model:record fromBean="org.loushang.workflow.jspform.formdef.data.JspFormDef">
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>	
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件 <img	class="GroupBoxExpandButton"	src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this);" /> </legend>
			<div class="GroupBoxDiv" >
			<form onsubmit="return false;"  class="L5form">
			<table border="1" width="90%">
				<tr>
					<td class="FieldLabel">表单名称：</td>
					<td class="FieldInput"><input type="text" id="formName"   size="50" title="表单名称" /></td>
					<td class="FieldLabel"><button onclick="query()">查询</button>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</fieldset>
</next:Html>
</next:Panel>

<next:GridPanel id="formGrid" name="formGrid" width="100%" height="100%" dataset="formDataSet" title="表单信息" notSelectFirstRow="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem text="增加" iconCls="add"  handler="addForm"></next:ToolBarItem>
	<next:ToolBarItem text="修改" iconCls="edit"  handler="updateForm"></next:ToolBarItem>
	<next:ToolBarItem text="删除" iconCls="delete"  handler="deleteForm"></next:ToolBarItem>
</next:TopBar>

<next:Columns>
	<next:RowNumberColumn width="30" />
			<next:RadioBoxColumn />
	<next:Column id="formId" header="表单ID" field="formId" width="150" />
	<next:Column header="表单名称" field="formName" width="300" />
	<next:Column header="表单描述" field="formDescription" width="400" />
</next:Columns>
	
<next:BottomBar>
	<next:PagingToolBar dataset="formDataSet"/>
</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
	<script>
		function query(){
			 var formName=L5.get('formName').getValue();
			 var dataSet=L5.DatasetMgr.lookup("formDataSet");
			 dataSet.setParameter("WF_JSP_FORM_DEF.FORM_NAME@like",formName);
			 dataSet.load();
		};
		function addForm(){
			var url="jsp/workflow/jspform/foreditdetail.jsp";
		    var text = 'JSP表单定义';
		    L5.forward(url,text);
		}
		function updateForm(){
			var formGrid = L5.getCmp('formGrid');
			// 判断是否选择了要修改的记录
			var selected = formGrid.getSelectionModel().getSelections();
			if (selected.length != 1) {
				L5.Msg.alert("提示", "请选择一条要修改的记录！");
				return false;
			}
			var url="jsp/workflow/jspform/foreditdetail.jsp?formId="+selected[0].get("formId");
		    var text = '修改JSP表单定义';
		    L5.forward(url,text);
		}
		function deleteForm(){
			var sm=L5.getCmp('formGrid').getSelectionModel();
			var record=sm.getSelected();
			if(!record){
				L5.Msg.alert("提示","请选择记录");
				return;
			}
			var formId=record.get("formId");
			var formDataSet = L5.DatasetMgr.lookup("formDataSet");
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
				if(state=="yes"){					
					var command=new L5.Command("org.loushang.workflow.jspform.formdef.cmd.JspFormCmd"); 
					command.setParameter("formId", formId);
					command.execute("delete");
					if (!command.error) {
						formDataSet.remove(record);		    	
						L5.Msg.alert("提示","删除成功！");
					}else{
						L5.Msg.alert("提示",command.error);
					}
				}else{
					return false;
				}
			});
		};
		
	</script>
	</body>
</html>