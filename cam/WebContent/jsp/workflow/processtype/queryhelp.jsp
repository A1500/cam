<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<HTML>
<HEAD>
<TITLE>流程类型查询</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset pageSize="10" id="processTypeDataset" cmd="org.loushang.workflow.processtype.cmd.ProcessTypeQueryCmd" autoLoad="false" global="true">
		<model:record  fromBean="org.loushang.workflow.processtype.data.ProcessType"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
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
			<next:GridPanel id="userGridPanel" width="100%" height="100%" dataset="processTypeDataset"     title="流程类型详细信息" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn  ></next:RadioBoxColumn>
					<next:Column id="primaryKey" header="内码" field="typeId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型名称" field="typeName" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型描述" field="description"  width="100%" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="确定" handler="doConfirm"/>
					<next:ToolBarItem iconCls="delete"  text="关闭" handler="doClose"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="processTypeDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript">
//初始化
function init(){
	var processType='<%=request.getParameter("processType")%>';
	processTypeDataset.on("load",function(){
		var index=processTypeDataset.indexOfId(processType);
		var userGrid=L5.getCmp('userGridPanel');
		userGrid.getSelectionModel().selectRow(index);
		});
	processTypeDataset.load();
	//定义双击事件
	var grid=L5.getCmp('userGridPanel');
	grid.on("rowdblclick",doConfirm);
}

//查询
function query(){
  
  var processTypeName=document.getElementById("processTypeName").value;
  processTypeDataset.setParameter("TYPE_NAME@like",processTypeName);
  processTypeDataset.load();
}

function doConfirm(){
	if(!getSelect()) return;
	var userGrid=L5.getCmp('userGridPanel');
    var selected = userGrid.getSelectionModel().getSelections();
	var result=new Array();
	 
	 result[0]=selected[0].get("typeId");
	 result[1]=selected[0].get("typeName");
	
	parent.returnValue = result;
	parent.close();
}
function doClose(){
	parent.close();
}
function getSelect(){
  var userGrid=L5.getCmp('userGridPanel');
  var selected = userGrid.getSelectionModel().getSelections();
  if(selected.length!=1){
    alert("请选择一行");
    return false;
  }
  if(selected.length>1){
    alert("请选择一行");
    return false;
  }  
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
