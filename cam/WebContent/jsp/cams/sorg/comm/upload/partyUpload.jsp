<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<!-- 上传附件窗口 -->
<next:Window id="uploadWin_praise" closeAction="hide" title="上传附件" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload_praise"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload_praise"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content_praise" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files_praise" name="files" style="width:95%;height:40"/></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<script type="text/javascript">
function uploadFile_praise(){	
	var uploadGrid=L5.getCmp('partyPraiseGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请先选择一条记录!");
		return;
	}
	var win=L5.getCmp("uploadWin_praise");
	win.show();
}
//附件窗口点击上传
function click_upload_praise(){
	if(_$("files_praise")=="" || _$("files_praise")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('partyPraiseGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
	command.setParameter("uploadRd",record);
	command.setForm("form_content_praise");
	command.execute("uploadSave_praise");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadWin_praise");
				win.hide();
				if(!record.get('praiseId')){
					record.set('praiseId',command.getReturn('praiseId'));
				}
				record.set('fileName',command.getReturn('fileName'));
			});
		}
		else{
	        L5.Msg.alert("提示","出现系统异常，"+command.error);
        }
	}
}
function close_upload_praise(){
	var win=L5.getCmp("uploadWin_praise");
	win.hide();
}
function download_praise(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("praiseId");
	if(record.get('fileName')){
	    var url0=paths[0]+'/'+paths[1]+"/download?table=som_party_praise&column=files&pk=praise_id&filename=file_name&praise_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+'点击下载'+'</a>';
	}else{
		return '';
	}
}
</script>


<!-- 上传附件窗口 -->
<next:Window id="uploadWin_change" closeAction="hide" title="上传附件" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload_change"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload_change"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content_change" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files_change" name="files" style="width:95%;height:40"/></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<script type="text/javascript">
function uploadFile_change(){	
	var uploadGrid=L5.getCmp('partyChangeGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请先选择一条记录!");
		return;
	}
	var win=L5.getCmp("uploadWin_change");
	win.show();
}
//附件窗口点击上传
function click_upload_change(){
	if(_$("files_change")=="" || _$("files_change")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('partyChangeGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
	command.setParameter("uploadRd",record);
	command.setForm("form_content_change");
	command.execute("uploadSave_change");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadWin_change");
				win.hide();
				if(!record.get('changeId')){
					record.set('changeId',command.getReturn('changeId'));
				}
				record.set('auditFile',command.getReturn('auditFile'));
			});
		}
		else{
	        L5.Msg.alert("提示","出现系统异常，"+command.error);
        }
	}
}
function close_upload_change(){
	var win=L5.getCmp("uploadWin_change");
	win.hide();
}
function download_change(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("changeId");
	if(record.get('auditFile')){
	    var url0=paths[0]+'/'+paths[1]+"/download?table=som_party_change&column=files&pk=change_id&filename=audit_file&change_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+'点击下载'+'</a>';
	}else{
		return '';
	}
}
</script>

