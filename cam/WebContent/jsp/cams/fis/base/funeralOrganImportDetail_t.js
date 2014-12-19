function init() {
	ds.setParameter("RECORD_ID", recordId);
	ds.on('load',function(){
		if(ds.getCount() >=0 && ifFile=='0') {
			alert(ds.getAt(0).get("desc")=='')
			document.getElementById("content").innerText = ds.getAt(0).get("desc");
		}
	});
	ds.load();
}