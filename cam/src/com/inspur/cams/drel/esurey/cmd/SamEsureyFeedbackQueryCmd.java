package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
/**
 * @title:SamEsureySocialCommand
 * @description:经济核对_外部单位填报信息Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.domain.ISamEsureyFeedbackDomain;

public class SamEsureyFeedbackQueryCmd extends BaseQueryCommand {
	
	private ISamEsureyFeedbackDomain service = ScaComponentFactory.getService(
			ISamEsureyFeedbackDomain.class, "SamEsureyFeedbackDomain/SamEsureyFeedbackDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
