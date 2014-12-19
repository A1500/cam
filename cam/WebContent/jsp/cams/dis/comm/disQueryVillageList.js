function init() {
	if(organCode.substring(2,12)=="0000000000"){	
	}else if(organCode.substring(4,12)=="00000000"){	
	}else if(organCode.substring(6,12)=="000000"){
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and is_self='0' and substr(id,1,6) like '" + organCode.substring(0, 6) + "'");
	    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
	}else{
		var organArea=organCode.substring(0,9)+"000";
		DmXzqhDataSetStreet.setParameter("filterSql", "leve='3' and is_self='0' and id= '" + organArea + "'");
		DmXzqhDataSetStreet.load();
		DmXzqhDataSetStreet.on('load',function(){
			document.getElementById("dzZhenquery").value=organArea;
			document.getElementById("dzZhenquery").setAttribute("disabled","true");
		});
		DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and is_self='0' and substr(id,1,9) like '" + organCode.substring(0, 9) + "'");
	    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
	}
	
}
function forExcel() {
	var dataset=L5.DatasetMgr.lookup("villageds");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/comm/disQueryVillageExcel.jsp");
}
function getDzCun() {
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and is_self='0' and substr(id,1,9) like '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}

function query(){
	var villageds=L5.DatasetMgr.lookup("villageds");
	var dzZhenquery=document.getElementById("dzZhenquery").value;//获得乡镇的编码
	var dzCunquery=document.getElementById("dzCunquery").value;//获得村居的编码
	if((dzZhenquery==null||dzZhenquery=="")&&(dzCunquery==null||dzCunquery=="")){
		L5.Msg.alert("提示", "请至少选择一个查询条件！");
		return;
	}
	if(dzCunquery==null||dzCunquery==""){
		villageds.setParameter("ID@like",dzZhenquery.substr(0,9));
	}else{
		villageds.setParameter("ID@=",dzCunquery);
	}
	villageds.setParameter("IS_SELF@=","0");
	villageds.setParameter("LEVE@=","4");
	villageds.setParameter("sort","id");	
	villageds.setParameter("dir","asc");
	villageds.load();
}