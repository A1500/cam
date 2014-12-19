function returnQueryMain(){
	var text="";
	var url='jsp/cams/sorg/query/som/somQueryMain.jsp';
	L5.forward(url,text);
}

function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("somOrganDataset");
	return '<a href="javascript:jtxxDetail(\'' + ds.indexOf(record) + '\')">' + value + '</a>';
}
//超级链接所调用的方法
 function jtxxDetail(index){
   	var ds=L5.DatasetMgr.lookup("somOrganDataset");
   	var record= ds.getAt(index);
   	var sorgId=record.get('sorgId');
   	alert(sorgId);
   	var sorgType=record.get('sorgType');
   	alert(sorgType);
	//TODO	
	var text='';
	var url='jsp/cams/sorg/query/som/somQuery.jsp?sorgId='+sorgId;
	L5.forward(url,text);
 }