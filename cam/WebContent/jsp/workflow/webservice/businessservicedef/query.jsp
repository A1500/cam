<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>业务Web服务查询</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="businessServiceDataset" cmd="org.loushang.workflow.webservice.serviceadmin.businessservice.cmd.BusinessServiceDefQueryCmd" autoLoad="true">
		<model:record fromBean="org.loushang.workflow.webservice.serviceadmin.businessservice.data.BusinessDefServiceRef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:AnchorLayout>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;"  class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel" width="15%">服务名称：</td>
									<td class="FieldInput"><input type="text"  id="businessServiceName" class="TextEditor" title="服务名称"  size="40"/></td>
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="businessServiceGridPanel" name="businessServiceGridPanel" anchor="100%" height="100%" dataset="businessServiceDataset"     title="业务Web服务列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="serviceDefId" header="服务定义Id" field="serviceDefId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="服务名称" field="serviceDefName" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="服务地址" field="description" width="300" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="导入时间" field="createTime" width="120" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="导入" handler="importWsdl"/>
					<next:ToolBarItem iconCls="select"  text="覆盖导入" handler="overrideImportWsdl"/>
					<next:ToolBarItem iconCls="detail"  text="明细" handler="detailWsdl"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="deleteWsdl"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="businessServiceDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
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

			//业务Web服务查询
			 function query(){
			 	var businessServiceDataset = L5.DatasetMgr.lookup("businessServiceDataset");
			 	var businessServiceName=document.getElementById("businessServiceName").value;
			 	if(businessServiceName.indexOf("'")!=-1){
					  L5.Msg.alert("提示", "不接受单引号输入!");
					  return;
				}			 	
			 	if(businessServiceName!=null&&businessServiceName!=""){
			 		businessServiceDataset.setParameter("WF_BUSINESS_SERVICE_NAME",businessServiceName);
			 	}
			 	businessServiceDataset.load();
			 }

			 //导入
			 function importWsdl()
			 {
				 var url="jsp/workflow/webservice/businessservicedef/forimport.jsp";
				 L5.forward(url,"业务Web服务导入");
			 }
			 //覆盖导入
			 function overrideImportWsdl()
			 {
				var userGrid=L5.getCmp('businessServiceGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					alert("请选择一条记录进行处理!");
					return false;
				}
				var rec=selected[0];
				var url="jsp/workflow/webservice/businessservicedef/forimport.jsp";
				url=url+"?serviceDefId="+rec.get("serviceDefId");
				L5.forward(url,"业务Web服务覆盖导入");
			 }
			 //明细
			 function detailWsdl()
			 {
				var userGrid=L5.getCmp('businessServiceGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					alert("请选择一条记录进行处理!");
					return false;
				}
				var rec=selected[0];
				var url="command/dispatcher/org.loushang.workflow.webservice.serviceadmin.businessservice.cmd.BusinessServiceDefDetailCmd/detail";
				url=url+"?primaryKey="+rec.get("serviceDefId");
				L5.forward(url,"业务Web服务明细");
			 }
			 //删除
			 function deleteWsdl()
			 {
				var businessServiceDataSet = L5.DatasetMgr.lookup("businessServiceDataset");	
				var userGrid=L5.getCmp('businessServiceGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length<1){
					alert("请选择一条记录进行处理!");
					return false;
				}
				L5.MessageBox.confirm('确定','确定要删除选中的记录吗?',function(state){
					if(state=="yes"){
					var command=new L5.Command("org.loushang.workflow.webservice.serviceadmin.businessservice.cmd.BusinessServiceDefCmd");
					command.setParameter("wsdlRecords",selected);
					command.execute("delete");
					if(!command.error){
						//刷新数据源
						userGrid.getSelectionModel().clearSelections();
						businessServiceDataSet.reload();
						L5.Msg.alert("提示：","删除操作完成");
					}else{
						L5.Msg.alert("提示：",command.error);
						return;
						}
					}else{
					return false;
						}
					});
			 }
		</script>
</html>