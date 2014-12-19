package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem;
import com.inspur.cams.drel.sam.domain.ISamSpecialAssistanceItemDomain;

/**
 * @title:SamSpecialAssistanceItemCommand
 * @description:
 * @author douyn
 * @since:2012-05-17
 * @version:1.0
*/
public class SamSpecialAssistanceItemCmd extends BaseAjaxCommand{
	private ISamSpecialAssistanceItemDomain service = ScaComponentFactory.getService(ISamSpecialAssistanceItemDomain.class, 
	"samSpecialAssistanceItemDomain/samSpecialAssistanceItemDomain");
	
	public void save(){
		Record record = (Record) getParameter("record");
		SamSpecialAssistanceItem item = (SamSpecialAssistanceItem) record.toBean(SamSpecialAssistanceItem.class);
		service.save(item);		
	}
}
