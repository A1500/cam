<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.next.upload.MultipartRequestHandler"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"ISFile.js") %>'></script>
<script type="text/javascript">
var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
var applyType = '<%=StrUtil.n2b(request.getParameter("applyType"))%>';
var taskCode = '<%=StrUtil.n2b(request.getParameter("taskCode"))%>';
//初始化
function init(){
	somElectronicDataSet_load();
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
}
function somElectronicDataSet_load(){
	somElectronicDataSet.setParameter("sorgId",sorgId);
	somElectronicDataSet.setParameter("applyType",applyType);
	somElectronicDataSet.setParameter("taskCode",taskCode);
	somElectronicDataSet.load();
}
function winElectronicDataSet_load(catalogCode){
	winElectronicDataSet.setParameter("SORG_ID@=",sorgId);
	winElectronicDataSet.setParameter("TASK_CODE@=",taskCode);
	winElectronicDataSet.setParameter("APPLY_TYPE@=",applyType);
	winElectronicDataSet.setParameter("CATALOG_CODE@=",catalogCode);
	winElectronicDataSet.setParameter("IF_VALID@=","1");
	winElectronicDataSet.load();
}
//附件窗口点击上传
function click_upload(){
	if(isExceedMaxSize(_$("files"),5*1024*1024)){
		L5.Msg.alert('提示',"选择的文件过大，不能上传!");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("fileMess",_$("fileMess"));
	command.setParameter("uploadRd",record);
	command.setForm("form_content");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadWin");
				win.hide();
			});
			winElectronicDataSet_load(record.get("catalogCode"));
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}


//弹出上传附件窗口
function uploadFile(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	var record=selected[0];
	var catalogCode = record.get("catalogCode");
	winElectronicDataSet_load(catalogCode);
	var win=L5.getCmp("uploadList");
	win.show();
}
//增加上传附件
function addUploadFile(){
	var win=L5.getCmp("uploadWin");
	win.show();
	
}
//删除附件
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDelete(\'' + winElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
function clickDelete(index){
	var record= winElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var electronicId = record.get("electronicId");
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("electronicId",electronicId);
			command.execute("delElectronic");
			if (!command.error) {
				var uploadGrid=L5.getCmp('uploadGrid');
				var selected=uploadGrid.getSelectionModel().getSelected();
				winElectronicDataSet_load(selected.get("catalogCode"));	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
	
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel>
	<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" width="40%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
			<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述"    field="fileMess" width="30%" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
   		<hidden name ="<%=MultipartRequestHandler.MAX_LENGTH_EXCEEDED_KEY%>" value = "250M" </hidden> 
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="fileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过5M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<next:Window id="uploadList" closeAction="hide" title="附件上传列表" width="580" height="300" autoScroll="true">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true" height="88%" dataset="winElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  width="18%" field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="18%" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="15%" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>