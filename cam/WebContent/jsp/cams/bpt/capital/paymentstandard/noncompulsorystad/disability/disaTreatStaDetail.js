var x;
function init() {
	var ds = L5.DatasetMgr.lookup("ds");	
	ds.setParameter("STANDARDS_COUNTIES",organCode);
	ds.setParameter("START_DATE",startDate);
	ds.setParameter("TYPE","91");
	ds.load();
	ds.on("load",function(){
		document.getElementById("startDate").disabled = true;
		document.getElementById("dateSelect").disabled = true;
		if(ds.getCount()>0){ //加载时计算出年合计
			var records = ds.getAllRecords();
			var subTotal = [];
			var yearTotal = [];
			for(var j=0;j<records.length;j++){
				yearTotal[j]=  parseFloat((records[j].get("provinceStandard")=='')?'0':records[j].get("provinceStandard"))+
							   parseFloat((records[j].get("oldLonelyMon")=='')?'0':records[j].get("oldLonelyMon"))+
							   parseFloat((records[j].get("otherSubsidyOne")=='')?'0':records[j].get("otherSubsidyOne"))+
							   parseFloat((records[j].get("otherSubsidyTwo")=='')?'0':records[j].get("otherSubsidyTwo"))+
							   parseFloat((records[j].get("otherSubsidyThree")=='')?'0':records[j].get("otherSubsidyThree"))+
							   parseFloat((records[j].get("otherSubsidyFour")=='')?'0':records[j].get("otherSubsidyFour"))+
							   parseFloat((records[j].get("otherSubsidyFive")=='')?'0':records[j].get("otherSubsidyFive"));
				records[j].set("yearTotal",yearTotal[j]);
			}
			var startDate = records[0].get("startDate");
			document.getElementById("startDate").value = startDate;
		}
	});
	initFav();
	L5.QuickTips.init();
};

function initFav(){
  x = new L5.ux.ItemSelector({
		field:"disabilityLevel",
		applyTo:"favordiv",
		id:"disabilityLevelSelectId",
		name:"disabilityLevelSelectName",
		dataFields:["value","text"],
		fromData:[['01','一级'],['02','二级'],['03','三级'],['04','四级'],['05','五级'],['06','六级'],['07','七级'],['08','八级'],['09','九级'],['10','十级']],
		valueField :"value",
		displayField:"text",
	    msWidth:109,
	    msHeight:220
	    });
}

//初始化双边栏
function disa_level_render(values){
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return "";
		}
		values = values.split(',');
	}
	//根据id显示名称
	for (var i=0; i<values.length; i++){
		for(var j=0;j<x.fromData.length;j++){
			var y = x.fromData[j];
			if(y[0]==values[i]){
				var nameArray = y[1];
				if(nameArray){
					texts.push(nameArray);
				}
			}
		}
	}
	return texts.join(",");
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function reset() {
	window.history.go(-1);
}
