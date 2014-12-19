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
			<model:dataset id="formDataSet" cmd="org.loushang.workflow.ecgapform.formdef.cmd.FormDefQueryCmd" method="query" autoLoad="true" pageSize="10">
				<model:record fromBean="org.loushang.workflow.ecgapform.formdef.data.Form">
				<model:field name="createTime" type="date" dateFormat="Y-m-d"/>
				</model:record>
			</model:dataset>
		</model:datasets>

<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" height="85">
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

		<next:GridPanel id="formGrid" name="formGrid" width="100%" height="100%" dataset="formDataSet" title="表单信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
	  			<next:RadioBoxColumn />
				<next:Column id="formId" header="表单ID" field="formId" width="150" />
				<next:Column header="表单名称" field="formCaption" width="300" />
				<next:Column header="创建时间" field="createTime" width="100%" />
			</next:Columns>
			
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="预览" iconCls="detail"  handler="preview"></next:ToolBarItem>
				<next:ToolBarItem text="删除" iconCls="delete"  handler="deleteForm"></next:ToolBarItem>
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar dataset="formDataSet"/>
			</next:BottomBar>
		</next:GridPanel>
</next:ViewPort>
	<script>
		function preview(){
			var sm=L5.getCmp('formGrid').getSelectionModel();
			var record=sm.getSelected();
			if(!record){
				alert("请选择记录");
				return;
			}
			var formId=record.get("formId");
			var text='表单预览';
			L5.forward("jsp/workflow/ecgapform/formpreview.jsp?formId="+formId,text);

		};
		function query(){
			 var formName=L5.get('formName').getValue();
			 var dataSet=L5.DatasetMgr.lookup("formDataSet");
			 dataSet.setParameter("FORM.FORM_CAPTION@like",formName);
			 dataSet.load();
		};
		function deleteForm(){
			var sm=L5.getCmp('formGrid').getSelectionModel();
			var record=sm.getSelected();
			if(!record){
				alert("请选择记录");
				return;
			}
			var formId=record.get("formId");
			var formDataSet = L5.DatasetMgr.lookup("formDataSet");
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
				if(state=="yes"){					
					var command=new L5.Command("org.loushang.workflow.ecgapform.formdef.cmd.FormDefCmd"); 
					command.setParameter("formId", formId);
					command.execute("delete");
					if (!command.error) {
						formDataSet.remove(record);		    	
						alert("删除成功！");
					}else{
						alert(command.error);
					}
				}else{
					return false;
				}
			});
		};
		
	</script>
	</body>
</html>