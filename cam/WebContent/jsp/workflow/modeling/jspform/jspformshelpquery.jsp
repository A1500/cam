<%@ page language="java" contentType="text/html;charset=utf-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>流程类型与Jsp表单</title>
		<next:ScriptManager></next:ScriptManager>
	</head>

<BODY topmargin="10px">
<model:datasets>
	<model:dataset pageSize="10" id="processTypeDataset" cmd="org.loushang.workflow.processtype.cmd.ProcessTypeQueryCmd" autoLoad="true" global="true">
		<model:record  fromBean="org.loushang.workflow.processtype.data.ProcessType"></model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="formDataset" cmd="org.loushang.workflow.jspform.JspFormsHelpQuery" autoLoad="false" global="true">
		<model:record >
			<model:field name="formId"  type="string"></model:field>
			<model:field name="formName"  type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel id="allPanel"  autoScroll="true"  border="false">
  <next:TopBar>
    <next:ToolBarItem symbol="->" ></next:ToolBarItem>
    <next:ToolBarItem iconCls="add"  text="确定" handler="doConfirm" />
    <next:ToolBarItem iconCls="delete"  text="关闭" handler="doClose"/>
  </next:TopBar>
  <next:TabPanel id="tabPanels">
  <next:Tabs>
  <next:Panel title="流程类型选择" id="processTypeTab" width="100%"  height="100%"  border="false" autoScroll="false">
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel">流程类型名称：</td>
									<td class="FieldInput"><input type="text"  id="processTypeName" class="TextEditor" title="流程类型名称" /></td>
									<td class="FieldButton" rowspan="2"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="processTypeGridPanel" width="100%" height="100%" dataset="processTypeDataset"     title="流程类型列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn  ></next:RadioBoxColumn>
					<next:Column header="流程类型Id" field="typeId" width="200" hidden="true">
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型名称" field="typeName" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型描述" field="description" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="processTypeDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		<next:Panel title="Jsp表单选择" id="jspFormTab" width="100%"  height="100%"  border="false" autoScroll="false">
			<next:GridPanel  id="jspFormGridPanel"  width="100%" height="100%" dataset="formDataset"     title="Jsp表单列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn  ></next:RadioBoxColumn>
					<next:Column id="formId" header="表单ID" field="formId" width="200" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="表单名称" field="formName" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="formDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:Panel>
</next:ViewPort>
</body>
<script language="javascript">
function init()
{
	var tabpanel = L5.getCmp("tabPanels");
	tabpanel.on("tabchange", loadJspFormTab);
}
var isInit = false;
function loadJspFormTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isInit == false){
		if(tab.id == "jspFormTab"){
			isInit = true;
			formDataset.load();
		}
	}
}
//查询
function query(){
  
  var processTypeName=document.getElementById("processTypeName").value;
  processTypeDataset.setParameter("TYPE_NAME@like",processTypeName);
  processTypeDataset.load();
}
function getSelect()
{
  var processTypeGridPanel=L5.getCmp('processTypeGridPanel');
  var processTypeSelected = processTypeGridPanel.getSelectionModel().getSelections();

  if ((processTypeSelected==null) ||(processTypeSelected=="")||processTypeSelected.length!=1)
   {
      alert("请选择一个流程类型!");
	  return false;
	}
  var jspFormGridPanel=L5.getCmp('jspFormGridPanel');
  var jspFormSelected = jspFormGridPanel.getSelectionModel().getSelections();

  if ((jspFormSelected==null) ||(jspFormSelected=="")||jspFormSelected.length!=1)
   {
      alert("请选择一个Jsp表单!");
	  return false;
	}
  return true;
}
 
function doConfirm(){
	if(!getSelect()) return;
	//流程类型
	var processTypeGridPanel=L5.getCmp('processTypeGridPanel');
    var processTypeSelected = processTypeGridPanel.getSelectionModel().getSelections();
    //jsp表单
	var jspFormGridPanel=L5.getCmp('jspFormGridPanel');
    var jspFormSelected = jspFormGridPanel.getSelectionModel().getSelections();

	 var result=new Array();
	 result[0]=processTypeSelected[0].get("typeId");
	 result[1]=jspFormSelected[0].get("formId");

	parent.returnValue = result;
	parent.close();
}

function doClose()
{
	parent.close();
    return true;
}
//查询条件面板打开合并函数
function collapse(element)
{
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
</html>