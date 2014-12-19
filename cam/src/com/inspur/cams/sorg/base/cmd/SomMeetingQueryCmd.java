package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;

public class SomMeetingQueryCmd extends BaseQueryCommand{
	private ISomMeetingDomain somMeetingDomain = ScaComponentFactory.getService
		(ISomMeetingDomain.class, "somMeetingDomain/somMeetingDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somMeetingDomain.query(pset);
		
	}
	
	/**
	 * 通过会议关联章程、会费、负责人换届是否进行过，需要查询换届备案已经完成的
	 * @return
	 */
	public DataSet qurtyWithBeianInfo() {
		ParameterSet pset = getParameterSet();
		return somMeetingDomain.qurtyWithBeianInfo(pset);
		
	}
}
