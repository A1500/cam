//章程和会费标准中的信息相互回填调用方法，社团成立登记页面中调用
function meetingInteractive(sourceFielValue,toFieldName,sourceDs,toDs,toDsFieldName){
	$(toFieldName).value = sourceFielValue;
	var toDsObj = L5.DatasetMgr.lookup(toDs);
	toDsObj.set(toDsFieldName,sourceFielValue);
}


function calSessionDate(){
	var tenure = _$("tenure");
	var startDate = _$("startDate");
	if(tenure!="" && startDate!=""){
		var startYear = startDate.split("-")[0];
		var endYear = parseInt(startYear,10)+parseInt(tenure,10);
		var endDate = endYear+"-"+startDate.split("-")[1]+"-"+startDate.split("-")[2];
		$("endDate").value = endDate;
		somSessionDataSet.set("endDate",endDate);
	}
}
