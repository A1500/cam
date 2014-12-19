<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<model:datasets>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>
</model:datasets>

<!-- 上传附件列表 -->
<next:Window id="uploadList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true"modal="true">
	<next:GridPanel id="uploadListGrid" width="566" stripeRows="true" height="269" dataset="winElectronicDataSet" notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="浏览文件上传附件" handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="电子扫描上传附件" handler="addUploadFileEquipment"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称" width="220" field="fileName" editable="false"/>
			<next:Column header="附件描述" width="200" field="fileMess" editable="false"/>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
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
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<!-- 下载附件窗口 -->
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="740"modal="true">
	<next:GridPanel id="downloadGrid" width="727" stripeRows="true" height="369" dataset="downloadDataSet" notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="证明材料目录"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect"/>
			<next:Column header="附件名称" field="fileName" width="190" editable="false" renderer="winDownloadHref"/>
			<next:Column header="附件描述" field="fileMess" width="190" editable="false"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</next:Window>	

<script type="text/javascript">
//电子档案列表初始化加载
function mrmElectronicDataSet_load(){
	mrmElectronicDataSet.setParameter("deptId",deptId);
	mrmElectronicDataSet.setParameter("applyId",applyId);
	mrmElectronicDataSet.setParameter("upCatalogCode","1");
	mrmElectronicDataSet.setParameter("catalogCode","8a898b8b3c653964013c6567447d0005");
	mrmElectronicDataSet.load();
}

function mrmElectronicDataSet_load1(){
	mrmElectronicDataSet.setParameter("deptId",deptId);
	mrmElectronicDataSet.setParameter("applyId",appId);
	mrmElectronicDataSet.setParameter("upCatalogCode","1");
	mrmElectronicDataSet.setParameter("catalogCode","8a898b8b3c653964013c6567447d0005");
	mrmElectronicDataSet.load();
	
}
//打开上传窗口后电子档案列表加载
function winElectronicDataSet_load(){
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	
	var deptIdSelected = selected[0].get("deptId");
	var applyIdSelected = selected[0].get("applyId");
	var applyTypeSelected = selected[0].get("applyType");
	var catalogCodeSelect = selected[0].get("catalogCode");
	var electronicIds = selected[0].get("electronicId");
	winElectronicDataSet.setParameter("deptId",deptIdSelected);
	winElectronicDataSet.setParameter("applyId",applyIdSelected);
	winElectronicDataSet.setParameter("applyType",applyTypeSelected);
	winElectronicDataSet.setParameter("catalogCode",catalogCodeSelect);
	winElectronicDataSet.setParameter("electronicIds",electronicIds);
    
	winElectronicDataSet.load();
}
//附件窗口点击上传
function click_upload(){
	if(_$("fileMess").length>250){
		L5.Msg.alert('提示',"附件描述不能超过250个字符!");
		return false;
	}
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmElectronicCmd");
	record.set("deptId",deptId);
	if(method=="INSERT"){
		record.set("applyId",appId);
	}
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
			winElectronicDataSet_load();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function close_upload(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
//弹出上传附件窗口
function uploadFile(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	winElectronicDataSet_load();
	var win=L5.getCmp("uploadList");
	win.show();
}
//关闭附件列表窗口
function closeUploadFile(){
	var win = L5.getCmp("uploadList");
	win.hide();
}
//增加上传附件
function addUploadFile(){
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	var fileCodeSelect = selected[0].get("fileCode");
	var win=L5.getCmp("uploadWin");
	win.show();	
}
//电子档案上传窗口关闭事件
function uploadListCloseEvent(){
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			if(method=="INSERT"){
				mrmElectronicDataSet_load1();
			}else{
				mrmElectronicDataSet_load();
				
			}
		});	
	}	
}
//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDelete(\'' + winElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除附件
function clickDelete(index){
	var record= winElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var electronicId = record.get("electronicId");
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmElectronicCmd");
			command.setParameter("electronicId",electronicId);
			command.execute("delElectronic");
			if (!command.error) {
				winElectronicDataSet_load();	
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
//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=mrm_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownload(\'' + mrmElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}
//打开下载多个附件窗口
function clickDownload(index){
    var record= mrmElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("electronicId");
    var url0=paths[0]+'/'+paths[1]+"/download?table=mrm_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
//关闭下载窗口
function winClosedownload(){
	var win = L5.getCmp("downloadWin");
	win.hide();
}
var uploadRecord="";//供弹出的文拍仪扫描页面调用
function addUploadFileEquipment(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	uploadRecord=selected[0];
	uploadRecord.set("deptId",deptId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=normal";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
	
}
//供文拍仪弹出窗口调用
function uploadWinHide(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
function winElectronicDataSetload(){
	winElectronicDataSet_load();
}

function getUploadRecord(){
	return uploadRecord;
}
function addUploadFileForArchiveEquipment(){
	var uploadListGrid2 = L5.getCmp("uploadListGrid2");
	var selected= uploadListGrid2.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.Msg.alert('提示',"请先选择人员!");
		return false;
	}
	uploadRecord=selected[0];
	uploadRecord.set("deptId",deptId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=normal";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);	
}
</script>
