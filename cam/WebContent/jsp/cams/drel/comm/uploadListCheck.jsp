<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<model:datasets>
	<%--上传文件列表窗口--%>
	<model:dataset id="checkFileList" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
</model:datasets>
<!--上传文件列表-->
<next:Window id="win_checkFileList" closeAction="hide"  title="上传文件列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel width="566" stripeRows="true" height="269" dataset="checkFileList">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeCheckFileList"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="文件名" field="" width="220" editable="false" renderer="downloadFile"><next:TextField /></next:Column>
			<next:Column header="备注" width="200" field="remarks" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除文件" id="delCheckFileList" field="" width="80" editable="false" renderer="delCheckFileList"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="checkFileList" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!--上传文件列表-->
<next:Window id="winDetail_checkFileList" closeAction="hide"  title="上传文件列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel width="566" stripeRows="true" height="269" dataset="checkFileList">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeCheckFileList_detail"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="文件名" field="" width="300" editable="false" renderer="downloadFile"><next:TextField /></next:Column>
			<next:Column header="备注" width="200" field="remarks" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="checkFileList" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>

<script type="text/javascript">
//insert页面上传
function uploadCheckFile(fileType){
	if(applyId==''||applyId=='null'){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 600;
    var height = 146;
	var url="../../../comm/uploadCheck.jsp?applyId="+applyId+"&fileType="+fileType+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//打开文件列表窗口
function clickCheckFileList(applyId,fileType){
	checkFileList.setParameter("APPLY_ID",applyId);
	checkFileList.setParameter("FILE_TYPE",fileType);
	checkFileList.load();
	var win = L5.getCmp("win_checkFileList");
	win.show();
}
//打开文件列表窗口
function clickCheckFileList_detail(applyId,fileType){
	checkFileList.setParameter("APPLY_ID",applyId);
	checkFileList.setParameter("FILE_TYPE",fileType);
	checkFileList.load();
	var win = L5.getCmp("winDetail_checkFileList");
	win.show();
}
//链接删除
function delCheckFileList(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href=# onclick="clickDelCheckFileList(\'' + checkFileList.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除
function clickDelCheckFileList(index){
	var record= checkFileList.getAt(index);
	var fileType=record.get("fileType");
	L5.MessageBox.confirm('提示', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
			var delId=record.get("applyFileId");
			command.setParameter("delId", delId);
			command.execute("delete");				
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！',function(){
					checkFileList.setParameter("APPLY_ID",applyId);
					checkFileList.setParameter("FILE_TYPE",fileType);
					checkFileList.load();
					//删除成功的提示信息
					delCheckFileSuccess(fileType);	
				});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
function delCheckFileSuccess(fileType){
	if(fileType=="DC"){
		surveyFileDataset.setParameter("APPLY_ID",applyId);
		surveyFileDataset.setParameter("FILE_TYPE",fileType);
	 	surveyFileDataset.load();
	    surveyFileDataset.on("load",loadSurveyFileDs);
	}else if(fileType=="PY"){
		discussionFileDataset.setParameter("APPLY_ID",applyId);
		discussionFileDataset.setParameter("FILE_TYPE",fileType);
	 	discussionFileDataset.load();
	    discussionFileDataset.on("load",loadDiscussionFileDs);
	}else if(fileType=="GS"){
		noticeFileDataset.setParameter("APPLY_ID",applyId);
		noticeFileDataset.setParameter("FILE_TYPE",fileType);
	 	noticeFileDataset.load();
	    noticeFileDataset.on("load",loadNoticeFileDs);
	}
}
function loadSurveyFileDs(ds){	
	ds.un("load",loadSurveyFileDs);
	loadCheckFile(ds,"DC");
}
function loadDiscussionFileDs(ds){	
	ds.un("load",loadDiscussionFileDs);
	loadCheckFile(ds,"PY");
}
function loadNoticeFileDs(ds){	
	ds.un("load",loadNoticeFileDs);
	loadCheckFile(ds,"GS");
}
//关闭文件列表窗口
function closeCheckFileList(){
	var win = L5.getCmp("win_checkFileList");
	win.hide();
}
//关闭文件列表窗口
function closeCheckFileList_detail(){
	var win = L5.getCmp("winDetail_checkFileList");
	win.hide();
}

//insert页面删除
function clickDelCheckFile(applyFileId,fileType){
	L5.MessageBox.confirm('提示', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
			command.setParameter("delId", applyFileId);
			command.execute("delete");				
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！',function(){
					//删除成功的提示信息
					delCheckFileSuccess(fileType)
				});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//insert页面加载
function loadCheckFile(ds,fileType){
    var count=ds.getCount();
   	var fileName="";
   	var applyFileId="";
   	var fileNameHTML="";
   	var delHTML="";
    for(var i=0;i<count;i++){
    	var record=ds.getAt(i);
    	if(i>0){
    		fileName+="; ";
    		applyFileId+="; ";
    	}
    	fileName+=record.get("fileName"); 
    	applyFileId+=record.get("applyFileId");      	
    }
    if(fileName && count>1){
    	fileNameHTML='<a href=# onclick="clickCheckFileList(\'' + applyId+'\',\''+fileType+'\'' + ')">' + fileName + '</a>';
    	delHTML='<a href=# onclick="clickCheckFileList(\'' + applyId+'\',\''+fileType+'\'' + ')">' + '删除' + '</a>';
    }else if(fileName && count==1){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+applyFileId+"'";
    	fileNameHTML='<a id="download"  href='+url0+'>'+fileName+'</a>';
    	delHTML='<a href=# onclick="clickDelCheckFile(\'' + applyFileId + '\',\''+fileType+'\'' + ')">' + '删除' + '</a>';
    }else{
    	fileNameHTML="";
    	delHTML="";
    }
    if(fileType=="DC"){	
    	$("fileName_survey").innerHTML=fileNameHTML;
    	$("del_survey").innerHTML=delHTML;
    }else if(fileType=="PY"){	
    	$("fileName_discussion").innerHTML=fileNameHTML;
    	$("del_discussion").innerHTML=delHTML;
    }else if(fileType=="GS"){	
    	$("fileName_notice").innerHTML=fileNameHTML;
    	$("del_notice").innerHTML=delHTML;
    }
}
//detail页面加载
function loadCheckFile_detail(ds,fileType){
    var count=ds.getCount();
   	var fileName="";
   	var applyFileId="";
   	var fileNameHTML="";
    for(var i=0;i<count;i++){
    	var record=ds.getAt(i);
    	if(i>0){
    		fileName+="; ";
    		applyFileId+="; ";
    	}
    	fileName+=record.get("fileName"); 
    	applyFileId+=record.get("applyFileId");      	
    }
    if(fileName && count>1){
    	fileNameHTML='<a href=# onclick="clickCheckFileList_detail(\'' + applyId+'\',\''+fileType+'\'' + ')">' + fileName + '</a>';
    }else if(fileName && count==1){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+applyFileId+"'";
    	fileNameHTML='<a id="download"  href='+url0+'>'+fileName+'</a>';
    }else{
    	fileNameHTML="";
    }
    if(fileType=="DC"){	
    	$("fileName_survey").innerHTML=fileNameHTML;
    }else if(fileType=="PY"){	
    	$("fileName_discussion").innerHTML=fileNameHTML;
    }else if(fileType=="GS"){	
    	$("fileName_notice").innerHTML=fileNameHTML;
    }
}
//下载申请证明材料
function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("applyFileId");
	if(record.get('fileName')){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+record.get('fileName')+'</a>';
	}else{
		return '';
	}
}
</script>
