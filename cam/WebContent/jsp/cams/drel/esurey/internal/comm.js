//将家庭ID数组拼接成用逗号隔开的字符串
function addFamilyIds(arr){
	var familyIds="";
	if(arr.length>1){
		familyIds=arr[0];
		for(var i = 1; i < arr.length; i++) {
			familyIds=familyIds+","+arr[i];
		}
	}else {
		familyIds=arr[0];
	}
	return familyIds;
}
//返回待核对家庭列表
function returnList(){
	L5.forward('jsp/cams/drel/esurey/internal/esureyInfoCheckIssueQuery.jsp');
}
