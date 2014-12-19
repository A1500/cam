package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamPeopleExtendDomain;

/**
 * @title:人员扩展信息（低保用）Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamPeopleExtendQueryCmd extends BaseQueryCommand{
	private ISamPeopleExtendDomain samPeopleExtendDomain = ScaComponentFactory.getService(ISamPeopleExtendDomain.class, "samPeopleExtendDomain/samPeopleExtendDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samPeopleExtendDomain.query(pset);
	}
}
