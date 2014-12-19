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
		<div style="display:none">
		<xml id="datasetDiv" >
			<datasets>
				<dataset id="formDataSet" proxy="cmd" pageSize="10"  autoLoad="true" method="query">
					<record>
						<field name="formId" type="string" />
						<field name="formCaption" type="string" />
					</record>
					<command>org.loushang.workflow.ecgapform.formdef.cmd.FormDefQueryCmd</command>
				</dataset>
			</datasets>
		</xml>
		</div>
		<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
			<next:Html>	
			<fieldset style="overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">查询条件 <img	class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this);" /> </legend>
					<div class="GroupBoxDiv" >
					<form onsubmit="return false;"  class="L5form">
					<table border="1" width="90%">
						<tr>
							<td class="FieldLabel">
								表单名称：				
							</td>
							<td class="FieldInput"><input type="text" id="formCaption" size="50" title="表单名称" /></td>
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
	  			<next:RadioBoxColumn />
				<next:Column id="formId" header="表单ID" field="formId" width="150" />
				<next:Column header="表单名称" field="formCaption" width="200" />
			</next:Columns>
			<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="确定" handler="selectOk"/>
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar dataset="formDataSet"/>
			</next:BottomBar>
		</next:GridPanel>
		
	<script>
		//选中某个表单，点击确定的处理函数
		function selectOk()
		{
			var userGridPanel=L5.getCmp("formGrid");
			var selecteds=userGridPanel.getSelectionModel().getSelections();
			if(selecteds.length!=1)
			{
				alert("请选择一条记录");
				return false;
			}
			//构造返回值信息，将选中的表单Id和表单名称放到返回值中返回
			var ret=[];
			ret[0]=selecteds[0].get("formId");
			ret[1]=selecteds[0].get("formCaption");
			window.returnValue=ret;
			window.close();
		}
		//查询表单函数
		function query(){
			 var formCaption=L5.get('formCaption').getValue();
			 var dataSet=L5.DatasetMgr.lookup("formDataSet");
			 dataSet.setParameter("FORM_CAPTION@like",formCaption);
			 dataSet.load();
		};
	</script>
	</body>
</html>