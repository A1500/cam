function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("sort","CREATE_TIME");
	somPartyDS.setParameter("dir", "desc");
	somPartyDS.load();
    //做权限限制 
	somPartyDS.on('load',function(){
		somPartyDS.filterBy(function(record, id){
			if(record.get('morgArea') == morgArea){
				return record;
			}
		});
	});
	var partyUpLoadDataSet=L5.DatasetMgr.lookup("partyUpLoadDataSet");
	partyUpLoadDataSet.newRecord();
}
function onLoad(){
    var url = L5.webPath + "/fileDownload?filePath=jsp/cams/sorg/manage/party/partyCheck.xls&fileName=partyCheck.xls&project=1";
    window.location = url;
}
function forImport(){
	var win = L5.getCmp("importExcelWin");
	win.show();
	document.getElementById("upLoadFileForm").reset();
}
//点击导入Excel文件
function click_import(){
	//首先校验选择文件
	var files = document.forms[0].uploadFile;
	if(files.value == " " || files.value == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件！");
		return;
	}
	if(files.value.lastIndexOf(".xls") == -1){
		L5.MessageBox.alert("提示", "请选择文件格式为*.xls的文件！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyHisImportCmd");
	var partyUpLoadDataSet = L5.DatasetMgr.lookup("partyUpLoadDataSet");
	var record = partyUpLoadDataSet.getCurrent();
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord", record);
    command.afterExecute=function(){
            	  if (!command.error) {
            	  	var sucCount=command.getReturn("sucCount");//成功导入条数
            	  	var sumCount=command.getReturn("sumCount");//总记录数
            	  	var existCount=command.getReturn("existCount");//已经存在于数据库中的记录条数
            	  	var errorList=command.getReturn("errorList");
            	  	L5.MessageBox.confirm('确定', "总记录数"+sumCount+"条,已存在"+existCount+"条,<br>成功导入"+sucCount+"条,是否显示错误信息列表",function(sta){
						if(sta=="yes"){
							var win = L5.getCmp("importExcelWin");
							win.hide();
							var importListWin = L5.getCmp("importListWin");
							importListWin.show();
							var errorListArray=errorList.split(";");
							var table = document.getElementById("errorList");
							for(var j=table.rows.length;j>1;j--){
								table.deleteRow(j-1);
							}
							for(var i=0;i<errorListArray.length-1;i++){
								var newRow = table.insertRow(table.rows.length);
								var newCel1 = newRow.insertCell(0);
								var newCel2 = newRow.insertCell(1);
								newCel1.innerHTML = i+1;
								newCel1.align="center";
								newCel1.style.font="normal 12px tahoma, arial, helvetica, sans-serif";
								newCel2.innerHTML = errorListArray[i];
								newCel2.style.font="normal 12px tahoma, arial, helvetica, sans-serif";
							}
	              			var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	              			somPartyDS.setParameter("sort","CREATE_TIME");
							somPartyDS.setParameter("dir", "desc");
							somPartyDS.load();
						}else {
							var win = L5.getCmp("importExcelWin");
							win.hide();
							var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	              			somPartyDS.setParameter("sort","CREATE_TIME");
							somPartyDS.setParameter("dir", "desc");
							somPartyDS.load();
						}
					});		
          		}else{
          			L5.Msg.alert("错误:", command.error);
          		}
    }
    command.execute("importPartyHisExcel");
}
//点击导入窗口关闭
function click_close(){
	var win = L5.getCmp("importExcelWin");
	win.hide();
}
function closeListWin(){
	var importListWin = L5.getCmp("importListWin");
	importListWin.hide();
}
//修改
function updateParty(){
	var somParty=L5.getCmp("somPartyGrid");
	var records=somParty.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行修改！");
		return;
	}
	var data=new L5.Map();
	data.put("partyId",records[0].get("partyId"));
	data.put("sorgId",records[0].get("sorgId"));
	var url="jsp/cams/sorg/manage/party/somPartyHisEdit.jsp";
	var text="党建信息修改";
	L5.forward(url,text,data);
}