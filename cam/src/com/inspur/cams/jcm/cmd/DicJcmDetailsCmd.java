package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.DicJcmDetails;
import com.inspur.cams.jcm.domain.IDicJcmDetailsDomain;

/**
 * 字典详细信息cmd
 * @author 
 * @date 2014-05-22
 */
public class DicJcmDetailsCmd extends BaseAjaxCommand {

	private IDicJcmDetailsDomain dicJcmDetailsDomain = ScaComponentFactory
			.getService(IDicJcmDetailsDomain.class, "dicJcmDetailsDomain/dicJcmDetailsDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicJcmDetails dicJcmDetails = (DicJcmDetails) record.toBean(DicJcmDetails.class);
		dicJcmDetailsDomain.insert(dicJcmDetails);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicJcmDetails dicJcmDetails = (DicJcmDetails) record.toBean(DicJcmDetails.class);
		dicJcmDetailsDomain.update(dicJcmDetails);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicJcmDetailsDomain.delete(code);
	}
	public void save(){
		List<DicJcmDetails> equList = new ArrayList<DicJcmDetails>();
		
		Record[] records = (Record[]) getParameter("records");
		if(records!=null){
			for(int i=0;i<records.length;i++){
				DicJcmDetails dicJcmDetails = (DicJcmDetails) records[i].toBean(DicJcmDetails.class);
				equList.add(dicJcmDetails);
			}
		}
		dicJcmDetailsDomain.save(equList);
	}
}