package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplyOptionsHisDomain;
/**
 * @title:申请审批历史意见Command
 * @description:	
 * @author:	yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamApplyOptionsHisQueryCmd extends BaseQueryCommand{
	private ISamApplyOptionsHisDomain samApplyOptionsHisDomain = ScaComponentFactory.getService(ISamApplyOptionsHisDomain.class, "samApplyOptionsHisDomain/samApplyOptionsHisDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplyOptionsHisDomain.query(pset);
	}
}
