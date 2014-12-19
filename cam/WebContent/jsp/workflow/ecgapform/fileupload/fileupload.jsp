<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>

<HTML>
<HEAD>
<%
  String files=request.getParameter("files");
  files=java.net.URLDecoder.decode(files,"UTF-8");
%>
<TITLE>文件上传</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset id="fileUpLoadDataset"
		cmd="org.loushang.workflow.ecgapform.fileupload.cmd.WorkflowUploadCmd" global="true">
		<model:record
			fromBean="org.loushang.workflow.ecgapform.fileupload.data.FormFileUpload"></model:record>
	</model:dataset>
	<model:dataset id="filesDataset"
	   global="true" >
		<model:record >
			<model:field name="fileId" type="string"></model:field>
			<model:field name="fileName"  type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>	
				<table width="100%" border="0">
					<form id="fileUploadForm" method="post" onsubmit="return false" name="fileUploadForm" 
						class="L5form" enctype="multipart/form-data" dataset="fileUpLoadDataset">
						<tr>
							<td class="FieldLabel" width="25%" style="text-align:center">请选择要上传的文件<font style="color:red">(最大5M)</font>:</td>
							<td class="FieldInput" width="55%"><input type="file"
								id="uploadFile" name="uploadFile" style ="width:250"/></td>
							<td style="width:15%" rowspan="2"><button onclick="uploadFile1()">上传</button> </td>
						</tr>
					</form>
				</table>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="filesGridPanel" width="100%" height="100%" dataset="filesDataset" title="已上传文件信息" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="primaryKey" header="内码" field="fileId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="已上传文件名称" field="fileName" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="下载" handler="download"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="deletefile"/>
					<next:ToolBarItem iconCls="undo"  text="关闭" handler="doClose"/>
				</next:TopBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript">
//初始化
var files='<%=files%>';
//隐藏域ID
var hiddenFiledId='<%=request.getParameter("hiddenFiledId")%>';

//文本域ID
var textfiledId = "Input_" + hiddenFiledId;


var isIE = (document.all) ? true : false;
//为每个实例创建不同的iframe
var frameName = "downloadFrame";
//ie不能修改iframe的name
var oFrame = isIE ? document.createElement("<iframe name=\"" + frameName + "\">") : document.createElement("iframe");
//为ff设置name
oFrame.name = frameName;
oFrame.style.display = "none";
//在ie文档未加载完用appendChild会报错
document.body.insertBefore(oFrame, document.body.childNodes[0]);

function init(){
	fileUpLoadDataset.newRecord();

	if(files != null && files !=""){
		var fs = files.split(";");
		var ds=L5.DatasetMgr.lookup("filesDataset");
		for(var i=0;i<fs.length;i++){
			
			ds.newRecord();
			var record = ds.getCurrent();
			var file = fs[i].split("|");
			record.set("fileId",file[0]);
			record.set("fileName",file[1]);
		}
		ds.commitChanges();
	}
}


function uploadFile1()
{
	
	var readyUploadFile=document.getElementById("uploadFile").value;
	if(readyUploadFile==""){
		L5.Msg.alert("提示:","请选择要上传的文件!");
		return ;
	}
	var command=new L5.Command("org.loushang.workflow.ecgapform.fileupload.cmd.WorkflowUploadCmd"); 
	command.setForm(L5.getDom("fileUploadForm"));
	var record=fileUpLoadDataset.getCurrent();
	command.setParameter("formFileUploadRecord",record);
	command.afterExecute=function(){
	    if (!command.error) {
	        var upLoadedFileInfo = command.getReturn("upLoadedFileInfo");
	        var info = upLoadedFileInfo.split("|");
	        var returnFileId = info[0];
	        var returnFileName = info[1];
	        L5.Msg.alert("提示:",returnFileName+" 上传成功!");

	        if(files != null && files !="null" && files !=""){
	        	files = files + ";" + upLoadedFileInfo;
			}else{
				files = upLoadedFileInfo;
			}

	        
			//修改父页面隐藏域信息
			window.dialogArguments.document.getElementById(hiddenFiledId).value=files;
			//修改父页面文本域信息
			window.dialogArguments.document.getElementById(textfiledId).value="附件已上传";
			
			//增加显示记录
			var ds=L5.DatasetMgr.lookup("filesDataset");
			var record = ds.newRecord();
			//var record = ds.getCurrent();
			record.set("fileId",returnFileId);
			record.set("fileName",returnFileName);
			ds.commitChanges();
		}else{
			L5.Msg.alert("错误:",command.error);
		}
    }
    command.execute("upload");
   
}

function download(){
	if(!getSelect()) return;

	var filesGrid=L5.getCmp('filesGridPanel');
    var selected = filesGrid.getSelectionModel().getSelections();
	var uuid = selected[0].get("fileId");
	
	var command = "org.loushang.workflow.ecgapform.fileupload.cmd.FileDownloadCmd";
	var method = "execute";
	var url = L5.webPath + "/command/dispatcher/";
	url += command+"/";
	url += method+"?";
	url += "uuid="+ uuid + "&isopendirect=false&usemime=true";
	
	document.getElementById(frameName).src = url;

}

function deletefile(){
	if(!getSelect()) return;
	var filesGrid=L5.getCmp('filesGridPanel');
    var selected = filesGrid.getSelectionModel().getSelections();

	var rt = confirm("确定要删除["+ selected[0].get("fileName") +"]?");
	if(rt != true){
		return false;
	}
	
    var uuid = selected[0].get("fileId");
    var command=new L5.Command("org.loushang.workflow.ecgapform.fileupload.cmd.WorkflowUploadCmd"); 
	command.setParameter("uuid",uuid);
	command.afterExecute=function(){
	    if (!command.error) {
	        
	    	//构建新的父页面隐藏域信息
			var fs = files.split(";");
			var newFiles = "";
			for(var i=0;i<fs.length;i++)
			{
				var result = fs[i].split("|");
				if(result[0] != uuid)
				{
					if(newFiles == ""){
						newFiles = fs[i];
					}else{
						newFiles = newFiles +";"+ fs[i];
					}
				}
			}
			files = newFiles;
			
			
			//修改父页面隐藏域信息
			window.dialogArguments.document.getElementById(hiddenFiledId).value=files;
			
			//修改父页面文本域信息
			if(files==null || files==""){
				window.dialogArguments.document.getElementById(textfiledId).value="附件未上传";
			}
			
			
			//修改显示记录
			var ds=L5.DatasetMgr.lookup("filesDataset");
			ds.remove(selected[0]);
			ds.commitChanges();

			var returnFileName = selected[0].get("fileName");
			L5.Msg.alert("提示:",returnFileName+" 删除成功!");
		
			
		}else{
			L5.Msg.alert("错误:",command.error);
		}
    }
    command.execute("delete");
    
}

function doClose(){
	parent.close();
}

function getSelect(){
  var filesGrid=L5.getCmp('filesGridPanel');
  var selected = filesGrid.getSelectionModel().getSelections();
  if(selected.length == 0){
	  L5.Msg.alert("提示:","请选择要处理的文件!");
    return false;
  }
  return true;
}

</script>
</html>
