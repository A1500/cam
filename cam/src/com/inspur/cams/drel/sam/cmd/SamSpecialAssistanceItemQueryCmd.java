package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.drel.sam.domain.ISamSpecialAssistanceItemDomain;

/**
 * @title:SamSpecialAssistanceItemQueryCommand
 * @description:
 * @author douyn
 * @since:2012-05-17
 * @version:1.0
*/
public class SamSpecialAssistanceItemQueryCmd extends BaseQueryCommand{
	ISamSpecialAssistanceItemDomain service = ScaComponentFactory.getService(ISamSpecialAssistanceItemDomain.class, 
	"samSpecialAssistanceItemDomain/samSpecialAssistanceItemDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	public DataSet queryById(){
		ParameterSet pset = getParameterSet();
		String id =  (String) pset.getParameter("ITEM_ID");
		return service.queryById(id);
	}
	
}
