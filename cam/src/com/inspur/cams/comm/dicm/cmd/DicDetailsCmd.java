package com.inspur.cams.comm.dicm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.data.DicDetails;
import com.inspur.cams.comm.dicm.domain.IDicDetailsDomain;

/***
 * 字典详细信息维护command
 * @author luguosui
 * @date 2011-8-31
 */
public class DicDetailsCmd extends BaseAjaxCommand {

	@Reference
	private IDicDetailsDomain dicDetailsDomain=ScaComponentFactory.getService(IDicDetailsDomain.class, "DicDetailsDomain/DicDetailsDomain");

	public void insert(){
		Record record=(Record)getParameter("record");
		DicDetails dicDetails=(DicDetails)record.toBean(DicDetails.class);
		dicDetailsDomain.insert(dicDetails);
	}
	
	public void save(){
		Record[] records=(Record[])getParameter("records");
		List<DicDetails> list =new ArrayList<DicDetails>();
		
		for(int i=0;i<records.length;i++){
			DicDetails dicDetails=(DicDetails)records[i].toBean(DicDetails.class);
			list.add(dicDetails);
		}
		dicDetailsDomain.save(list);
	}
	
	public void update(){
		Record record = (Record)getParameter("record");
		DicDetails dicDetails=(DicDetails)record.toBean(DicDetails.class);
		dicDetailsDomain.update(dicDetails);
	}
}
