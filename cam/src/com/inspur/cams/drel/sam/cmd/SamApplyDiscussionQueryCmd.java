package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
/**
 * @title:评议结果Command
 * @description:
 * @author:	yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamApplyDiscussionQueryCmd extends BaseQueryCommand{
	ISamApplyDiscussionDomain samApplyDiscussionDomain = ScaComponentFactory.getService(ISamApplyDiscussionDomain.class, "samApplyDiscussionDomain/samApplyDiscussionDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplyDiscussionDomain.query(pset);
	}
}
