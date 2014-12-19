<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%@ page import="org.loushang.workflow.util.bsp.WfStru"%>

<html>
<head>
<title>委托查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>

<model:datasets>
	<model:dataset  pageSize="10" id="proxyProcDefDs" method="query"
		cmd="org.loushang.workflow.tripproxy.cmd.TripProxyProcDefQueryCmd" 
		global="true">
		<model:record>
			<model:field name="ID" type="string" />
			<model:field name="PROC_DEF_NAME" type="string" />
			<model:field name="PROC_DEF_ID" type="string" />
			<model:field name="ORIGINAL_ORGAN_NAME" type="string" />
			<model:field name="ORIGINAL_ORGAN_ID" type="string"/>
			<model:field name="PROXY_ORGAN_ID" type="string" />
			<model:field name="PROXY_ORGAN_NAME" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
   <next:BorderLayout>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Center>
	<next:Panel>
		<next:Panel width="100%" border="0"
			bodyStyle="padding-bottom:10px;padding-top:0px;">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this);" /> </legend>
				<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
				<form onsubmit="return false;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">流程名称：</td>
						<td class="FieldInput"><input type="text" id="procDefName"
							class="TextEditor" title="流程名称" /></td>						
						<td class="FieldButton" rowspan="2">
						<button onclick="query()">查询</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="proxyGridPanel" name="proxyGridPanel"
			anchor="100%" width="100%" height="100%" dataset="proxyProcDefDs"
			title="委托实现列表" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="设置委托" handler="setProxy" />				
				<next:ToolBarItem iconCls="edit" text="修改委托" handler="updateProxy" />
				<next:ToolBarItem iconCls="undo" text="取消委托" handler="deleteProxy" />
				<next:ToolBarItem iconCls="delete" text="全部取消" handler="cancleProxy" />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="id" header="内码" field="ID" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程定义Id" field="PROC_DEF_ID" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程名称" field="PROC_DEF_NAME" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="委托人" field="ORIGINAL_ORGAN_NAME" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="委托人组织内码" field="ORIGINAL_ORGAN_ID" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="代理人" field="PROXY_ORGAN_NAME" width="300">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="代理人组织内码" field="PROXY_ORGAN_ID" hidden="true" >
					<next:TextField allowBlank="false" />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
					displayInfo="true" dataset="proxyProcDefDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
//设置委托
function setProxy(){
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");
	var dialogMsg = "scroll:yes;status:no;dialogWidth:470px;dialogHeight:450px";
	var url=L5.webPath+"/jsp/workflow/tripproxy/dialog/processtripproxyforinsert.jsp";
	var win = showModalDialog(url,window,dialogMsg); //弹出框
	proxyProcDefDs.reload();
}
//取消委托
function cancleProxy(){
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");
	if(proxyProcDefDs.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有可取消的记录!');
		return;
	}
	var proxyGridPanel = L5.getCmp('proxyGridPanel');
	var leng = proxyProcDefDs.getCount();
	
	var proxyOrganIds=[];
	var records=proxyProcDefDs.getAllRecords();
	for(var i=0;i<leng;i++){
		proxyOrganIds[i]=records[i].get("PROXY_ORGAN_ID");		
	}
	L5.MessageBox.confirm("消息提示", "此操作将取消所有委托，确定要取消吗?",
			function(sta){
				if(sta =='yes'){
	var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyProcDefCmd");
	command.setParameter("proxyOrganIds",proxyOrganIds);
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("消息提示","取消成功");
			proxyProcDefDs.reload();
		}else {
			L5.Msg.alert("错误:", command.error);
		}
		}
	command.execute("delete");}});
	
}
//修改委托
function updateProxy(){
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");
	if(proxyProcDefDs.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要修改的记录!');
		return;
	}
	var proxyGridPanel = L5.getCmp('proxyGridPanel');
	var selected = proxyGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng!=1){
		L5.MessageBox.alert("消息提示",'请选择一条要更新的记录!');
		return;
	}
	var procDefId=selected[0].get("PROC_DEF_ID");
	var id=selected[0].get("ID");
	var oldProxyOrganId=selected[0].get("PROXY_ORGAN_ID");
	var url="jsp/workflow/tripproxy/processtripproxyforupdate.jsp?procDefId="+procDefId+"&&id="+id+"&&oldProxyOrganId="+oldProxyOrganId;
	L5.forward(url,"修改委托");
	
}

//删除委托
function deleteProxy(){
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");
	if(proxyProcDefDs.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要取消的记录!');
		return;
	}
	var proxyGridPanel = L5.getCmp('proxyGridPanel');
	var selected = proxyGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	
	if(leng<1){
		L5.MessageBox.alert("消息提示",'请至少选择一条要取消的记录!');
		return;
	}
	var proxyIds=[];
	var ids=[];
	for(var index=0;index<leng;index++){		
		proxyIds[index]=selected[index].get("PROXY_ORGAN_ID");	
		ids[index]=selected[index].get("ID");	
	}
	
	L5.MessageBox.confirm("消息提示", "确定要取消所选委托吗?",
		function(state){
	      if(state=='yes'){
	    	  var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyProcDefCmd");
	    	  command.setParameter("proxyIds",proxyIds);
	    	  command.setParameter("ids",ids);
	    	  command.setParameter("records",selected);
	    	  command.execute("deleteByProcDefId");
	    	  if(!command.error){
	    		  L5.MessageBox.alert("消息提示",'取消成功!');
	    		  for(var index=0;index<leng;index++){
	    			  proxyProcDefDs.remove(selected[index]);		
	    			}
		      }else{
		    	  L5.MessageBox.alert("错误",command.error);
			  }
		  }else{
			  return false;
	      }
		}
	);
	
}
function init(){
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");
	proxyProcDefDs.load();
}
//查询
function query(){
	var processDefName=document.getElementById("procDefName").value;
	if(processDefName.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
	var proxyProcDefDs=L5.DatasetMgr.lookup("proxyProcDefDs");	
	proxyProcDefDs.setParameter("PROC_DEF_NAME@like",processDefName);
	proxyProcDefDs.load();
}

 //查询条件面板打开合并函数
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
</html>